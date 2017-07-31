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

      def apply(target_locale_files)
        locale_files = target_locale_files
          .group_by { |lf| lf.file_name }
          .map { |k,v| [k,v.first] }

        cleanup_locale_files = locale_files.map do |file_name, locale_file|
          return locale_file unless @locale_files.key?(file_name)
          unused_texts = @locale_files[file_name]
          locale_file.remove_texts(unused_texts.map(&:text))
        end
        cleanup_locale_files.each(&:save)
      end
    end
  end
end
