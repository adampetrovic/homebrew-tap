class PiAgent < Formula
  desc "Pi AI webhook agent — investigates alerts and reports to Telegram"
  homepage "https://github.com/adampetrovic/pi-webhook-bridge"
  version "0.1.1"
  license "MIT"
  depends_on :macos

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    script_content = ['#!/usr/bin/env bash',
                      'set -euo pipefail',
                      'export HOME="/Users/adam"',
                      'cd /Users/adam/pi-agent',
                      'eval "$(/opt/homebrew/bin/mise env 2>/dev/null)" || true',
                      "exec pi --mode rpc --no-session <<'PROMPT'",
                      '{"type":"prompt","text":"You are now running as a background service. Wait for webhook events to arrive and process them according to your AGENTS.md instructions. Do not take any action until an event arrives."}',
                      'PROMPT'].join("\n") + "\n"
    File.write(bin/"pi-agent", script_content)
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
