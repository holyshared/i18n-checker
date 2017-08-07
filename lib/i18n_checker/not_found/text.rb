require 'forwardable'

module I18nChecker
  module NotFound
    class Text
      extend Forwardable

      attr_reader :lang

      def_delegators :locale_text, :file, :line, :column, :text

      def initialize(lang:, locale_text:)
        @lang = lang
        @locale_text = locale_text
      end

      private

        attr_reader :locale_text
    end
  end
end
