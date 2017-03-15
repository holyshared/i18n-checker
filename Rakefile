require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'i18n_checker/rake_task'

RSpec::Core::RakeTask.new(:spec)

I18nChecker::RakeTask.new do |task|
  task.locale_file_paths = FileList['spec/fixtures/locales/**']
  task.haml_template_paths = FileList['spec/fixtures/haml/*']
end

task :default => :spec
