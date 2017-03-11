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

        def line
          @locale_text.line
        end

        def text
          @locale_text.text
        end
      end
    end
  end
end
