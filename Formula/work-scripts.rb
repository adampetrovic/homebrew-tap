class WorkScripts < Formula
  desc "Collection of work utility scripts"
  homepage "https://github.com/adampetrovic/work-scripts"
  head "https://github.com/adampetrovic/work-scripts.git", branch: "main"

  def install
    # Install shell scripts
    Dir["*.sh"].each do |script|
      name_without_extension = File.basename(script, ".sh")
      bin.install script => name_without_extension
    end

    # Compile and install Go scripts
    Dir["*.go"].each do |script|
      name_without_extension = File.basename(script, ".go")
      system "go", "build", "-o", name_without_extension, script
      bin.install name_without_extension
    end
  end
end
