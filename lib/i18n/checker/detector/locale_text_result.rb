module I18n
  module Checker
    module Detector
      class LocaleTextResult
        def initialize(locale_file:, locale_text:)
          @locale_text = locale_text
          @locale_file = locale_file
        end

        def file_name
          @locale_text.file
        end
      end
    end
  end
end
