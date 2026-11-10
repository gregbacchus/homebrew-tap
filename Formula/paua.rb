# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.2.1"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.1/paua-0.2.1-linux-x86_64.tar.gz"
    sha256 "87e521d4bdb24fb2f9bdd8bebd52c5107c3de6338adbf9e55b941f07879e5a06"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.1/paua-0.2.1-linux-aarch64.tar.gz"
    sha256 "f1e7415c5a09264e744d1f42982694c3badf909a07f33e5e99a2ee0954b4b867"
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
