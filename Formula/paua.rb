# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-termimal"
  version "0.2.4"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.4/paua-0.2.4-linux-x86_64.tar.gz"
    sha256 "7f939d8bcda48f171fdabb26f5d64a5a62a52f132f73412709019fd82d20a33e"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-termimal/releases/download/v0.2.4/paua-0.2.4-linux-aarch64.tar.gz"
    sha256 "d6795c34d4c14b97be0f3a41a8bd5306b23340a9f2068cfb33a59a999c03a4d5"
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
