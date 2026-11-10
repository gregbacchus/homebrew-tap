# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.1.5"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.5/paua-0.1.5-linux-x86_64.tar.gz"
    sha256 "2ebde93e6660e3b61f36d24cafd281fbda961c4a5a0d445940368269e9c142ff"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.5/paua-0.1.5-linux-aarch64.tar.gz"
    sha256 "27c1cc59511bd3dff0093f4bcd39bf08b28014a3072e55db177428ca37277370"
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
