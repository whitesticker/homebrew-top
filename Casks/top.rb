cask "top" do
  version "0.2.0"
  sha256 "8b33c728583072b4fa7d6295eca81f87cff754614d7d3e84e577eb8cda4ce1ad"

  url "https://github.com/whitesticker/top/releases/download/v#{version}/top-#{version}.zip"
  name "top"
  desc "Lightweight native macOS menu bar system monitor"
  homepage "https://github.com/whitesticker/top"

  depends_on macos: :ventura

  app "top.app"

  # Unsigned/ad-hoc build (not notarized) -- strip the quarantine flag on
  # install so users don't hit Gatekeeper's "app is damaged" warning.
  postflight do
    system_command "xattr",
                    args: ["-dr", "com.apple.quarantine", "#{appdir}/top.app"],
                    sudo: false
  end

  zap trash: [
    "~/Library/Preferences/com.local.top.plist",
  ]
end
