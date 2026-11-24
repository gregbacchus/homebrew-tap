# Template for the Homebrew formula. The release workflow fills in the @...@ values and commits
# the result to the tap repository as Formula/browsah.rb.
class Browsah < Formula
  desc "Web browser: GTK4 shell around Chromium (CEF), native Wayland"
  homepage "https://github.com/gregbacchus/browsah"
  version "0.7.0"

  license "MIT"

  depends_on :linux

  on_intel do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.7.0/browsah-0.7.0-linux-x86_64.tar.gz"
    sha256 "42b6802071ebbf4d04a51ef17f78200f7a71b0d5bf927f6814e3adfa34319408"
  end

  on_arm do
    url "https://github.com/gregbacchus/browsah/releases/download/v0.7.0/browsah-0.7.0-linux-aarch64.tar.gz"
    sha256 "b616223c60ffa2453660c5c7867b22cba27ce0d82d9c9f80fad0da5bbf2844ee"
  end

  def install
    # The binary needs libcef.so and CEF's resource files beside it, so keep the directory whole and
    # put a small launcher on the PATH that points the loader at it. The launcher uses the stable `opt` paths
    # (the versioned Cellar directory is removed by the next upgrade) and tells browsah about them, so the
    # desktop entries it writes keep working after upgrades.
    libexec.install Dir["*"]
    (bin/"browsah").write <<~SH
      #!/bin/sh
      export BROWSAH_LAUNCHER="#{opt_bin}/browsah"
      export BROWSAH_LIBS="#{opt_libexec}"
      # H.264/AAC: the CEF that `browsah codecs install` put in your data folder, ahead of the bundled one.
      runtime="${XDG_DATA_HOME:-$HOME/.local/share}/browsah/codec-runtime/current"
      [ -f "$runtime/libcef.so" ] || runtime=""
      export LD_LIBRARY_PATH="${runtime:+$runtime:}#{opt_libexec}${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"
      exec "#{opt_libexec}/browsah" "$@"
    SH
    (bin/"browsah").chmod 0755
  end

  def caveats
    <<~EOS
      browsah uses the system GTK 4 and libadwaita (Ubuntu 24.04 or newer, or a similar distro):
        sudo apt install libgtk-4-1 libadwaita-1-0

      1Password's browser integration refuses a browser you could modify, and a Homebrew install is owned by you. For it, make a
      root-owned copy (it prints what it will change and asks first):
        sudo "$(brew --prefix)/bin/browsah" system-install --1password
      then start browsah as /usr/local/bin/browsah. After `brew upgrade browsah`, update that copy with:
        /usr/local/bin/browsah system-upgrade

      On Linux x86-64, optional H.264/AAC codecs can be installed for personal use:
        browsah codecs install
      For the root-owned copy, install them separately after each system upgrade:
        sudo /usr/local/bin/browsah codecs install
    EOS
  end

  test do
    assert_predicate libexec/"libcef.so", :exist?
    assert_predicate bin/"browsah", :executable?
    assert_match version.to_s, shell_output("#{bin}/browsah --version")
    assert_match "usage:", shell_output("#{bin}/browsah --help")
  end
end
