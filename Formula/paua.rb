# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-terminal"
  version "0.2.9"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.9/paua-0.2.9-linux-x86_64.tar.gz"
    sha256 "2c4c7e7a0c62701d0dc0c0015e8dbaadc01a487da42210d07239ca0117eaa585"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.9/paua-0.2.9-linux-aarch64.tar.gz"
    sha256 "2fe410fa115b78671c58c7f4529fd3f4a1c408cdb331d2f6b69c44502e9ce6ac"
  end

  def install
    bin.install "paua"
  end

  def caveats
    <<~EOS
      Paua uses the system GTK 4 and libadwaita (Ubuntu 24.04 or newer, or a similar GNOME distro):
        sudo apt install libgtk-4-1 libadwaita-1-0

      First run: pick your fonts, write a config and add Paua to the GNOME overview with
        paua setup
    EOS
  end

  test do
    assert_match "colourful terminal", shell_output("#{bin}/paua --help")
  end
end
