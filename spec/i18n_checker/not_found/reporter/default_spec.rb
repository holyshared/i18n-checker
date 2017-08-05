describe I18nChecker::NotFound::Reporter::Default do
  describe '#report' do
    let(:logger) do
      logger = Logger.new(STDOUT)
      logger.formatter = proc { |_severity, _datetime, _progname, message|
        "#{message}\n"
      }
      logger
    end
    let(:reporter) { I18nChecker::NotFound::Reporter::Default.new(logger: logger) }
    let(:english_locale) do
      english_locale = {}
      english_locale['en'] = {}
      english_locale
    end
    let(:result) do
      I18nChecker::NotFound::Result.new(
        [
          I18nChecker::NotFound::Text.new(
            locale_text: I18nChecker::Locale::Text.new(
              file: 'example.haml',
              text: 'nested.title',
              line: 1,
              column: 1
            ),
            locale_file: I18nChecker::Locale::File.new('config/locale/en.yml', english_locale)
          ),
        ]
      )
    end
    it 'should be display result' do
      reporter.report(result)
    end
  end
end
