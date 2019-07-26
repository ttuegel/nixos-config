{ pkgs, ... }:

let
  lorri = import ../lorri { inherit pkgs; };
in

{
  environment.systemPackages = [ lorri ];
}
