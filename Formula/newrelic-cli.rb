class NewrelicCli < Formula
  desc "Command-line interface for New Relic"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.36.2.tar.gz"
  sha256 "d45d80d61ffb9ec6d4d65ba4e7ce0d5d99964124dea5886c9aec9575c1700a4f"
  license "Apache-2.0"
  head "https://github.com/newrelic/newrelic-cli.git", branch: "main"

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "901f21a9ee5e69fc9ef74d15bee8a57d9be76f5a83077ee5100a495208f836f6"
    sha256 cellar: :any_skip_relocation, big_sur:       "d81cac58122bc70fdc3b7e884215c5a9a7b82e1724f8338d412f24997dca1d2a"
    sha256 cellar: :any_skip_relocation, catalina:      "7f3910eb6caf3a4a76650315ad7d6a4bfb8f9c2dbdbd81bf6a01354c50224028"
    sha256 cellar: :any_skip_relocation, mojave:        "6c5ae4c48d040e99466b1a590988ba6af37ada7f901fce087bb21ab30cbc5613"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e4ee90b1c283ff35f61361f6540624240b5cda98bb8ad752cdaadd2e2bfab3ba"
  end

  depends_on "go" => :build

  def install
    ENV["PROJECT_VER"] = version
    system "make", "compile-only"
    if OS.mac?
      bin.install "bin/darwin/newrelic"
    else
      bin.install "bin/linux/newrelic"
    end

    output = Utils.safe_popen_read("#{bin}/newrelic", "completion", "--shell", "bash")
    (bash_completion/"newrelic").write output
    output = Utils.safe_popen_read("#{bin}/newrelic", "completion", "--shell", "zsh")
    (zsh_completion/"_newrelic").write output
  end

  test do
    output = shell_output("#{bin}/newrelic config list")

    assert_match "loglevel", output
    assert_match "plugindir", output
    assert_match version.to_s, shell_output("#{bin}/newrelic version 2>&1")
  end
end
