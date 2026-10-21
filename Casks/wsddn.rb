cask "wsddn" do
  version "1.28"
  sha256 "63a6f798766d677fca0284f4d8e43c8532a4fa50063b7f8f4fde019fcbddb193"

  url "https://github.com/gershnik/wsdd-native/releases/download/v#{version.major_minor}/wsddn-macos-#{version.major_minor}.pkg"
  name "WS-Discovery Host Daemon"
  desc "Allows your Mac to be discovered by systems running Windows 10 or later and to appear in their Explorer \"Network\" view."
  homepage "https://github.com/gershnik/wsdd-native"

  livecheck do
    url "https://github.com/gershnik/wsdd-native/releases.atom"
    regex(%r{<id>tag:github\.com,2008:Repository/[0-9]+/v([0-9.]+)</id>}i)
    strategy :page_match
  end

  depends_on :macos

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
