module I18nChecker
  module Unused
    module Reporter
      class Base
        def initialize(logger: Logger.new(STDOUT))
          @logger = logger
        end

        private

          attr_reader :logger
      end
    end
  end
end
