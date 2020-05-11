class NewrelicCli < Formula
  desc "The New Relic Command-line Interface"
  homepage "https://github.com/newrelic/newrelic-cli"
  url "https://github.com/newrelic/newrelic-cli/archive/v0.8.4.tar.gz"
  sha256 "f3ac0326498066f74b584d783e76638a4cc58b7674bf1eb1bb0d0627ad4e552e"
  head "https://github.com/newrelic/newrelic-cli.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f377056a9093557bbbcf996b6c7a57deabe2c6bf35d11936e10750b4d90dc819" => :catalina
    sha256 "6927eefa17e844afbd96ff94d27c7e5cd2592ab8bda523f9a2da3ada20d15c77" => :mojave
    sha256 "011b856a1ccccb208f04186014a24cd6ac25f45ebc752d04a7ddd27ca2b0a7f7" => :high_sierra
  end

  depends_on "go" => :build

  def install
    ENV["PROJECT_VER"] = version
    system "make", "compile-only"
    bin.install "bin/darwin/newrelic"

    output = Utils.popen_read("#{bin}/newrelic completion --shell bash")
    (bash_completion/"newrelic").write output
    output = Utils.popen_read("#{bin}/newrelic completion --shell zsh")
    (zsh_completion/"_newrelic").write output
  end

  test do
    assert_match /pluginDir/, shell_output("#{bin}/newrelic config list")
    assert_match /logLevel/, shell_output("#{bin}/newrelic config list")
    assert_match /sendUsageData/, shell_output("#{bin}/newrelic config list")
    assert_match version.to_s, shell_output("#{bin}/newrelic version 2>&1")
  end
end
