{
    config,
    pkgs,
    lib,
    ...
}:
{
    imports = [
        ./pipewire.nix
        ./greetd.nix
    ];
}
