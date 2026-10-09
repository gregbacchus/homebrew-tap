class BotMarshal < Formula
  desc "Egress firewall for AI agents"
  homepage "https://gregbacchus.github.io/bot-marshal/"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.8.0/marshal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "43c4364c973f299163e866f32ba5f3d4482970203b14525165affec049a25152"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.8.0/marshal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "64bdd0c385c7912e40962733fbb3d7668247aa02c34242b0dab1645fb4fbd494"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.8.0/marshal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e7d935ab86cee181cbcd849c7459912846dd30b8c93a6a359cca86a7d6b8d0dc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.8.0/marshal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b82ffda8e5af020ce4776d37b8bc27c269182da167b2cebaefc06bf7878cad6c"
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
