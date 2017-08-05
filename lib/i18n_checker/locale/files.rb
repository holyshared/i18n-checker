require 'forwardable'

module I18nChecker
  module Locale
    class Files
      extend Forwardable

      include Enumerable

      def_delegators :locale_files, :size, :each

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

      private

        attr_reader :locale_files
    end
  end
end
