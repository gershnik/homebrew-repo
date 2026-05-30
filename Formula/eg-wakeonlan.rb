class EgWakeonlan < Formula
  desc "Advanced wake-on-lan command-line utility"
  homepage "https://github.com/gershnik/wakeonlan"
  url "https://files.pythonhosted.org/packages/3d/3e/5119cb9ea4f1bc97aa02bef87385a59360e5a343f75e3894a4c906f138b9/eg_wakeonlan-2.0.tar.gz"
  sha256 "84c3d55a25709b955aface0f8b0ed38fe9a8dfd07344d1845128b400c3bc6bc3"
  license "BSD-3-Clause"

  # any brew python — only used as a "python3 must exist" gate
  depends_on "python"

  conflicts_with "wakeonlan",
    because: "both install a `wakeonlan` executable"

  def install
    # Install the package files to libexec so they're not on sys.path globally
    system "python3", "-m", "pip", "install",
           "--target=#{libexec}",
           "--no-deps", "--no-compile",
           "."
    (bin/"wakeonlan").write <<~PY
      #!/usr/bin/env python3
      import os, sys
      sys.path.insert(0, os.path.join(
          os.path.dirname(os.path.realpath(__file__)), "..", "libexec"))
      from wakeonlan.wakeonlan import main
      sys.exit(main())
    PY
    chmod 0755, bin/"wakeonlan"
  end

  test do
    assert_match "MAC", shell_output("#{bin}/wakeonlan --help")
  end
end
