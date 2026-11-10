# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-terminal"
  version "0.2.5"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.5/paua-0.2.5-linux-x86_64.tar.gz"
    sha256 "51a72077582957654d9f3ae3d15aeb1e971570632e9d9f99868a35586fee1e32"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.5/paua-0.2.5-linux-aarch64.tar.gz"
    sha256 "663aadb27ff13c2126f6cc94aff4a594d09189973c6c7f5bc4c487abbd0f70c3"
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
