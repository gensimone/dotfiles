{
  inputs.nixpkgs.url = github:NixOS/nixpkgs/nixos-25.11;
  outputs = { self, nixpkgs }: {
    nixosConfigurations.latitude5400 = nixpkgs.lib.nixosSystem {
      modules = [ ./machines/latitude5400/configuration.nix ];
    };
  };
}
