module I18nChecker
  module Locale
    class LocaleFiles
      include Enumerable

      def initialize(locale_files = [])
        @locale_files = locale_files
      end

      def each(&block)
        locale_files.each(&block)
      end

      def delete_if(&block)
        locale_files.delete_if(&block)
      end

      private

      attr_reader :locale_files
    end
  end
end
