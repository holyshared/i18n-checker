module I18nChecker
  module Unused
    class Result
      attr_reader :unused_texts

      def initialize(unused_texts = [])
        @unused_texts = unused_texts
      end

      def empty?
        unused_texts.empty?
      end
    end
  end
end
