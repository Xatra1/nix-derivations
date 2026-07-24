# My Nix Derivations
Take what you like. They're open source, after all.

`ventoy/`: Tool to create a bootable drive for chainloading ISO files. Rewrite of [the original nixpkg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ve/ventoy/package.nix) to update it from 1.1.12 to the latest release, and slim it down to only contain Ventoy2Disk. Also installs parted, which is required for GPT installs. [repo](https://github.com/ventoy/Ventoy)

**Disclaimer:** Ventoy contains binary blobs which cannot be 100% trusted to be compliant to their licenses or free of malware, but the Ventoy team claims that they are all open source and has done their best to document them [here.](https://github.com/ventoy/Ventoy/blob/master/BLOB_List.md)

`ioquake3.nix`: Modern Quake III Arena engine. Rewrite of [the original nixpkg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/io/ioquake3/package.nix) that updates the commit hash to a significantly newer one and updates the build system to the newer CMake one. Also adds a custom flag that changes the game's directory to `/home/solarfire/.local/share/Quake3`. You will need to update the username yourself in the deriv. [repo](https://github.com/ioquake/ioq3)
  
`ironwail.nix`: QuakeSpasm fork focused on maximum map performance. Mostly copied from [the original nixpkg](https://github.com/NixOS/nixpkgs/blob/nixos-unstable/pkgs/by-name/ir/ironwail/package.nix) except for a more fleshed-out .desktop file that includes the missing icon and description. Also adds a custom flag that changes the game's directory to `/home/solarfire/.local/share/ironwail`. You will need to update the username yourself in the deriv. [repo](https://github.com/andrei-drexler/ironwail)
  
`kate-discord-rpc.nix`: Discord RPC plugin for the Plasma text editor Kate. [repo](https://github.com/leia-uwu/kate-discord-rpc)
  
`miracode.nix`: The vectorized Minecraft-based font Miracode, patched with thousands of additional Nerd Font glyphs. [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts/blob/master/FontPatcher.zip), [Miracode](https://github.com/IdreesInc/Miracode)
