class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.2.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.0/sspur-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "69d0329273fedd45102d901a47f6ef211733906b2cfa543fb81f81268c942185"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.0/sspur-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "871a5829fa7ba6cde020d3fffb286ed2e2455459ab1c7d5b62bd45591113ee58"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.0/sspur-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "5d0014eb982423825e58725dc20956ed7978ae6decd3172cd97c1fbd01c1da37"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.2.0/sspur-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "4ab2309c6270be99924b998e83f02ecc088f80b2afe0f5464f22826e10510fa3"
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
