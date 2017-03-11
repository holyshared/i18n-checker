require 'colorator'

module I18n
  module Checker
    module Reporter
      class DefaultReporter < DetectResultReporter
        def report(results = [])
          results.each do |result|
            logger.info result.file_name.cyan
            logger.info "  #{result.line_of_file}: #{result.locale_text}"
          end
        end
      end
    end
  end
end
