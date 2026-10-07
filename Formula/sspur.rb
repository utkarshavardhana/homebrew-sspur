class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.3.2"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.2/sspur-v0.3.2-aarch64-apple-darwin.tar.gz"
      sha256 "2731900ad4a1b04747c5ce4070661842a6bb261b418449eb93ba14f905c23d97"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.2/sspur-v0.3.2-x86_64-apple-darwin.tar.gz"
      sha256 "25aa644064aa41254847ce8ad6c826ce43b24874a21d58b83cd9fdcbee4a910b"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.2/sspur-v0.3.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "4cd721ecf681d1c938e86914988354c2ffbd2d4ece084c4cbf1d371d8dd0d8a3"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.2/sspur-v0.3.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "6311c591fd2a344042152ec6f57f38b698d8c91ebe5a99c296f971149fa062d6"
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
