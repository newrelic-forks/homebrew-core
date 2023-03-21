class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.65.1.tar.gz"
  sha256 "b379e10a2419826f727c0138a6df6852a6d6d7c47ffb29eb0761497678308152"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "863bd7b873c384df343a24b5e45bc6ba9d39e9eda4b74b0a81d1f8fc7d11340b"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "8351441129106c0f82e9838379cd459b3fb5fdbb75f9cd78c6af7319268a992f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "1c7f76259aa9990a538228d2d223cf42867c6380641f7c91263b0c8189b45a2b"
    sha256 cellar: :any_skip_relocation, ventura:        "a47b7784128e8a66729033cc8ab0cc824b0cdc42628a1320162c922fefe4b3c6"
    sha256 cellar: :any_skip_relocation, monterey:       "9b53fe9f4334dfc19603dd40ffd0723698c08256ba38947054fff2b3921fd78f"
    sha256 cellar: :any_skip_relocation, big_sur:        "6a9ba05a64d1918a8547884a26ada5f62c401813f296de0996859ed739dac146"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "c5b2df421c9d8af18b56b0e742ad77596fb0aaf00c9af427cbe0c7733d050208"
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
