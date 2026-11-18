# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/browsah.rb.
class Browsah < Formula
  desc "Web browser: GTK4 shell around Chromium (CEF), native Wayland"
  homepage "https://github.com/gregbacchus/browsah"
  version "0.1.2"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.1.2/browsah-0.1.2-linux-x86_64.tar.gz"
    sha256 "b02fdce92a07255faf3bec433ad8522e955f128e20ea6b7622cd2f4a0dad01e4"
  end

  on_arm do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.1.2/browsah-0.1.2-linux-aarch64.tar.gz"
    sha256 "8a6d5f621a711e4bf2cc9dd53cfe1d3d521c16dcea3e8b0f861ee10b2b252983"
  end

  def install
    # The binary needs libcef.so and CEF's resource files beside it, so keep the directory whole and
    # put a small launcher on the PATH that points the loader at it.
    libexec.install Dir["*"]
    (bin/"browsah").write <<~SH
      #!/bin/sh
      export LD_LIBRARY_PATH="#{libexec}${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      exec "#{libexec}/browsah" "$@"
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
  end
end
