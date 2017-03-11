require 'colorator'

module I18n
  module Checker
    module Reporter
      class DefaultReporter < DetectResultReporter
        def report(result)
          result.locale_texts.each do |locale_text|
            logger.info locale_text.file_name.cyan
            logger.info "  line: #{locale_text.line} - #{locale_text.text}"
          end
        end
      end
    end
  end
end
