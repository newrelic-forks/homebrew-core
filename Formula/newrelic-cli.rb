class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.62.6.tar.gz"
  sha256 "d456f46398d7fb01217cbacf4e5cdef87347214e1e30567b9acea2986541d642"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2048c02fff01148772f157c21bea9a8604ab5189c1ae70f4ca38973caccc0941"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "240efd8015d6c357fd6cb6278cc193fbd5cf61071feb57fa853c82ea828a23dc"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "9274d1ba12c8efa7ef6fd29398e5d169be4ad4cc7ed329696ad1feb26f635e90"
    sha256 cellar: :any_skip_relocation, ventura:        "8a2561164002fdefac553cc7ad5f05a2d49f5dd95496c1ab031fde7810ff3e53"
    sha256 cellar: :any_skip_relocation, monterey:       "4071e6fdc7c8086286212f0065ac128d79b9e68834540a2a5b34cd76f1f2670e"
    sha256 cellar: :any_skip_relocation, big_sur:        "5ccbe0f6d4310756681d75f13bc4c591dc063374c07a200a4c89ccc5cd7b7f6e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cb6b09889b83d756bfc32aef1f563d8f4a8accd4409a27d8e07eea539bb51b4b"
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
