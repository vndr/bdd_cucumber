
require 'rubygems'

begin
  require 'cucumber'
  require 'cucumber/rake/task'

  namespace :features do
    Cucumber::Rake::Task.new(:local) do |t|
      t.profile = 'local'
      if ENV['format'] == 'html' then      
        t.cucumber_opts = %w{--format html --out public/output.html}
      end
    end
    Cucumber::Rake::Task.new(:dev) do |t|
      t.profile = 'dev'
      t.cucumber_opts = %w{--format html --out public/output.html} # this is make it output a html file
    end
    Cucumber::Rake::Task.new(:qa) do |t|
      t.profile = 'qa'
      t.cucumber_opts = %w{--format html --out public/output.html} # this is make it output a html file
    end
    Cucumber::Rake::Task.new(:live) do |t|
      t.profile = 'live'
      t.cucumber_opts = %w{--format html --out public/output.html} # this is make it output a html file
    end

    task :ci => [:dev]
    task :default => :local
  end




rescue LoadError
  desc 'Cucumber rake task not available'
  task :features do
    abort 'Cucumber rake task is not available. Be sure to install cucumber as a gem or plugin'
  end
end



