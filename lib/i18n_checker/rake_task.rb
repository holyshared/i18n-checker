require 'rake'
require 'rake/tasklib'
require 'i18n_checker/locale'
require 'i18n_checker/reporter'
require "i18n_checker/locale_text_not_found_checker"

module I18nChecker
  class RakeTask < ::Rake::TaskLib
    attr_accessor :name
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
      yield self if block_given?
      define
    end

    private

    def define
      desc 'Check language files and templates.'
      task(name) { run_task }
    end

    def run_task
      reporter = I18nChecker::Reporter::DefaultReporter.new(logger: logger)
      locale_texts = I18nChecker::Locale.texts_of(template_paths)
      locale_files = I18nChecker::Locale.load_of(locale_file_paths)

      checker = I18nChecker::LocaleTextNotFoundChecker.new(
        reporter: reporter,
        locale_texts: locale_texts,
        locale_files: locale_files
      )
      checker.check
    end
  end
end
