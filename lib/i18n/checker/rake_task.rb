require 'rake'
require 'rake/tasklib'
require 'i18n/checker/locale'
require 'i18n/checker/haml'
require 'i18n/checker/reporter'
require "i18n/checker/locale_text_not_found_checker"

module I18n
  module Checker
    class RakeTask < ::Rake::TaskLib
      attr_accessor :name
      attr_accessor :locale_file_paths
      attr_accessor :haml_template_paths

      def initialize(name = :locale_check)
        @name = name
        @haml_template_paths = FileList['./app/views/*']
        @locale_file_paths = FileList['./locales/*']
        yield self if block_given?
        define
      end

      private

      def define
        desc 'Check language files and templates.'
        task(name) { run_task }
      end

      def run_task
        reporter = I18n::Checker::Reporter::DefaultReporter.new
        locale_files = I18n::Checker::Locale.load_of(locale_file_paths)
        locale_texts = I18n::Checker::Haml.collect_locale_text_of(haml_template_paths)

        checker = I18n::Checker::LocaleTextNotFoundChecker.new(
          reporter: reporter,
          locale_texts: locale_texts
        )
        checker.check(locale_files)
      end
    end
  end
end
