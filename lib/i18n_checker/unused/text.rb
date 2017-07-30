require 'forwardable'

module I18nChecker
  module Unused
    class Text
      extend Forwardable

      attr_reader :file, :text

      def_delegators :file, :lang, :file_name

      def initialize(file:, text:)
        @file = file
        @text = text
      end
    end
  end
end
