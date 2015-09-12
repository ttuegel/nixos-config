{ fetchurl, stdenv, SDL, SDL_image, SDL_mixer, zlib, ed }:

let
  mods = {
    base = "94b0475c7c161d4fdb59a9ebe0d740ec07b1934abf348d78d4f127f369d912f8";
    acerspyro = "18718286a72298b0a016d147524bc53094c4ad3897859ec8422131b5acc9bd3f";
    actors = "34825b5bb7f79bf9518e5e48f01ecb720cc559bb969575b93da05b5305c209cb";
    appleflap = "05c5aae92779ef8b6feb74ee396d27001aa8692610c35b33421419dd0d0bc4b2";
    blendbrush = "c0fb3257fd4a9b425bfa015ff0126807af85dbada89223765689e618ad7d4b72";
    caustics = "25b0366b0e434049d382fdeda0b62e38a7fdadf398d714713d829908f10dbb3f";
    crosshairs = "732e0a874ad39d4ee329e4b82badd8e3b513ad4a5a6f7ea5c5c2d30a42839e6e";
    elyvisions = "29d8554151789578cbce17718d911c36e3453ee3b700b96b4ca0b9d4f2391468";
    fonts = "b88246a3a194afd0e3928d447d9e49c8869ce157c005dca2ad7610479344f62a";
    freezurbern = "9669ca25a3cdffaf6172829a1e04dad51f43bf4bd98b794d1574a18dded0c078";
    john = "8d02259d0878b91c2c16b8c323f2bbf8fba521a5694f9bb160ca5f7c32b0bcd2";
    jojo = "a97b45a1e095c11f1b9b5c34ed2f28e6427a784c56fc0a143288638a59cc036a";
    jwin = "539873a19cbafd10499959619199791ebc6feabcde20c4db1e9298dea14c85e4";
    luckystrike = "21516564ba832507ecb93f05d03e662bd4dc0944d7bc800bc1127c96d941b823";
    maps = "71a79ec665e99268637952bd883afcda02345c9944494822fe96b45511c410b8";
    mayhem = "95a9ce7bfa8bc4e38da8197ef85e530e312ba040cf772bae99e84745cc95c9c2";
    mikeplus64 = "57a92abff536d459e413d424e8a948c2951a7f476dbb00831bf54ddfedff42ce";
    misc = "aec506cf659452a717430fe6104e0624eac5bd59f22c64ca5033d65cb4fc15de";
    nobiax = "159e98527ea953e1af8f49808ad61f34d08189b720e070463ff88a4a044b3622";
    particles = "759b46e2d8edc2ac893dd8fce8820b208789d9bc2c63679db35366b88d1e8d71";
    philipk = "ea4daa2e02c13bbb8d0ba18ad7d3dfdc0f39355dccc36c556bbaec88aeaa13e8";
    projectiles = "d2beb17e7b7928718d5c4d9697238027523ddd6a2f168d900b8d599d93ceb075";
    props = "79f474367f808faa7293e73851e0331a354760db0dd0b8d061f1d74b921a70e9";
    skyboxes = "f17df31c857abd7106159e82ba92b252db8ce68df21a893023d3017d8d2ac943";
    sounds = "ebcc960b5e3ecee80e04aec8335554ffdb36ecc030791666903a85cad469dede";
    textures = "a59c604d134bf0e82d31340878c4790060dc82f7a4417ada1d7782da09b3ae3f";
    torley = "4607d60be7080b0ac5c6ef801f158d2ba6e79982e9861eecdd15698a5c2d31b3";
    trak = "78e9bb131fe144b516ce29be6c9f64f2991731e49935576caa3ed999ca2fd377";
    ulukai = "638fb7ac0e0d8eb1f13c7a01d00d31ce7844c06d8907ad2a20ea571b094b3b7e";
    unnamed = "bd7da14d9e715d6dcc2687921f668739d0ba45a9f01350c1b5347e956648a242";
    vanities = "bcd9a0f22314c0bb98fc193f18f04a3cc9f1aa6b83c70a02de34b779cc166ce1";
    vegetation = "c076f3f50caac5bec5889fc8e11028882b7a39cee8560684918c3a0eb847228d";
    weapons = "23d70fb68fe34ba9c952f74b2ec6ca30b9dda8664248db10f5b434cb9c3516be";
    wicked = "0fc5a75c6b0a2a9c90a664e2b9ec958928b3059f03e90228cca547f376532b61";
  };
  
  createModItem = version: modName: {
    name = modName;
    value = fetchurl {
      name = "${modName}-${version}.tar.gz";
      url = "https://github.com/red-eclipse/${modName}/archive/v${version}.tar.gz";
      sha256 = builtins.getAttr modName mods;
    };
  };
  
  makeModList = version:
    let
      modNames = builtins.attrNames mods;
      modList = builtins.map
        (createModItem version)
        modNames;
    in
      builtins.listToAttrs modList;

  sources = version: makeModList version;
in
  stdenv.mkDerivation rec {
    name = "red-eclipse-${version}";
    version = "1.5.3";

    sourceRoot = "base-${version}";

    srcs = builtins.attrValues (sources version);
      
    buildInputs = [SDL SDL_image SDL_mixer zlib ed];
    
    preBuild = ''
      for i in \
        acerspyro actors appleflap blendbrush caustics crosshairs elyvisions \
        fonts freezurbern john jojo jwin luckystrike maps mayhem mikeplus64 misc \
        nobiax particles philipk projectiles props skyboxes sounds textures \
        torley trak ulukai unnamed vanities vegetation weapons wicked
      do
        rmdir "data/$i"
        mv "../$i-${version}" "data/$i"
      done
    '';
    
    buildPhase = ''
      runHook preBuild;
      make ''${enableParallelBuilding:+-j''${NIX_BUILD_CORES} -l''${NIX_BUILD_CORES}} -C src/ prefix=$out system-install
    '';
    
    installPhase = ''
    
    '';
  }
