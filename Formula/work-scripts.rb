class WorkScripts < Formula
  desc "Collection of work utility scripts"
  homepage "https://github.com/adampetrovic/work-scripts"
  head "https://github.com/adampetrovic/work-scripts.git", branch: "main"

  def install
    Dir["*.sh"].each do |script|
      name_without_extension = File.basename(script, ".sh")
      bin.install script => name_without_extension
    end
  end
end
