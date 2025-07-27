{ config, ... }:

{
  users.users.${config.devlive.user.name} = {
    isNormalUser = true;
    description = "${config.devlive.user.fullName}";
    extraGroups = config.devlive.user.groups;
    packages = config.devlive.user.packages;
  };
}
