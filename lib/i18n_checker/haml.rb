require "i18n_checker/locale/locale_text"
require "i18n_checker/locale/locale_texts"
require "i18n_checker/locale/collector/haml_collector"

module I18nChecker
  module Haml
    module Methods
      def collect_locale_text_of(files)
        collector = I18nChecker::Locale::Collector::HamlCollector.new
        locale_texts = I18nChecker::Locale::LocaleTexts.new

        haml_files = files.delete_if { |file| File.directory?(file) }.to_a
        haml_files.each do |haml_file|
          locale_texts.concat(collector.collect(haml_file))
        end
        locale_texts
      end
    end
    extend Methods
  end
end
