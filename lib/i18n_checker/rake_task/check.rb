require 'rake'
require 'rake/tasklib'
require 'i18n_checker/cache'
require 'i18n_checker/locale'
require 'i18n_checker/not_found/reporter/base'
require 'i18n_checker/not_found/reporter/default'
require 'i18n_checker/command/check'

module I18nChecker
  module RakeTask
    class Check < ::Rake::TaskLib
      attr_accessor :name
      attr_accessor :reporter
      attr_accessor :source_paths
      attr_accessor :locale_file_paths
      attr_accessor :logger

      def initialize(name = :locale_check)
        @name = name
        @source_paths = FileList['app/views/*', 'app/controllers/*', 'app/jobs/*', 'app/models/*', 'app/helpers/*']
        @locale_file_paths = FileList['config/locales/*']
        @logger = Logger.new(STDOUT)
        @logger.formatter = proc { |_severity, _datetime, _progname, message|
          "#{message}\n"
        }
        @reporter = I18nChecker::NotFound::Reporter::Default.new(logger: logger)
        yield self if block_given?
        define
      end

      private

        def define
          desc 'Check language files and templates.'
          task(name) { run_task }
        end

        def run_task
          commmand = I18nChecker::Command::Check.new(
            reporter: reporter,
            source_paths: source_paths,
            locale_file_paths: locale_file_paths
          )
          commmand.check do |result|
            exit 1 unless result.empty?
          end
        end
    end
  end
end
