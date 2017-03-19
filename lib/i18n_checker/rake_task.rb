require 'rake'
require 'rake/tasklib'
require 'i18n_checker/cache'
require 'i18n_checker/locale'
require 'i18n_checker/reporter'
require "i18n_checker/locale_text_not_found_checker"

module I18nChecker
  class RakeTask < ::Rake::TaskLib
    attr_accessor :name
    attr_accessor :reporter
    attr_accessor :template_paths
    attr_accessor :locale_file_paths
    attr_accessor :logger

    def initialize(name = :locale_check)
      @name = name
      @template_paths = FileList['app/views/*']
      @locale_file_paths = FileList['config/locales/*']
      @logger = Logger.new(STDOUT)
      @logger.formatter = proc {|severity, datetime, progname, message|
        "#{message}\n"
      }
      @reporter = I18nChecker::Reporter::DefaultReporter.new(logger: logger)
      yield self if block_given?
      define
    end

    private

    def define
      desc 'Check language files and templates.'
      task(name) { run_task }
    end

    def run_task
      checker = I18nChecker::LocaleTextNotFoundChecker.new(
        reporter: reporter,
        template_paths: template_paths,
        locale_file_paths: locale_file_paths
      )
      checker.check do |result|
        exit 0 if result.empty?
        exit 1
      end
    end
  end
end
