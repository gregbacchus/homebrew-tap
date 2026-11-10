# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.1.4"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.4/paua-0.1.4-linux-x86_64.tar.gz"
    sha256 "5d67aa51c15bea998aa79900eb6234bc425c573529ed0ae7c5686cf88210719e"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.4/paua-0.1.4-linux-aarch64.tar.gz"
    sha256 "5d0fd0609ab2af52a1c1ed9ec6be961902ab654227010e41133df8a0d4672d4f"
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
