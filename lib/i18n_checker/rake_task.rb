require 'rake'
require 'rake/tasklib'
require 'i18n_checker/locale'
require 'i18n_checker/reporter'
require "i18n_checker/locale_text_not_found_checker"

module I18nChecker
  class RakeTask < ::Rake::TaskLib
    attr_accessor :name
    attr_accessor :locale_file_paths
    attr_accessor :haml_template_paths
    attr_accessor :logger

    def initialize(name = :locale_check)
      @name = name
      @haml_template_paths = FileList['./app/views/*']
      @locale_file_paths = FileList['./locales/*']
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
      locale_files = I18nChecker::Locale.load_of(locale_file_paths)
      locale_texts = I18nChecker::Locale.texts_of(haml_template_paths)

      checker = I18nChecker::LocaleTextNotFoundChecker.new(
        reporter: reporter,
        locale_texts: locale_texts
      )
      checker.check(locale_files)
    end
  end
end
