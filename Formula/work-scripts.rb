class WorkScripts < Formula
  desc "Collection of work utility scripts"
  homepage "https://github.com/adampetrovic/work-scripts"
  head "https://github.com/adampetrovic/work-scripts.git"

  def install
    bin.install Dir["scripts/*"]
    # For Go scripts, you'd build them first:
    # system "go", "build", "-o", "#{bin}/script-name", "script.go"
  end
end
