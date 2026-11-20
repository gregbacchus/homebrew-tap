# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-terminal"
  version "0.2.10"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.10/paua-0.2.10-linux-x86_64.tar.gz"
    sha256 "afb2e83e293f8192acde69b7807161bc05299e4f677bae8c9112d5401dfb835a"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.10/paua-0.2.10-linux-aarch64.tar.gz"
    sha256 "11aeaca428841d83040d109f1a97136c49a7ea2e4e07f19d3c88b94a3546f00f"
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
