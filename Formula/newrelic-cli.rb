class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.62.2.tar.gz"
  sha256 "4a36c80d633bb1109904513a7d5dfb3f5495cae08197a03b72ee2bf4ea92bc25"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "91470fda2c0f4633851f67340820a0128863f4cd2e2546dceafcfa2a16513cc5"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "ebcf2c39ae1b16f75670e3338b3fb41ae75e4a59f5b0ca0ccf1e145775e4db35"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "4f9c08e305a32406174a81514add2e328fd3db4e31782e8586e500ba80e0024d"
    sha256 cellar: :any_skip_relocation, ventura:        "3805a1ec9586679c2166e416d861cb4f9265877b785b86af1737f65298e46dcf"
    sha256 cellar: :any_skip_relocation, monterey:       "c1234dc7e72c693e718c08438de6d3b558d73c888d743950550985142cb51cb9"
    sha256 cellar: :any_skip_relocation, big_sur:        "9151b56123e7522e19159d1f5ee4605330e966ee698794998958ffdf887dcc8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "61755c2215d7fbc14c40bea1b79500a7e538e34f51ce9b959a3dd66029dbf64f"
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
