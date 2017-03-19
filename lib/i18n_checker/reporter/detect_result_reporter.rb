require 'logger'

module I18nChecker
  module Reporter
    class DetectResultReporter
      def initialize(logger: Logger.new(STDOUT))
        @logger = logger
      end

      private

        attr_reader :logger
    end
  end
end
