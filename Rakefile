require "bundler/gem_tasks"

desc "Run all examples with RCov"
Spec::Rake::SpecTask.new('specs_with_rcov') do |t|
  ENV["test"] = "true"
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = true
  t.rcov_opts = ['--text-report', '--exclude', "~/.gem,spec,Library,lib/castronaut/db,#{ENV['GEM_HOME']}", '--sort', 'coverage']
end

desc "Run all examples"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
  t.rcov = false
  t.spec_opts = ['-cfn']
end

RCov::VerifyTask.new(:verify_coverage => :specs_with_rcov) do |t|
  t.threshold = 96.38
  t.index_html = 'coverage/index.html'
end

namespace :ssl do

  desc "Generate a test SSL certificate for development"
  task :generate do
    FileUtils.mkdir_p('ssl') unless File.exist?('ssl')

    if %x{which openssl}.strip.size == 0
      puts "Unable to locate openssl, please make sure you have it installed and in your path."
    else
      system("openssl req -x509 -nodes -days 365 -subj '/C=US/ST=NC/L=CH/CN=localhost' -newkey rsa:1024 -keyout ssl/devcert.pem -out ssl/devcert.pem")
    end
  end

end

task :default => [:verify_coverage]
