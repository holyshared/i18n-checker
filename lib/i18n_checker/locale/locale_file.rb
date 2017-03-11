require 'yaml'

module I18nChecker
  module Locale
    class LocaleFile
      attr_reader :lang, :locale_texts

      class << self
        def load_yaml(s)
          new(YAML.load(s))
        end
        def load_yaml_file(yaml_file)
          load_yaml(File.open(yaml_file, &:read))
        end
      end

      def initialize(locale_texts = {})
        lang = locale_texts.keys.first
        @lang = lang.to_sym
        @locale_texts = compact_of(locale_texts[lang] || {})
      end

      def include?(locale_text)
        @locale_texts.key?(locale_text.text)
      end

      private

      def compact_of(values={}, path=KeyPath.new)
        result = {}
        values.each_with_index do |(i, v)|
          path.move_to(i)
          if v.is_a?(Hash)
            result.merge!(compact_of(v, path))
          else
            result[path.to_s] = v
          end
          path.leave
        end
        result
      end
    end
  end
end
