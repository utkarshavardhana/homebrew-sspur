class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.2.1"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.1/sspur-v0.2.1-aarch64-apple-darwin.tar.gz"
      sha256 "d8e02d60c62c355a75142bf9aeb52d109430acdf1ba48ec8c51d833693ba5901"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.1/sspur-v0.2.1-x86_64-apple-darwin.tar.gz"
      sha256 "a761997ee086933f5aac69450a461b5efe261ce285e88d7093a3129be46c5cc3"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.1/sspur-v0.2.1-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8d88e3d0c6023cf8692a9604d3180ec4488779af806ee09b2965d7a438cada66"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.1/sspur-v0.2.1-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "dc3ff7c25fa92c049c5916c5303c5fc7fe89e12d5d4868b9c1b1d89640eb041d"
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
