cask "vella" do
  version "2.1.0"
  sha256 "b4ba0d07a89e33b6b869e0d5d97a1ecb510a6534d26fb12998eb9cc99945b23e"

  url "https://github.com/TobyNoSkillSon/Vella/releases/download/v#{version}/Vella-#{version}-arm64.zip"
  name "Vella"
  desc "Offline dictation and live transcription"
  homepage "https://tobynoskillson.com/vella"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Vella.app"
  binary "#{appdir}/Vella.app/Contents/Helpers/vella"

  # Vella is signed with its own certificate, not notarized: clear the download flag so Gatekeeper does not block
  # the first launch, as the curl installer does.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Vella.app"]
  end

  uninstall quit: "dev.vella.dictation"

  zap trash: [
    "~/Library/Application Support/Vella",
    "~/Library/Caches/dev.vella.dictation",
    "~/Library/HTTPStorages/dev.vella.dictation",
    "~/Library/Preferences/dev.vella.dictation.plist",
  ]
end
