describe I18nChecker::Unused::Reporter::Default do
  describe '#report' do
    let(:logger) do
      logger = Logger.new(STDOUT)
      logger.formatter = proc { |_severity, _datetime, _progname, message|
        "#{message}\n"
      }
      logger
    end
    let(:reporter) { I18nChecker::Unused::Reporter::Default.new(logger: logger) }
    let(:english_locale) do
      english_locale = {}
      english_locale['en'] = {
        nested: {
          title: 'foo',
        },
      }
      english_locale
    end
    let(:result) do
      I18nChecker::Unused::Result.new(
        [
          I18nChecker::Unused::Text.new(
            text: 'nested.title',
            file: I18nChecker::Locale::File.new('config/locale/en.yml', english_locale)
          ),
        ]
      )
    end
    it 'should be display result' do
      reporter.report(result)
    end
  end
end
