import { NotificationPopups } from "./notificationPopups.js"
const hyprland = await Service.import("hyprland")
// const notifications = await Service.import("notifications")
const mpris = await Service.import("mpris")
const audio = await Service.import("audio")
const battery = await Service.import("battery")
const systemtray = await Service.import("systemtray")
const network = await Service.import("network")

const date = Variable("", {
    // poll: [1000, 'date "+%I:%M %p %b %e.  "'],
    poll: [1000, 'date "+%a %d %b, %I:%M %p "'],
})

// widgets can be only assigned as a child in one container
// so to make a reuseable widget, make it a function
// then you can simply instantiate one by calling it
function Test() {


    return Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client.bind("title"),
    })
}

/*function Workspaces() {
    const activeId = hyprland.active.workspace.bind("id")
    const workspaces = hyprland.bind("workspaces")
        .as(ws => ws.map(({ id }) => Widget.Button({
            on_clicked: () => hyprland.messageAsync(`dispatch workspace ${id}`),
            child: Widget.Label(`${id}`),
            class_name: activeId.as(i => `${i === id ? "focused" : ""}`),
        })))

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
    })
}*/
function Workspaces() {
    const dispatch = (/** @type {number} */ ws) => hyprland.messageAsync(`dispatch workspace ${ws}`)
    const workspaces = Array.from({ length: 10 }, (_, i) => i + 1).map(i => Widget.Button({
        attribute: i,
        label: `${i}`,
        onClicked: () => dispatch(i),
    }))

    return Widget.Box({
        class_name: "workspaces",
        children: workspaces,
        setup: self => self.hook(hyprland, () => self.children.forEach(btn => {
            btn.visible = hyprland.workspaces.some(ws => ws.id === btn.attribute);
            btn.toggleClassName("focused", hyprland.active.workspace.id == btn.attribute);
        })),
    })
}

function ClientTitle() {
    return Widget.Label({
        class_name: "client-title",
        label: hyprland.active.client.bind("title"),
    })
}


function Clock() {
    return Widget.Label({
        class_name: "clock",
        label: date.bind(),
    })
}


// we don't need dunst or any other notification daemon
// because the Notifications module is a notification daemon itself
//function Notification() {
//    const popups = notifications.bind("popups")
//    return Widget.Box({
//        class_name: "notification",
//        visible: popups.as(p => p.length > 0),
//        children: [
//            Widget.Icon({
//                icon: "preferences-system-notifications-symbolic",
//            }),
//            Widget.Label({
//                label: popups.as(p => p[0]?.summary || ""),
//            }),
//        ],
//    })
//}


function Media() {
    const label = Utils.watch("", mpris, "player-changed", () => {
        if (mpris.players[0]) {
            const { track_artists, track_title } = mpris.players[0]
            return `${track_artists.join(", ")} - ${track_title}`
        } else {
            return "Nothing is playing"
        }
    })

    return Widget.Button({
        class_name: "media",
        on_primary_click: () => mpris.getPlayer("")?.playPause(),
        on_scroll_up: () => mpris.getPlayer("")?.next(),
        on_scroll_down: () => mpris.getPlayer("")?.previous(),
        child: Widget.Label({ label }),
    })
}


function Volume() {
    const icons = {
        101: "overamplified",
        67: "high",
        34: "medium",
        1: "low",
        0: "muted",
    }

    function getIcon() {
        const icon = audio.speaker.is_muted ? 0 : [101, 67, 34, 1, 0].find(
            threshold => threshold <= audio.speaker.volume * 100)

        return `audio-volume-${icons[icon]}-symbolic`
    }

    const icon = Widget.Icon({
        icon: Utils.watch(getIcon(), audio.speaker, getIcon),
    })

    const slider = Widget.Slider({
        hexpand: true,
        draw_value: false,
        on_change: ({ value }) => audio.speaker.volume = value,
        setup: self => self.hook(audio.speaker, () => {
            self.value = audio.speaker.volume || 0
        }),
    })

    return Widget.Box({
        class_name: "volume",
        css: "min-width: 180px",
        children: [icon, slider],
    })
}


function BatteryLabel() {
    const value = battery.bind("percent").as(p => p > 0 ? p / 100 : 0)
    const icon = battery.bind("percent").as(p =>
        `battery-level-${Math.floor(p / 10) * 10}-symbolic`)

    return Widget.Box({
        class_name: "battery",
        visible: battery.bind("available"),
        children: [
            Widget.Icon({ icon }),
            Widget.LevelBar({
                widthRequest: 140,
                vpack: "center",
                value,
            }),
        ],
    })
}


function SysTray() {
    const items = systemtray.bind("items")
        .as(items => items.map(item => Widget.Button({
            child: Widget.Icon({ icon: item.bind("icon") }),
            on_primary_click: (_, event) => item.activate(event),
            on_secondary_click: (_, event) => item.openMenu(event),
            tooltip_markup: item.bind("tooltip_markup"),
        })))

    return Widget.Box({
        children: items,
    })
}


function WifiIndicator() {
    return Widget.Icon({
        icon: network.wifi.bind('icon_name'),
    })
}

function WiredIndicator() {
    return Widget.Icon({
        icon: network.wired.bind('icon_name'),
    })
}

function Network() {
    return Widget.Box({
        class_name: "sysicon",
        vertical: true,
        children: [
            Widget.Button({
                class_name: "network",
                child: Widget.Stack({
                    children: {
                        wifi: WifiIndicator(),
                        wired: WiredIndicator(),
                    },
                    shown: network.bind('primary').as(p => p || 'wifi'),
                }),
                on_primary_click: (_, __) => Utils.subprocess(['nm-connection-editor'])
            })
        ],
    })
}

// layout of the bar
function Left() {
    return Widget.Box({
        spacing: 10,
        children: [
            Workspaces(),
            //Media(),
            ClientTitle(),
        ],
    })
}

function Center() {
    return Widget.Box({
        spacing: 8,
        children: [
            Clock(),
            //ClientTitle(),
            //Notification(),
        ],
    })
}

function Right() {
    return Widget.Box({
        hpack: "end",
        spacing: 15,
        children: [
            /*Test(),*/
            SysTray(),
            Volume(),
            BatteryLabel(),
            
            
        ],
    })
}

function Bar(monitor = 0) {
    return Widget.Window({
        name: `bar-${monitor}`, // name has to be unique
        class_name: "bar",
        monitor,
        anchor: ["top", "left", "right"],
        exclusivity: "exclusive",
        child: Widget.CenterBox({
            start_widget: Left(),
            center_widget: Center(),
            end_widget: Right(),
        }),
    })
}

import { applauncher } from "./applauncher.js"

App.config({
    style: "./style.css",
    windows: [
        NotificationPopups(),
        applauncher,
        Bar(0)
    ],
})

export { }
