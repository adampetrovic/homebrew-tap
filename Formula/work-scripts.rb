class WorkScripts < Formula
  desc "Collection of work utility scripts"
  homepage "https://github.com/adampetrovic/work-scripts"
  head "https://github.com/adampetrovic/work-scripts.git", branch: "main"

  depends_on "go" => :build
  depends_on "gum"

  def install
    # Install shell scripts
    Dir["*.sh"].each do |script|
      name_without_extension = File.basename(script, ".sh")
      bin.install script => name_without_extension
    end

    # Compile and install Go scripts
    Dir["*.go"].each do |script|
      name_without_extension = File.basename(script, ".go")
      Dir.mktmpdir do |tmpdir|
        output_path = File.join(tmpdir, name_without_extension)
        system "go", "build", "-o", output_path, script
        bin.install output_path
      end
    end

    # Install zsh aliases file
    (share/"work-scripts").install "aliases.zsh"
  end
end
