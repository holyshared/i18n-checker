module I18n
  module Checker
    module Haml
      class LocaleTexts
        include Enumerable

        def initialize(texts = [])
          @texts = texts
        end

        def each(&block)
          texts.each(&block)
        end

        def ==(other)
          @texts == other.to_a
        end

        private

        attr_reader :texts
      end
    end
  end
end
