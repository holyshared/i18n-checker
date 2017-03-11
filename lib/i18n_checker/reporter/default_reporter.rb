require 'colorator'

module I18nChecker
  module Reporter
    class DefaultReporter < DetectResultReporter
      def report(result)
        logger.info 'There are settings where translated text can not be found'.red
        result.locale_texts.each do |locale_text|
          logger.info "  #{locale_text.file_name.cyan}"
          logger.info "    line: #{locale_text.line} - #{locale_text.lang}.#{locale_text.text}"
        end
      end
    end
  end
end
