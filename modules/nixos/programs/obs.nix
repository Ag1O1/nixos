{pkgs, ...}: {
  programs.obs-studio = {
    enable = true;
    plugins = [pkgs. obs-studio-plugins.obs-pipewire-audio-capture];
  };
}
