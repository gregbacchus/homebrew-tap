# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/paua.rb.
class Paua < Formula
  desc "Colourful terminal for GNOME"
  homepage "https://github.com/gregbacchus/paua-terminal"
  version "0.2.8"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.8/paua-0.2.8-linux-x86_64.tar.gz"
    sha256 "1e004703dc6048d704e6e7d5fe76e8a6462dc2654c287a9db604fd48901c6c46"
  end

  on_arm do
    url "https://github.com/gregbacchus/paua-terminal/releases/download/v0.2.8/paua-0.2.8-linux-aarch64.tar.gz"
    sha256 "9856b00d91ddf1c9547bf17e696f075b02096751928c33222b41be65ca7dae68"
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
