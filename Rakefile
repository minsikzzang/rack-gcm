require "bundler"
Bundler.setup

gemspec = eval(File.read("rack-gcm.gemspec"))

task :build => "#{gemspec.full_name}.gem"

file "#{gemspec.full_name}.gem" => gemspec.files + ["rack-gcm.gemspec"] do
  system "gem build rack-gcm.gemspec"
end
