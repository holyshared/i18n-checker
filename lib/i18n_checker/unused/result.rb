module I18nChecker
  module Unused
    class Result
      attr_reader :unused_texts, :locale_files

      def initialize(unused_texts = [])
        @unused_texts = unused_texts
        @locale_files = unused_texts.group_by { |unused_text| unused_text.file_name  }
      end

      def empty?
        unused_texts.empty?
      end
    end
  end
end
