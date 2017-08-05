module I18nChecker
  module NotFound
    class Result
      attr_reader :locale_texts

      def initialize(locale_texts = [])
        @locale_texts = locale_texts
      end

      def empty?
        locale_texts.empty?
      end
    end
  end
end
