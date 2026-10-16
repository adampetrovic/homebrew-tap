cask "kestrel" do
  version "0.1.0"
  sha256 "79b70b4ce78408272ded59772479b5b6620ef9f996747c32994f25b3af015f48"

  # The release lives in a private repository, so it is downloaded through the GitHub API with your token
  # (HOMEBREW_GITHUB_API_TOKEN, or GITHUB_TOKEN as a fallback).
  url "https://api.github.com/repos/adampetrovic/kestrel/releases/assets/648629607",
      header: [
        "Accept: application/octet-stream",
        "Authorization: token #{ENV["HOMEBREW_GITHUB_API_TOKEN"] || ENV["GITHUB_TOKEN"]}",
      ]
  name "Kestrel"
  desc "Native macOS reader for Miniflux and Readeck"
  homepage "https://github.com/adampetrovic/kestrel"

  livecheck do
    skip "Releases come from a private repository"
  end

  depends_on macos: :sequoia

  app "Kestrel.app"

  # The app is ad-hoc signed (not notarized); clear the quarantine flag Homebrew puts on downloads.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/Kestrel.app"],
        writable_paths: ["Kestrel.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Caches/au.com.petrovic.Kestrel",
    "~/Library/Containers/au.com.petrovic.Kestrel",
    "~/Library/Preferences/au.com.petrovic.Kestrel.plist",
    "~/Library/Saved Application State/au.com.petrovic.Kestrel.savedState",
  ]
end
