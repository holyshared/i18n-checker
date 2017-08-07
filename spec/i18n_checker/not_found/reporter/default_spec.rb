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
    let(:result) do
      I18nChecker::NotFound::Result.new(
        [
          I18nChecker::NotFound::Text.new(
            lang: :en,
            locale_text: I18nChecker::Locale::Text.new(
              file: 'example.haml',
              text: 'nested.title',
              line: 1,
              column: 1
            )
          ),
          I18nChecker::NotFound::Text.new(
            lang: :en,
            locale_text: I18nChecker::Locale::Text.new(
              file: 'example.haml',
              text: 'nested.description',
              line: 1,
              column: 2
            )
          ),
        ]
      )
    end
    it 'should be display result' do
      reporter.report(result)
    end
  end
end
