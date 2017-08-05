require 'i18n_checker/unused/text'
require 'i18n_checker/unused/result'

module I18nChecker
  module Unused
    class Detector
      def initialize(locale_files)
        @locale_files = locale_files
      end

      def detect(locale_texts)
        unused_texts = cleaned_locale_files(locale_texts).map do |locale_file|
          locale_file.locale_texts.map do |key, v|
            I18nChecker::Unused::Text.new(
              text: key,
              file: locale_file
            )
          end
        end
        I18nChecker::Unused::Result.new(unused_texts.compact.flatten)
      end

      private

        def cleaned_locale_files(locale_texts)
          remove_locale_texts = used_locale_texts(locale_texts)
          @locale_files.map { |locale_file| locale_file.remove_texts(remove_locale_texts) }
        end

        def used_locale_texts(locale_texts)
          used_locale_texts = locale_texts.dup.select do |locale_text|
            @locale_files.any? { |locale_file| locale_file.include?(locale_text) }
          end
          used_locale_texts.map(&:text)
        end
    end
  end
end
