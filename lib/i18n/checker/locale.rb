require "i18n/checker/locale/key_path"
require "i18n/checker/locale/locale_file"
require "i18n/checker/locale/locale_files"

module I18n
  module Checker
    module Locale
      module Methods
        def load_of(locale_files)
          loaded_locale_files = locale_files.map { |locale_file| I18n::Checker::Locale::LocaleFile.load_yaml_file(locale_file) }
          LocaleFiles.new(loaded_locale_files)
        end
      end
      extend Methods
    end
  end
end
