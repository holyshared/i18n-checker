module I18nChecker
  module Haml
    class LocaleText
      attr_reader :file, :text, :line

      def initialize(file:, text:, line:)
        @file = file
        @text = text
        @line = line
      end
    end
  end
end
