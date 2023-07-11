class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.68.23-1-g15e37de0.tar.gz"
  sha256 "8495469681184c764086a384e4d77dd8929c18390487bfa585ee681754b18480"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "b8d029e347cbd0775f59fcfa8cc37073ae4146d048aa0de413ceb88251333d25"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fdc24f03216f3704e85b4ea9cc1fed8aac09b3e195fe47fad47979803736d20a"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "ef54edf6dc35177f5ce5d4ebac3bc5aa4093bf56f6e9a9221308f940b73893dc"
    sha256 cellar: :any_skip_relocation, ventura:        "36565d2248fc48003a81004e806c54f13aa7f7cfbd70f9a17581b8cae1f9682e"
    sha256 cellar: :any_skip_relocation, monterey:       "35d132c0754255d18f3ac914a490686c119f2d667d506f5bc1a8f2b18f9cb182"
    sha256 cellar: :any_skip_relocation, big_sur:        "80051c1a179626315a4eda675dc7ff7522b6aa1c66ebc1b9944c0438077925e6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1bba7de9054f27b04e2f7e1e87b03734ccc9441fa2cff493c15b0983ca01c052"
  end

  depends_on "go" => :build

  def install
    ENV["PROJECT_VER"] = version
    system "make", "compile-only"
    bin.install "bin/#{OS.kernel_name.downcase}/newrelic"

    generate_completions_from_executable(bin/"newrelic", "completion", "--shell", base_name: "newrelic")
  end

  test do
    output = shell_output("#{bin}/newrelic config list")

    assert_match "loglevel", output
    assert_match "plugindir", output
    assert_match version.to_s, shell_output("#{bin}/newrelic version 2>&1")
  end
end
