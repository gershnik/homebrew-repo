cask "wsddn" do
  version "1.6"
  sha256 "33efb063660a2a631b885af3e72bd5f9a976547dad7726d5b34c36325a04a52c"

  url "https://github.com/gershnik/wsdd-native/releases/download/v#{version}/wsddn-macos-#{version}.pkg" 
  name "WS-Discovery Host Daemon"
  desc "Allows your Mac to be discovered by Windows 10 and above systems and displayed by their Explorer \"Network\" views."
  homepage "https://github.com/gershnik/wsdd-native"
  
  livecheck do
    url "https://github.com/gershnik/wsdd-native/releases.atom"
    regex(%r{\<id\>tag:github.com,2008:Repository/[0-9]+/v([0-9.]+)\</id\>}i)
    strategy :page_match
  end
  
  depends_on macos: ">= :catalina"

  pkg "wsddn-macos-#{version}.pkg"

  uninstall launchctl: "io.github.gershnik.wsddn",
            pkgutil: "io.github.gershnik.wsddn",
            script: {
              executable:   "bash",
              args:         ["-c", "dscl . -delete /Users/_wsddn; dscl . -delete /Groups/_wsddn; exit 0"],
              sudo:         true
            }
            
  zap delete: "/etc/wsddn.conf"
end