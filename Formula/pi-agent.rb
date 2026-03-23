class PiAgent < Formula
  desc "Pi AI webhook agent — investigates alerts and reports to Telegram"
  homepage "https://github.com/adampetrovic/pi-webhook-bridge"
  version "0.2.0"
  license "MIT"
  depends_on :macos

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    # Launcher delegates to the pi-webhook-bridge wrapper script
    (bin/"pi-agent").write(
      "#!/usr/bin/env bash\n" \
      "exec /Users/adam/code/pi-webhook-bridge/bin/pi-agent\n"
    )
    chmod 0755, bin/"pi-agent"
  end

  service do
    run [opt_bin/"pi-agent"]
    keep_alive true
    log_path var/"log/pi-agent.log"
    error_log_path var/"log/pi-agent-error.log"
    environment_variables PATH: "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin",
                          HOME: "/Users/adam"
  end

  test do
    assert_predicate bin/"pi-agent", :exist?
  end
end
