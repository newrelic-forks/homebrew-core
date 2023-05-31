class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.68.13.tar.gz"
  sha256 "77194f0af19d11eaa16def30a8eb611ea08dc8d0629f8a1b5ee6b91a00fe637a"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  livecheck do
    url :stable
    strategy :github_latest
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "38f480bb8484cc96750b0b47bb2b1134c6f5a5c8c866e711a69d346ad10dd703"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "0c021b57c5437c824aa73b5a4a2e63d6ebb1f0f08f768ddb69cb54c408854a54"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "6b4713650cf4144aa35880e1f4fbbf967bcea01648311e3d5ad49eeb4cb2b296"
    sha256 cellar: :any_skip_relocation, ventura:        "0fc9d4496418156105301e99be605521e5b75796e35aaa6f2f89b3b14f80e5ac"
    sha256 cellar: :any_skip_relocation, monterey:       "2d06d3cd118db43f8fc6d92f0f33ec29f372cd7d8faeea8c8d1562f5cc9120c5"
    sha256 cellar: :any_skip_relocation, big_sur:        "784e3c73a35f63b1fa86e5eeb7cce64af56717a46f41ebd17ff7c12b4be03d4d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "567d5158b809aa302033a709fe3cc12b64c6a9f6676a60e4a400f7a1ef3807ad"
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
