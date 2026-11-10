# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.1.0"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.0/paua-0.1.0-linux-x86_64.tar.gz"
    sha256 "dbe1af354e8922d20af73b5e9a8fca0fb86dc92970cf70c11c2e042a11e95062"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.0/paua-0.1.0-linux-aarch64.tar.gz"
    sha256 "92ae6f748ae156d8b5c9f4fcd0f4dcbcfbc30440b8b416df106d98b88de99849"
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
