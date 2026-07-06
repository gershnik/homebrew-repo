cask "wsddn" do
  version "1.26"
  sha256 "11caeb7694bf1a8723da5d080753a8643f2a5d36e90acae34f090dc7bbd940d0"

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
