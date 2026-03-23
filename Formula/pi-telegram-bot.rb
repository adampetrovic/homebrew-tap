class PiTelegramBot < Formula
  desc "Telegram bot that orchestrates pi coding agent sessions via RPC"
  homepage "https://github.com/adampetrovic/pi-telegram-bot"
  version "1.0.0"
  license "MIT"
  depends_on :macos

  url "file:///dev/null"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"

  def install
    (bin/"pi-telegram-bot").write(
      "#!/usr/bin/env bash\n" \
      "exec /Users/adam/code/pi-telegram-bot/bin/pi-telegram-bot\n"
    )
    chmod 0755, bin/"pi-telegram-bot"
  end

  service do
    run [opt_bin/"pi-telegram-bot"]
    keep_alive true
    log_path var/"log/pi-telegram-bot.log"
    error_log_path var/"log/pi-telegram-bot-error.log"
    environment_variables PATH: "/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin",
                          HOME: "/Users/adam"
  end

  def caveats
    <<~EOS
      Configure before starting:

        cp ~/code/pi-telegram-bot/env.example ~/.pi/telegram-bot.env
        # Edit with your TELEGRAM_BOT_TOKEN and TELEGRAM_CHAT_ID

      Start the service:

        brew services start pi-telegram-bot
    EOS
  end

  test do
    assert_predicate bin/"pi-telegram-bot", :exist?
  end
end
