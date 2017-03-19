require "i18n_checker/detector/locale_text_not_found"
require "i18n_checker/detector/text_result"
require "i18n_checker/detector/detected_result"

module I18nChecker
  class LocaleTextNotFoundChecker
    def initialize(locale_file_paths: [], template_paths: [], reporter:)
      @reporter = reporter
      @locale_texts = I18nChecker::Locale.texts_of(template_paths)
      @locale_files = I18nChecker::Locale.load_of(locale_file_paths)
    end

    def check
      not_found_detector = I18nChecker::Detector::LocaleTextNotFound.new(@locale_files)
      not_found_result = @locale_texts.detect(not_found_detector) 
      @reporter.report not_found_result
      yield not_found_result if block_given?
    end
  end
end
