class BotMarshal < Formula
  desc "Egress firewall for AI agents"
  homepage "https://gregbacchus.github.io/bot-marshal/"
  version "0.1.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.2/marshal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "1727204a515cd97b0087f283b55f552c66d6214b6d7b49cdacdf927c41387734"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.2/marshal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "25970d7057085a3fc6c0d1a832380f55104a8a093695e6f7ca5dbf2e8033d77c"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.2/marshal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a3a96906f5502c06a54a85f69445f29bc1a0a29e99390f0da8c6a283eb659b8e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.1.2/marshal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43c0abba4c7e06b0b70ab486fa339df60dbbe23b0492e6d458dff1a4b819e5ea"
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
