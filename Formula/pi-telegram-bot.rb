class PiTelegramBot < Formula
  desc "Telegram bot that orchestrates pi coding agent sessions via RPC"
  homepage "https://github.com/adampetrovic/pi-telegram-bot"
  url "https://github.com/adampetrovic/pi-telegram-bot/releases/download/v1.0.7/pi-telegram-bot-v1.0.7.tar.gz"
  sha256 "a8c1170449a161a8643f53620de232ef343c27dfabea02f3921ce32561d53886"
  version "1.0.7"
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
