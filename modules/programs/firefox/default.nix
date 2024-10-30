{
  config,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
with lib;
let
  cfg = config.modules.programs.firefox;
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
in
{
  options.modules.programs.firefox = {
    enable = lib.mkEnableOption "firefox";
  };
  config = lib.mkIf cfg.enable {
    programs = {
      firefox = {
        enable = true;
        package = pkgs.firefox-devedition-bin;
        languagePacks = [
          "ar"
          "en-US"
        ];

        # ---- POLICIES ----
        # Check about:policies#documentation for options.
        policies = {
          DisableTelemetry = true;
          DisableFirefoxStudies = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
          DisablePocket = true;
          DisableFirefoxAccounts = true;
          DisableAccounts = true;
          DisableFirefoxScreenshots = true;
          OverrideFirstRunPage = "";
          OverridePostUpdatePage = "";
          DontCheckDefaultBrowser = true;
          DisplayBookmarksToolbar = "never"; # alternatives: "always" or "newtab"
          DisplayMenuBar = "default-off"; # alternatives: "always", "never" or "default-on"
          SearchBar = "unified"; # alternative: "separate"

          # ---- EXTENSIONS ----
          # Check about:support for extension/add-on ID strings.
          # Valid strings for installation_mode are "allowed", "blocked",
          # "force_installed" and "normal_installed".
          ExtensionSettings = {
            "*".installation_mode = "allowed"; # blocks all addons except the ones specified below
            # uBlock Origin:
            "uBlock0@raymondhill.net" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
              installation_mode = "force_installed";
            };
            # Privacy Badger:
            "jid1-MnnxcxisBPnSXQ@jetpack" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
              installation_mode = "force_installed";
            };
            # Dark Reader:
            "addon@darkreader.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4359254/darkreader/latest.xpi";
              installation_mode = "force_installed";
            };
            # Unhook youtube
            "myallychou@gmail.com" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4263531/youtube_recommended_videos/latest.xpi";
              installation_mode = "force_installed"; 
            };
            # Enhancer for youtube
            "enhancerforyoutube@maximerf.addons.mozilla.org" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4263531/enhancer-for-youtube/latest.xpi";
              installation_mode = "force_installed"; 
            };
            # Return youtube dislike
            "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" = {
              install_url = "https://addons.mozilla.org/firefox/downloads/file/4263531/return-youtube-dislikes/latest.xpi";
              installation_mode = "force_installed"; 
            };
          };

          # ---- PREFERENCES ----
          # Check about:config for options.
          Preferences = {
            "browser.contentblocking.category" = {
              Value = "strict";
              Status = "locked";
            };
            "extensions.pocket.enabled" = lock-false;
            "extensions.screenshots.disabled" = lock-true;
            "browser.topsites.contile.enabled" = lock-false;
            "browser.formfill.enable" = lock-false;
            "browser.search.suggest.enabled" = lock-false;
            "browser.search.suggest.enabled.private" = lock-false;
            "browser.urlbar.suggest.searches" = lock-false;
            "browser.urlbar.showSearchSuggestionsFirst" = lock-false;
            "browser.newtabpage.activity-stream.feeds.section.topstories" = lock-false;
            "browser.newtabpage.activity-stream.feeds.snippets" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includePocket" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeBookmarks" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeDownloads" = lock-false;
            "browser.newtabpage.activity-stream.section.highlights.includeVisited" = lock-false;
            "browser.newtabpage.activity-stream.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
            "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
            "sidebar.revamp" = lock-true;
            "sidebar.verticalTabs" = lock-true;
          };
        };
      };
    };
  };
}
