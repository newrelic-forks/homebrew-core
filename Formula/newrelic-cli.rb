class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.62.7.tar.gz"
  sha256 "e17ee74d0e635b87606e430a77b04353a2d7eb485b8cb994346dbb546d172949"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "63b21c4ccee8a35de6da74707481791f974d4197717c006635d61e0534039a77"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "f824b1ab940abfbcb821d79473cd4d09ab08386e312ab746232f571b22d161e2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "7ecf1821bf91bff274d0d420b85cbe6918ce52c81d0e10ca07ab4e1bd641713c"
    sha256 cellar: :any_skip_relocation, ventura:        "73f7312c0da9c4c6afc9c5c9842575a1693b45bc527d7d85bf46bc19e6f52efe"
    sha256 cellar: :any_skip_relocation, monterey:       "8c08889c32f0fbbfcaa3b5e60267f4c2445b8b8ecb36cf0a5cc4a58e7b1b6df4"
    sha256 cellar: :any_skip_relocation, big_sur:        "75874532d82211c87b225381d0adfaae128f1f066e4cb386877dc42cb6296ba6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "cc5767a85ebcfb6e091de217e0898a51a4322cdb9cef3527612053350972b14e"
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
