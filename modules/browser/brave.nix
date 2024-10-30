{
    config,
    pkgs,
    pkgs-unstable,
    stylix,
    ...
}:
{
    programs.chromium = {
        enable = true;
        package = pkgs.brave;
    };
}
