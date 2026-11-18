# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/browsah.rb.
class Browsah < Formula
  desc "Web browser: GTK4 shell around Chromium (CEF), native Wayland"
  homepage "https://github.com/gregbacchus/browsah"
  version "0.1.6"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.1.6/browsah-0.1.6-linux-x86_64.tar.gz"
    sha256 "36eca31a33143b4d54e97667ae847b7ad822817f9cb8b088806948c07179a969"
  end

  on_arm do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.1.6/browsah-0.1.6-linux-aarch64.tar.gz"
    sha256 "de2f1da892b750bb67e6e24ca7e34279833a84b2e82448512f1c3a9beb99188a"
  end

  def install
    # The binary needs libcef.so and CEF's resource files beside it, so keep the directory whole and
    # put a small launcher on the PATH that points the loader at it. The launcher uses the stable `opt` paths
    # (the versioned Cellar directory is removed by the next upgrade) and tells browsah about them, so the
    # desktop entries it writes keep working after upgrades.
    libexec.install Dir["*"]
    (bin/"browsah").write <<~SH
      #!/bin/sh
      export BROWSAH_LAUNCHER="#{opt_bin}/browsah"
      export BROWSAH_LIBS="#{opt_libexec}"
      export LD_LIBRARY_PATH="#{opt_libexec}${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      exec "#{opt_libexec}/browsah" "$@"
    SH
    (bin/"browsah").chmod 0755
  end

  def caveats
    <<~EOS
      browsah uses the system GTK 4 and libadwaita (Ubuntu 24.04 or newer, or a similar distro):
        sudo apt install libgtk-4-1 libadwaita-1-0
    EOS
  end

  test do
    assert_predicate libexec/"libcef.so", :exist?
    assert_predicate bin/"browsah", :executable?
    assert_match version.to_s, shell_output("#{bin}/browsah --version")
    assert_match "usage:", shell_output("#{bin}/browsah --help")
  end
end
