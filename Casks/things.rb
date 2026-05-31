cask "things" do
  version :latest
  sha256 :no_check

  url "https://static.culturedcode.com/things/Things3.zip"
  name "Things"
  desc "To-do app and task manager (direct trial download from Cultured Code)"
  homepage "https://culturedcode.com/things/"

  # The trial download is an unversioned, rolling "latest" build, so this
  # cannot be auto-checked for newer releases via the usual livecheck.
  livecheck do
    skip "Unversioned trial download"
  end

  depends_on macos: :catalina

  app "Things3.app"

  zap trash: [
    "~/Library/Application Scripts/com.culturedcode.ThingsMac",
    "~/Library/Containers/com.culturedcode.ThingsMac",
    "~/Library/Group Containers/JLMPQHK86H.team",
  ]
end
