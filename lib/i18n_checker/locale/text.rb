module I18nChecker
  module Locale
    class Text
      attr_reader :file, :text, :line, :column

      def initialize(file:, text:, line:, column:)
        @file = file
        @text = text
        @line = line
        @column = column
      end
    end
  end
end
