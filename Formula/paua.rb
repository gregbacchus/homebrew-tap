# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.2.2"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.2/paua-0.2.2-linux-x86_64.tar.gz"
    sha256 "de9fc04dc58633541892e6bd39e4d8284c36df1dd410bc71c0fd3eaed5a5d4c7"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.2/paua-0.2.2-linux-aarch64.tar.gz"
    sha256 "1a49917bd5a1e57605f1edd1d5045e75f56d0dd124006470d2b0c5990add3b08"
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
