# My Nix Derivations
Take what you like. They're open source, after all.

`coin-clicker-reborn`: Idle game I'm working on. **Note: This package will NOT be maintained until I deem it necessary to create a tag. This is just a proof of concept. If you wish to run Coin Clicker Reborn with Nix, use the repo's flake with `nix run`.** [repo](https://codeberg.org/solarfire/coin-clicker-reborn)

`headset-battery-indicator`: Uses [HeadsetControl](https://github.com/Sapd/HeadsetControl) to show your headset's battery level in the system tray. Works with GNOME, Plasma, XFCE, and Cinnamon. [repo](https://github.com/ruflas/headset-battery-indicator)

`ioquake3`: Modern Quake III Arena engine. Rewrite of [the original nixpkg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/io/ioquake3/package.nix) that updates the commit hash to a significantly newer one and updates the build system to the newer CMake one. Also adds a custom flag that changes the game's directory to `/home/solarfire/.local/share/Quake3`. You will need to update the username yourself in the deriv. [repo](https://github.com/ioquake/ioq3)
  
`ironwail`: QuakeSpasm fork focused on maximum map performance. Mostly copied from [the original nixpkg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ir/ironwail/package.nix) except for a more fleshed-out .desktop file that includes the missing icon and description. Also adds a custom flag that changes the game's directory to `/home/solarfire/.local/share/ironwail`. You will need to update the username yourself in the deriv. [repo](https://github.com/andrei-drexler/ironwail)
  
`kate-discord-rpc`: Discord RPC plugin for the Plasma text editor Kate. [repo](https://github.com/leia-uwu/kate-discord-rpc)
  
`miracode`: The vectorized Minecraft-based font Miracode, patched with thousands of additional Nerd Font glyphs. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/blob/master/FontPatcher.zip), [Miracode](https://github.com/IdreesInc/Miracode)
