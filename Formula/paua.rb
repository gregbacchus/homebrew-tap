# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-terminal"
  version "0.2.7"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.7/paua-0.2.7-linux-x86_64.tar.gz"
    sha256 "d0115e3740e63f660a33a74b04fd884cfec20d19e155aa3176005ae35266efa5"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.7/paua-0.2.7-linux-aarch64.tar.gz"
    sha256 "3408b3f2afb209081cec956690d9e18ba6384c79cf65156586afab99c1afaa8b"
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
