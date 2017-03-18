require 'forwardable'
require 'i18n_checker/locale/text'

module I18nChecker
  module Locale
    class Texts
      extend Forwardable

      include Enumerable

      def_delegators :texts, :size, :each

      def initialize(texts = [])
        @texts = texts
      end

      def concat(texts)
        @texts.concat(texts.to_a)
        self
      end

      def uniq!
        @texts.uniq!
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

