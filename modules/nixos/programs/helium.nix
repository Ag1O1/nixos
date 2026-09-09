{inputs, ...}: {
  imports = [inputs.helium-flake.nixosModules.default];
  programs.helium = {
    enable = true;

    flags = [
      "--disable-gpu"
      "--ozone-platform-hint=auto"
    ];

    policies = {
      "BrowserSignin" = 0;
      "PasswordManagerEnabled" = false;
      "SyncDisabled" = true;
      "DefaultSearchProviderEnabled" = true;
      "DefaultSearchProviderSearchURL" = "https://searxng.amr-ashraf.me/search?q={searchTerms}";
      "SpellcheckEnabled" = true;
      "SpellcheckLanguage" = ["en-US"];
    };
  };
}
