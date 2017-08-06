require 'optparse'
require 'i18n_checker/cli/arg_parser/result'
require 'i18n_checker/cli/arg_parser/check'
require 'i18n_checker/cli/arg_parser/clean'

module I18nChecker
  module CLI
    class ArgParser
      def initialize
        @parser = OptionParser.new
        @parsers = {
          check: I18nChecker::CLI::ArgParser::Check,
          clean: I18nChecker::CLI::ArgParser::Clean,
        }
      end

      def parse(*args)
        @parser.order!(args)
        subcommand = args.shift
        raise OptionParser::InvalidArgument, "command #{subcommand} not supported" unless @parsers.key?(subcommand.to_sym)
        parser = @parsers[subcommand.to_sym].new
        Result.new(subcommand, parser.parse(*args))
      end
    end
  end
end
