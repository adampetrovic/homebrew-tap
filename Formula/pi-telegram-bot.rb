class PiTelegramBot < Formula
  desc "Telegram bot that orchestrates pi coding agent sessions via RPC"
  homepage "https://github.com/adampetrovic/pi-telegram-bot"
  url "https://github.com/adampetrovic/pi-telegram-bot/releases/download/v1.0.5/pi-telegram-bot-v1.0.5.tar.gz"
  sha256 "93a86e0d5226fee65b14e3438c3bb6e0e2119097cb244c6d26c3a4f0c10da835"
  version "1.0.5"
  license "MIT"
  depends_on :macos
  depends_on "node"

  def install
    system "npm", "ci", "--ignore-scripts", "--production"

    libexec.install "dist", "node_modules", "package.json"
    (libexec/"config.example.yaml").write (buildpath/"config.example.yaml").read

    (bin/"pi-telegram-bot").write <<~EOS
      #!/usr/bin/env bash
      set -euo pipefail
      export PATH="${HOME}/.local/share/mise/shims:/opt/homebrew/bin:${PATH}"
      exec node "#{libexec}/dist/index.js"
    EOS
    chmod 0755, bin/"pi-telegram-bot"
  end

  service do
    run [opt_bin/"pi-telegram-bot"]
    keep_alive true
    log_path var/"log/pi-telegram-bot.log"
    error_log_path var/"log/pi-telegram-bot-error.log"
    environment_variables PATH: "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin",
                HOME: ENV["HOME"]
  end

  def caveats
    <<~EOS
      Configure before starting:

        mkdir -p ~/.config/pi-telegram-bot
        cp #{libexec}/config.example.yaml ~/.config/pi-telegram-bot/config.yaml
        # Edit with your bot_token and chat_id

      Start the service:

        brew services start pi-telegram-bot
    EOS
  end

  test do
    assert_predicate bin/"pi-telegram-bot", :exist?
  end
end
