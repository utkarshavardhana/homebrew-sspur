class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.4.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.1/sspur-v0.4.1-aarch64-apple-darwin.tar.gz"
      sha256 "4817012ffcda51b9ed4f997136431b5c3e5c7cca65f00eec53add2ee90d710de"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.1/sspur-v0.4.1-x86_64-apple-darwin.tar.gz"
      sha256 "81fb61075f23acc14de5bd139fd3419bb491224648b67b0edc70e48c68fbf7f7"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.1/sspur-v0.4.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6e476770d7fc317b822f2b2ae9bdfdfbc434c497f96dd351f3811529c2f291ad"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.1/sspur-v0.4.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "7964767a2e6162941714e978a6a2430e48d3a223e08e113a39f92de035e1f7f8"
    end
  end

  depends_on "z3" => :recommended

  def install
    bin.install "sspur"
    doc.install "README.md", "CHANGELOG.md"
  end

  def caveats
    <<~EOS
      SSPUR compiles to native code through clang. On macOS it comes with
      the Xcode Command Line Tools (xcode-select --install).
    EOS
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/sspur --version")
    (testpath/"t.ssp").write <<~SSP
      fn add(a: Int, b: Int) -> Int
      = a + b

      test adds = add(2, 3) == 5
    SSP
    assert_match "1 passed, 0 failed", shell_output("#{bin}/sspur test --interp #{testpath}/t.ssp")
  end
end
