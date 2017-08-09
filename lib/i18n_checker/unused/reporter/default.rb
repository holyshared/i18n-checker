require 'colorator'
require 'i18n_checker/unused/reporter/base'

module I18nChecker
  module Unused
    module Reporter
      class Default < Base
        CHECK_COMPLETED = 'Checking of unused translated text is finished.'.freeze

        #
        # @param unused_result [I18nChecker::Unused::Result]
        def report(unused_result)
          return passed if unused_result.empty?
          failed(unused_result)
        end

        private

          def passed
            logger.info CHECK_COMPLETED.green
            logger.info 'Unused translation text was not found'.green
          end

          def failed(unused_result)
            logger.info CHECK_COMPLETED.red
            logger.info "An unused translation text was found.\n".red
            unused_result.locale_files.each do |file_name, unused_texts|
              logger.info file_name.cyan.to_s
              unused_texts.map { |text| logger.info "  #{text.text}" }
            end
          end
      end
    end
  end
end
