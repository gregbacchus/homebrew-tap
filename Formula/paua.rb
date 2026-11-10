# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.2.0"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.0/paua-0.2.0-linux-x86_64.tar.gz"
    sha256 "ca1517f10f38a5e0b99f59495b875b0631924446256bd449be3d17c3c92c1698"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.0/paua-0.2.0-linux-aarch64.tar.gz"
    sha256 "9ef89e5e10da58a4e4ea5545a695694bf4ab784e784934d8be464789f87c85f5"
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
