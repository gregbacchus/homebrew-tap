class BotMarshal < Formula
  desc "Egress firewall for AI agents"
  homepage "https://gregbacchus.github.io/bot-marshal/"
  version "0.10.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.10.0/marshal-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f86e0c6ab933dce581333e74add7d7602800a36746b9233068cbbb1439b1e0bb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.10.0/marshal-cli-x86_64-apple-darwin.tar.xz"
      sha256 "b6d069f5831bf7562609af7e52f7791b3181eb9b87ae1d02ff5d9bf3983fccd5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.10.0/marshal-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d512433d97b3d4dfdb237efbad9d368477b2fd941052225f719d5f684210dc5d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/gregbacchus/bot-marshal/releases/download/v0.10.0/marshal-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "60c74ea316ba46fdfc47a90fbe66c2cf215353a15f5b04948cf12b428476506a"
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
