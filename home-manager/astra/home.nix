# vi: sw=2 ts=2 et
{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home-manager
    ../../profiles/astra/options.nix
  ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "${config.devlive.user.name}";
  home.homeDirectory = "/home/${config.devlive.user.name}";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    aegisub
    libreoffice
    popcorntime
    wireshark
    wl-clipboard
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/astra/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    EDITOR = "vim";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.git = {
    enable = true;
    userEmail = "${config.devlive.user.email}";
    userName = "${config.devlive.user.fullName}";
    extraConfig = {
      commit = {
        gpgsign = true;
      };
      tag = {
        forceSignAnnotated = true;
      };
      user = {
        signingkey = "A6113EB4F50442EA";
      };
    };
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      "balitekno.admin.vpn.devlive.cloud" = {
        hostname = "balitekno.admin.vpn.devlive.cloud";
        port = 22;
        user = "astra";
        identityFile = "~/.private/id_ed25519_rhel";
      };
      "bitbucket.stack.devlive.cloud" = {
        hostname = "bitbucket.stack.devlive.cloud";
        port = 22;
        user = "git";
        identityFile = "~/.private/id_ed25519_bitbucket_ts";
      };
      "firewall.admin.vpn.devlive.cloud" = {
        hostname = "firewall.admin.vpn.devlive.cloud";
        port = 2222;
        user = "puffy";
        identityFile = "~/.private/id_ed25519_rhel";
      };
      "gitlab.com" = {
        hostname = "gitlab.com";
        port = 22;
        user = "astrawan";
        identityFile = "~/.private/id_gitlab_new";
      };
      "github.com" = {
        hostname = "github.com";
        port = 22;
        user = "git";
        identityFile = "~/.private/id_ed25519_bitbucket_ts";
      };
    };
  };
}
