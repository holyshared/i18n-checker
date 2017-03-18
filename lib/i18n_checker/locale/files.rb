require 'forwardable'

module I18nChecker
  module Locale
    class Files
      extend Forwardable

      include Enumerable

      def_delegators :locale_files, :size, :each

      def initialize(locale_files = [])
        @locale_files = locale_files
      end

      def delete_if(&block)
        locale_files.delete_if(&block)
        self
      end

      private

      attr_reader :locale_files
    end
  end
end
