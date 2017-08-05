module I18nChecker
  module Locale
    # Translation text referenced from the file
    #
    # @attr_reader [String] file File referring to translated text
    # @attr_reader [String] text Translation text key
    # @attr_reader [Fixnum] line Line number of file
    # @attr_reader [Fixnum] column Column number of file
    class Text
      attr_reader :file, :text, :line, :column

      # Create translated text
      #
      # @param file [String] File referring to translated text
      # @param text [String] Translation text key
      # @param line [Fixnum] Line number of file
      # @param column [Fixnum] Column number of file
      def initialize(file:, text:, line:, column:)
        @file = file
        @text = text
        @line = line
        @column = column
      end
    end
  end
end
