require 'logger'

module I18nChecker
  module NotFound
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
