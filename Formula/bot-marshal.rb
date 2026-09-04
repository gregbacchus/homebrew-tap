class BotMarshal < Formula
  desc "Egress firewall for AI agents"
  homepage "https://gregbacchus.github.io/bot-marshal/"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.0/marshal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "baa9f593b78a498117ece3a66f6d3346b4bdffca399e6946c640af4ebd8783aa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.0/marshal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "039595270c7b4bbc12aec14248cd12b88f3b084f91f29facae70d25b32bac17c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.0/marshal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7d7beacadc9d53fd07841d43fc0fa1a87fb4fa9e23afdfed81afe0d40d43fca2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.0/marshal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "72d5d2145516e68c64a3c32889165226cbbb34247ad83bbcb66cd843f89af823"
    end
  end
  license any_of: ["MIT", "Apache-2.0"]

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "marshal"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "marshal"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "marshal"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "marshal"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
