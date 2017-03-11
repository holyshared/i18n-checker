describe I18n::Checker::Reporter::DefaultReporter do
  describe '#report' do
    let(:logger) do
      logger = Logger.new(STDOUT)
      logger.formatter = proc {|severity, datetime, progname, message|
        "#{message}\n"
      }
      logger
    end
    let(:reporter) { I18n::Checker::Reporter::DefaultReporter.new(logger: logger) }
    let(:english_locale) do
      english_locale = {}
      english_locale['en'] = {}
      english_locale
    end
    let(:result) do
      I18n::Checker::Detector::DetectedResult.new(
        [
          I18n::Checker::Detector::LocaleTextResult.new(
            locale_text: I18n::Checker::Haml::LocaleText.new(
              file: 'example.haml',
              text: 'nested.title',
              line: 1
            ),
            locale_file: I18n::Checker::Locale::LocaleFile.new(english_locale)
          )
        ]
      )
    end
    it 'should be display result' do
      reporter.report(result)
    end
  end
end
