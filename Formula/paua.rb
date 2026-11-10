# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.1.6"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.6/paua-0.1.6-linux-x86_64.tar.gz"
    sha256 "e1669a910a813aa81f3b91d9fc688250380e01ac7e2064fa9cdb6e7691124c4f"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.1.6/paua-0.1.6-linux-aarch64.tar.gz"
    sha256 "c473ac40e68bedb58fc09c9bab6aec6ea948e0b409bc08f3621f1ce9c4f11a3a"
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
