cask "wsddn" do
  version "1.25"
  sha256 "5c48776bf8906e560a16e4b730478cf9bd56d6b75b07b585e7afcbf464ad61d9"

  url "https://github.com/gershnik/wsdd-native/releases/download/v#{version.major_minor}/wsddn-macos-#{version.major_minor}.pkg"
  name "WS-Discovery Host Daemon"
  desc "Allows your Mac to be discovered by systems running Windows 10 or later and to appear in their Explorer \"Network\" view."
  homepage "https://github.com/gershnik/wsdd-native"

  livecheck do
    url "https://github.com/gershnik/wsdd-native/releases.atom"
    regex(%r{<id>tag:github\.com,2008:Repository/[0-9]+/v([0-9.]+)</id>}i)
    strategy :page_match
  end

  depends_on macos: :catalina

  pkg "wsddn-macos-#{version.major_minor}.pkg"

  uninstall launchctl: "io.github.gershnik.wsddn",
            script:    {
              executable: "/bin/bash",
              args:       ["-c", "dscl . -delete /Users/_wsddn; dscl . -delete /Groups/_wsddn; exit 0"],
              sudo:       true,
            },
            pkgutil:   "io.github.gershnik.wsddn"

  zap delete: "/etc/wsddn.conf"
end
