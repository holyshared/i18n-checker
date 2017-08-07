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

      def each_file(&block)
        file_texts = locale_texts.group_by(&:file)
        file_texts.each do |file, texts|
          texts.sort do |a, b|
            lr = a.line <=> b.line
            next lr if lr != 0
            a.column <=> b.column
          end
          yield(file, texts)
        end
      end
    end
  end
end
