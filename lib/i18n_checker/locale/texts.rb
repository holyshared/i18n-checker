require 'forwardable'
require 'i18n_checker/locale/text'

module I18nChecker
  module Locale
    # List of translated text
    #
    class Texts
      extend Forwardable

      include Enumerable

      def_delegators :texts, :size, :each, :select

      # Create list of translated text
      #
      # @param texts [Array<I18nChecker::Locale::Text>] List of translated text
      def initialize(texts = [])
        @texts = texts
      end

      # Combine lists of translated texts
      #
      # @param texts [Enumerable<I18nChecker::Locale::Text>] List of translated text
      # @return [I18nChecker::Locale::Texts<I18nChecker::Locale::Text>] Returns the combined receiver itself
      def concat(texts)
        @texts.concat(texts.to_a)
        self
      end

      # Delete translated text duplicates
      #
      # @return [I18nChecker::Locale::Texts<I18nChecker::Locale::Text>] Returns the combined receiver itself
      def uniq!
        @texts.uniq!
        self
      end

      # Compare lists of translated texts
      #
      # @return [Boolean]
      def ==(other)
        @texts == other.to_a
      end

      def [](key)
        @texts[key]
      end

      def detect(detector)
        detector.detect(texts)
      end

      private

        attr_reader :texts
    end
  end
end
