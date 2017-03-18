describe I18nChecker::Reporter::DefaultReporter do
  describe '#report' do
    let(:logger) do
      logger = Logger.new(STDOUT)
      logger.formatter = proc {|severity, datetime, progname, message|
        "#{message}\n"
      }
      logger
    end
    let(:reporter) { I18nChecker::Reporter::DefaultReporter.new(logger: logger) }
    let(:english_locale) do
      english_locale = {}
      english_locale['en'] = {}
      english_locale
    end
    let(:result) do
      I18nChecker::Detector::DetectedResult.new(
        [
          I18nChecker::Detector::LocaleTextResult.new(
            locale_text: I18nChecker::Locale::Text.new(
              file: 'example.haml',
              text: 'nested.title',
              line: 1,
              column: 1
            ),
            locale_file: I18nChecker::Locale::File.new(english_locale)
          )
        ]
      )
    end
    it 'should be display result' do
      reporter.report(result)
    end
  end
end
