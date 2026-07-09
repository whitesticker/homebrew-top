cask "top" do
  version "0.1.0"
  sha256 "46370fc1ac938309d3724e52cbaa236e77d5fd46dbd43b08b9f6265a60d80b19"

  url "https://github.com/whitesticker/top/releases/download/v#{version}/top-#{version}.zip"
  name "top"
  desc "Lightweight native macOS menu bar system monitor"
  homepage "https://github.com/whitesticker/top"

  depends_on macos: ">= :ventura"

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
