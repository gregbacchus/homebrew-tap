# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.1.2"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.2/paua-0.1.2-linux-x86_64.tar.gz"
    sha256 "d4af3be76507fce2b63846c0aa796bffe2ad2bcabe472a9ff7bc44cd2ee633d5"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.2/paua-0.1.2-linux-aarch64.tar.gz"
    sha256 "5d5b56fd35adec02bed4582a911680efa30974091f1ae2f2760048a36a85b71c"
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
