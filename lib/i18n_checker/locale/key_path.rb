module I18nChecker
  module Locale
    class KeyPath
      attr_reader :keys

      def initialize
        @keys = []
      end

      def move_to(key)
        @keys.push(key)
      end

      def leave
        @keys.pop
      end

      def current
        @keys.join('.')
      end

      def to_s
        current
      end
    end
  end
end
