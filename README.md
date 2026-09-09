# Nixconf

This is my nix configuration, It has been rewritten multiple times and I have
learned a significant amount of functional language and linux over time with it.

> [!Note]
> This configuration is just for my personal use on my devices. You can
> use it for reference but please don't use the entire config for your setup.
> It's not designed to be used by other people.
> Also, if you use my code it'd be appreciated if you star the repo and
> give me credit.

## Structure

My configuration uses [Haumea](https://github.com/nix-community/haumea) to
automatically load modules into "m." and avoid having to manually write imports
in the configuration, while retaining what i liked about the dendritic pattern
which is being able to reference modules without using paths. flake.nix acts as
the entry point as any other normal nix configuration. Every host has a
packages.nix file for simple packages which do not require a module to
configure. The configuration is made to be simple so I can focus on what I want
in my system rather than on making sure it's perfect. Not everything is done
declaratively (yet), and themes are currently set by
[noctalia](https://github.com/noctalia-dev/noctalia) shell.

| file | description |
| ------ | ----- |
| flake.nix | Main flake |
| secrets/ | Sops secrets |
| modules/ | Main modules |
| -> hosts/ | Contains host specifics |
| -> users/ | Contains user configuration |
| -> nixos/ | Custom nixos modules |
| --> core/ | Main modules which should be used by all hosts |
| --> hardware/ | Hardware related modules |
| --> desktop/ | Window manager configurations |
| --> programs/ | Most program configurations |
| --> services/ | Services, which mainly run in the background |
| --> theming.nix | simple theme related configuration |

## Credits and references

In places where I copy someone else's code or heavily took inspiration from I
will either list here or in that code file. Though, most of these were replaced
by my own logic and are no longer in the current version of my configuration.

[Vimjoyer](https://www.vimjoyer.com/) For sops, wrapped packages, and
impermanent system inspiration

[NotAShelf](https://github.com/NotAShelf) For nvf, hjem, and helping me learn
nix in the past

[Iynaix](https://github.com/iynaix/dotfiles), I took some inspiration from their
config mainly the preservation module.
