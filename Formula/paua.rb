# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.2.3"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.3/paua-0.2.3-linux-x86_64.tar.gz"
    sha256 "5d97fe55b160f0219963f8f619f533f275b96fdb2d7ee22e1675f0f4a7a277cc"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.3/paua-0.2.3-linux-aarch64.tar.gz"
    sha256 "093e8e35e5075f42b3af4400d32fe4799030376ed11736b2fd6417396a7da4f3"
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
