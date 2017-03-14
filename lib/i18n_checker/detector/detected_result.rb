module I18nChecker
  module Detector
    class DetectedResult
      attr_reader :locale_texts

      def initialize(locale_texts = [])
        @locale_texts = locale_texts
      end
    end
  end
end