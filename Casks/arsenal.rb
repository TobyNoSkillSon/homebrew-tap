cask "arsenal" do
  version "1.0.0"
  sha256 "96e96601f42cfff947ddc1034a04e6ae210a17bbb8c780f13f3ed56a4b44f32c"

  url "https://github.com/TobyNoSkillSon/Arsenal/releases/download/v#{version}/Arsenal-#{version}-arm64.zip"
  name "Arsenal"
  desc "Local AI models for your apps and agents"
  homepage "https://github.com/TobyNoSkillSon/Arsenal"

  livecheck do
    url :url
    strategy :github_latest
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Arsenal.app"
  binary "#{appdir}/Arsenal.app/Contents/Helpers/arsenal-mcp"

  # Arsenal is signed with its own certificate, not notarized: clear the download flag so Gatekeeper does not block
  # the first launch, as the curl installer does.
  postflight_steps do
    run "/bin/chmod", args: ["-R", "u+w", "{{appdir}}/Arsenal.app"]
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Arsenal.app"]
  end

  uninstall quit: "dev.arsenal.app"

  zap trash: [
    "#{appdir}/Arsenal.app.previous",
    "~/Library/Application Support/Arsenal",
    "~/Library/Caches/Arsenal",
    "~/Library/Caches/dev.arsenal.app",
    "~/Library/HTTPStorages/dev.arsenal.app",
    "~/Library/Preferences/dev.arsenal.app.plist",
  ]
end
