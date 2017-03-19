require 'i18n_checker/locale/key_path'
require 'i18n_checker/locale/file'
require 'i18n_checker/locale/files'
require 'i18n_checker/locale/collector'

module I18nChecker
  module Locale
    module Methods
      def load_of(locale_files)
        loaded_locale_files = locale_files.map { |locale_file| I18nChecker::Locale::File.load_yaml_file(locale_file) }
        Files.new(loaded_locale_files)
      end

      def texts_of(resources)
        caches = I18nChecker::Cache::Files.new

        files = resources.delete_if { |resource| ::File.directory?(resource) }.to_a
        grouped_files = files.group_by { |file| ::File.extname(file) }
        grouped_locale_texts = grouped_files.map do |k, v|
          text_collector_of(k, caches: caches).collect_all(v)
        end
        grouped_locale_texts.reduce { |locale_texts, n| locale_texts.concat(n) }.uniq!
      end

      def text_collector_of(file_extname, caches:)
        case file_extname
        when '.haml'
          I18nChecker::Locale::Collector::Haml.new(caches)
        when '.rb'
          I18nChecker::Locale::Collector::Ruby.new(caches)
        else
          raise StandardError, "not support #{extname} file" # FIXME: throw custom error!!
        end
      end
    end
    extend Methods
  end
end
