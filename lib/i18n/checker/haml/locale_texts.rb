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

        def concat(texts)
          @texts.concat(texts.to_a)
          self
        end

        def ==(other)
          @texts == other.to_a
        end

        def detect(detector)
          detector.detect(texts)
        end

        private

        attr_reader :texts
      end
    end
  end
end
