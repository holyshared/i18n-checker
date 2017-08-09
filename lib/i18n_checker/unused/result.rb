module I18nChecker
  module Unused
    # Detection result of unused translated text
    #
    # @attr_reader [Array<I18nChecker::Unused::Text>] unused_texts
    # @attr_reader [Hash<String, Array<I18nChecker::Unused::File>>] locale_files
    class Result
      attr_reader :unused_texts, :locale_files

      #
      #
      # @param unused_texts [Array<I18nChecker::Unused::Text>]
      def initialize(unused_texts = [])
        @unused_texts = unused_texts
        @locale_files = unused_texts.group_by(&:file_name)
      end

      #
      #
      # @return [Boolean]
      def empty?
        unused_texts.empty?
      end

      # Apply the detected unused translated text to the current translation file.
      # Unused text has been deleted from the translation file.
      #
      # @param target_locale_files [Array<I18nChecker::Locale::File>]
      # @return [Array<I18nChecker::Locale::File>]
      def apply(target_locale_files)
        locale_files = target_locale_files.
                         group_by(&:file_name).
                         map { |k, v| [k, v.first] }

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
