class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.66.1.tar.gz"
  sha256 "61f1dcaf773aa5f76dc38f3c46655d5008cbb1636aac6cb3460c67f798c39f15"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "28b52e97cc4b976b5265eb48892a9dc5f2b7411bd19c734c31afe3d354f4dba3"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "591f36ffa643f1f448d7d92bdbb3579d90f4bb301a417a84a1541587e5ef804d"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "0d5da1fb7361ee61c3e1c1f7d96b66aa0b6213d53881c1a6e2b77fecabdc2a7d"
    sha256 cellar: :any_skip_relocation, ventura:        "7a5c1856ad3711c85621d96a718e808aec54999c49cf1a02f19d274cdfe2c569"
    sha256 cellar: :any_skip_relocation, monterey:       "31f3519b5a8d7f20dbe2f06cff6bdf875a4217f0fbb778af1efcc342d618b9ed"
    sha256 cellar: :any_skip_relocation, big_sur:        "5f8a73f11b4fb8be47e1986b23799ca4432b4a1da1a9c655bd6ea7d089196bc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cdc5f561b6cd451044f79e3bd27ffa6c6ce81d30d06431305cb978eaa7251744"
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
