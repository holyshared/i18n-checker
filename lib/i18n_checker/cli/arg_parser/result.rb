require 'optparse'

module I18nChecker
  module CLI
    class ArgParser
      class Result
        attr_reader :command, :options

        def initialize(command, options = {})
          @command = command.to_sym
          @options = options
        end
      end
    end
  end
end
