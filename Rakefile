require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'i18n_checker/rake_task'

RSpec::Core::RakeTask.new(:spec)

I18nChecker::RakeTask.new do |task|
  task.template_paths = FileList['spec/fixtures/haml/*', 'spec/fixtures/ruby/*']
  task.locale_file_paths = FileList['spec/fixtures/locales/**']
end

task :default => :spec
