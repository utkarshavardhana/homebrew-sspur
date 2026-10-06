class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.3.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.0/sspur-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "1e8aa005a6d409c09ff564b94f33ac59c4dbb0d9e3536a8f3e01088583510b87"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.0/sspur-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "956814910e08c580b98ef9c52cc8e8625a9c0e10969f52c7e9c712e15ac38eb2"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.0/sspur-v0.3.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "56b7e2a6348320c0784b9d0bb52d6e61ea47a08f9279f0a8b49ece1a4164e3e2"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.0/sspur-v0.3.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d96006e46b2dde6c27171f158e100d25d36277dbc377c6250496d4d84dd14c12"
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
