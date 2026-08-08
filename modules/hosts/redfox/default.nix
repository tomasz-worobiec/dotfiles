{
  self,
  inputs,
  withSystem,
  ...
}:
let
  system = "x86_64-linux";
  hostname = "redfox";
in
{
  flake.nixosConfigurations."${hostname}" = inputs.nixpkgs.lib.nixosSystem {
    inherit system;

    modules = [
      self.nixosModules."${hostname}Configuration"
    ];

    specialArgs = {
      inherit hostname;
    };
  };

  flake.homeConfigurations."tom@${hostname}" = withSystem "${system}" (
    { pkgs, ... }:
    inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs;

      modules = [
        self.homeModules."${hostname}Home"
      ];

      extraSpecialArgs = {
        inherit hostname;
        username = "tom";
        resources = inputs.resources;
      };
    }
  );
}
