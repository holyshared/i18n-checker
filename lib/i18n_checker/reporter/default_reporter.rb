require 'colorator'

module I18nChecker
  module Reporter
    class DefaultReporter < DetectResultReporter
      CHECK_COMPLETED = 'Translation text checking is complete.'

      def report(result)
        return passed if result.empty?
        failed(result)
      end

      def passed
        logger.info CHECK_COMPLETED.green
        logger.info 'There was no translated text that can not be referenced'.green
      end

      def failed(result)
        logger.info CHECK_COMPLETED.red
        logger.info "There are settings where translated text can not be found\n".red
        result.locale_texts.each do |locale_text|
          logger.info "#{locale_text.file_name.cyan}"
          logger.info "  line:#{locale_text.line}, column:#{locale_text.column} - #{locale_text.lang}.#{locale_text.text}"
        end
      end
    end
  end
end
