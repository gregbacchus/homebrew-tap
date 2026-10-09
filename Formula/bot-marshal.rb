class BotMarshal < Formula
  desc "Egress firewall for AI agents"
  homepage "https://gregbacchus.github.io/bot-marshal/"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.6.1/marshal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "c983ad56db7218f2222d788f09f477a9ca63703e51ae19720b88c57f3caa01ff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.6.1/marshal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "e876bfd7c9e8227fbf8bca39c3db6b7ea6f03ccc79133f2423bbcfb378119451"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.6.1/marshal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "605ab3afaf9d6b7b251e7ada63104b474bdf8d62cb0d3ac679d704ddc8c1bfd8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.6.1/marshal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b07d22183767f55e3923bf6cdc191aed69f8430557a6e8af61dd826286e33096"
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
