require 'i18n_checker/cli/arg_parser'
require 'i18n_checker/command/check'
require 'i18n_checker/command/clean'

module I18nChecker
  module CLI
    class App
      def initialize
        @parser = I18nChecker::CLI::ArgParser.new
        @commands = {
          check: I18nChecker::Command::Check,
          clean: I18nChecker::Command::Clean
        }
      end

      def run(*args)
        result = @parser.parse(*args)
        run_command(result)
      end

      private

      def run_command(result)
        @commands[result.command].new(result.options).run()
      end
    end
  end
end
