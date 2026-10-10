class Sspur < Formula
  desc "Programming language for AI agents to write, read and maintain"
  homepage "https://github.com/utkarshavardhana/sspur"
  version "0.4.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.0/sspur-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "6c3ed92b8557c2b257695dafe093e710d632762d3198b909d993b3eecfe337db"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.0/sspur-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "9450677cb4abb3cf210bac2513953dba88338e8a10df0b5ab094f50d92132f56"
    end
  end

  on_linux do
    depends_on "llvm"

    on_arm do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.0/sspur-v0.4.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "7f4a444718c7f3ee7ef71d3f9814e0d713fa3ec02589feff72b67cb833e1963d"
    end
    on_intel do
      url "https://github.com/utkarshavardhana/sspur/releases/download/v0.4.0/sspur-v0.4.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1ccb7df5c94d59242124c80f045da286fd2e397f1b29837ec6a3fdc12b77ae74"
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
