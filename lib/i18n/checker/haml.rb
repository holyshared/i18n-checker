require "i18n/checker/haml/locale_text"
require "i18n/checker/haml/locale_texts"
require "i18n/checker/haml/locale_text_collector"

module I18n
  module Checker
    module Haml
      module Methods
        def collect_locale_text_of(files)
          collector = I18n::Checker::Haml::LocaleTextCollector.new
          locale_texts = I18n::Checker::Haml::LocaleTexts.new

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
end
