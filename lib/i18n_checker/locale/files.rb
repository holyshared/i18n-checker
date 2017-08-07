require 'forwardable'

module I18nChecker
  module Locale
    class Files
      extend Forwardable

      include Enumerable

      def_delegators :locale_files, :size, :each, :map

      # Translation files for each language
      #
      # @param locale_files [Array<I18nChecker::Locale::File>]
      def initialize(locale_files = [])
        @locale_files = locale_files
      end

      # Execute the specified block and delete the translation file
      #
      # @yield [file] Block to be evaluated
      # @yieldparam [I18nChecker::Locale::File]
      # @yieldreturn [Boolean]
      # @return [I18nChecker::Locale::Files]
      def delete_if(&block)
        locale_files.delete_if(&block)
        self
      end

      def to_h
        all_locale_texts = {}
        locale_files.each do |locale_file|
          lang = locale_file.lang.to_s
          next all_locale_texts[lang] = nil if locale_file.empty?
          all_locale_texts[lang] = {} if !all_locale_texts.key?(lang) || all_locale_texts[lang].nil?
          locale_file.locale_texts.each do |k, v|
            next if all_locale_texts[lang].key?(k)
            all_locale_texts[lang][k] = v
          end
        end
        all_locale_texts
      end

      private

        attr_reader :locale_files
    end
  end
end
