class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.3.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.1/sspur-v0.3.1-aarch64-apple-darwin.tar.gz"
      sha256 "369f5061048765f0ae923c5c79c88f89306dee2b21f5ae85666803b555255446"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.1/sspur-v0.3.1-x86_64-apple-darwin.tar.gz"
      sha256 "7d017c7c560a74b6d41de96e0b48c464c8640728927e39ead9a764c43f1d0713"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.1/sspur-v0.3.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "f0ec66f2fb44d6e67a69cff0118008901a6fd201f577b909f937ac5675fe14fc"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.3.1/sspur-v0.3.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "a6e1b78946550bcab482a4e7d6ce8319ac9abd858aeafd40705a4b4f17fc3089"
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
