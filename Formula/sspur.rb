class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.5.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.5.0/sspur-v0.5.0-aarch64-apple-darwin.tar.gz"
      sha256 "5f26d266cb51bf277e0aba2879505a59a074c4cc745b819c7ac53f2f1895e857"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.5.0/sspur-v0.5.0-x86_64-apple-darwin.tar.gz"
      sha256 "e0154bbf6a65bb9e798857f157b85bd6ea747320c5c26edb9a0484fcda7a7015"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.5.0/sspur-v0.5.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "6b8c1410f9a752d9e36cc495d49544a83a84d07f2bb177f12acb3f32c53408c6"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.5.0/sspur-v0.5.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "0be8c9602c84b789c94b315a5744fabd05cd7cf6152d7ddd3fc2a10315076cff"
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
