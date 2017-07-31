require 'yaml'

module I18nChecker
  module Locale
    class File
      attr_reader :file_name, :lang, :locale_texts

      class << self
        def load_yaml_file(yaml_file)
          new(yaml_file, YAML.load(::File.open(yaml_file, &:read)))
        end
      end

      def initialize(yaml_file, locale_texts = {})
        lang = locale_texts.keys.first
        @lang = lang.to_sym
        @locale_texts = compact_of(locale_texts[lang] || {})
        @file_name = yaml_file
      end

      def include?(locale_text)
        @locale_texts.key?(locale_text.text)
      end

      def remove_texts(locale_texts)
        registry = locale_texts.map { |locale_text| [locale_text, true] }.to_h

        current_locale_texts = @locale_texts.dup
        current_locale_texts.delete_if { |locale_text| registry.key?(locale_text) }

        remain_texts = {}
        remain_texts[@lang] = current_locale_texts

        self.class.new(file_name, remain_texts)
      end

      def save
        locale = {}
        locale[@lang.to_s] = tree_of(locale_texts)
        yaml_file = ::File.open(file_name, 'w')
        yaml_file.write(YAML.dump(locale))
        yaml_file.close
      end

      private

        def compact_of(values = {}, path = KeyPath.new)
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

        def tree_of(values = [])
          result = {}
          values.each do |path, value|
            dest = nil
            paths = path.split('.')
            last_key = paths.last
            paths.pop
            paths.each do |p|
              if result.key?(p)
                dest = result[p]
              else
                result[p] = {}
                dest = result[p]
              end
            end
            dest[last_key] = value
          end
          result
        end
    end
  end
end
