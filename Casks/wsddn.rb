cask "wsddn" do
  version "1.9"
  sha256 "8740dc2fcedc503b6e41b3279548f2208883d9274eb40b32ea2e671f1a0be1fb"

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