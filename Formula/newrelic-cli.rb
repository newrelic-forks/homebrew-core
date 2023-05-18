class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.68.7.tar.gz"
  sha256 "64f616a3a015467d663820433b6cfe6cfc2af879eed880f76be4a1908b6168f3"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "29f307b938f01f14eea8c03c93bcbe05e8d86bd6e8b380c9d7b621bcb189d540"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "920d6ffde8f221f3ebeb6ecaf98c28764f6c4a6f3c237342a8fb2ee26282e58d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0b5a52cdaa8053d61444c1b788b8465614f4c584c3488a1bcc1ef0a61f3072c8"
    sha256 cellar: :any_skip_relocation, ventura:        "0cf55c5ba0aec3e8776c6666a6d225cd0e571eecbf1dae155e39a66608596a39"
    sha256 cellar: :any_skip_relocation, monterey:       "fb87c78ff46dd894bcf908d9db7714e27b4a099b81bb8242387c21b56843e4db"
    sha256 cellar: :any_skip_relocation, big_sur:        "3a94ff64ab52b5ca833e8d85751878958b1d291e6c4aace36e9f5051d51d3d42"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d4d508a698b49a207824679c059590cc63aa4d806abd62be7994cafbc7efa1ec"
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
