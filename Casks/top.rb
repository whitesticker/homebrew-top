cask "top" do
  version "0.3.0"
  sha256 "6032d571ceb539ea4970572eb9811f9620d2ceb4b471af626ce656756f0a90d3"

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
    "~/Library/Preferences/com.local.top.widgets.plist",
    "~/Library/Group Containers/XXA24FWXDW.com.local.top.widgets",
    "~/Library/Containers/com.local.top.TopWidgetExtension",
  ]
end
