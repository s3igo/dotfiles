{ lib, swift }:

swift.stdenv.mkDerivation (finalAttrs: {
  pname = "im-select-swift";
  version = "0.1.0";

  dontUnpack = true;
  dontConfigure = true;

  src = builtins.toFile "main.swift" ''
    import InputMethodKit

    func getCurrentInputSourceID() -> String? {
      guard
        let currentSource = TISCopyCurrentKeyboardInputSource()?
          .takeRetainedValue(),
        let propertyPtr = TISGetInputSourceProperty(
          currentSource, kTISPropertyInputSourceID)
      else { return nil }
      return Unmanaged<CFString>.fromOpaque(propertyPtr).takeUnretainedValue()
        as String
    }

    func switchToInputSource(id: String) -> Bool {
      let filter = [kTISPropertyInputSourceID: id] as CFDictionary
      guard
        let sourceList = TISCreateInputSourceList(filter, false)?
          .takeRetainedValue(), CFArrayGetCount(sourceList) > 0
      else { return false }
      let inputSource = unsafeBitCast(
        CFArrayGetValueAtIndex(sourceList, 0), to: TISInputSource.self)
      return TISSelectInputSource(inputSource) == noErr
    }

    func main() {
      guard let currentID = getCurrentInputSourceID() else { exit(1) }

      if CommandLine.arguments.count <= 1 {
        print(currentID)
        exit(0)
      }

      let targetID = CommandLine.arguments[1]

      if currentID == targetID {
        print(targetID)
        exit(0)
      }

      if switchToInputSource(id: targetID) { print(targetID) } else { exit(1) }
    }

    main()
  '';

  nativeBuildInputs = [ swift ];

  buildPhase = ''
    runHook preBuild

    swiftc -O -Xlinker -dead_strip $src -o ${finalAttrs.pname}

    runHook postBuild
  '';

  installPhase = ''
    runHook preInstall

    mkdir -p $out/bin
    cp ${finalAttrs.pname} $out/bin

    runHook postInstall
  '';

  meta = {
    mainProgram = "im-select-swift";
    platforms = lib.platforms.darwin;
  };
})
