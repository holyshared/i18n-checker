describe I18n::Checker::Reporter::Default do
  describe '#report' do
    let(:reporter) { I18n::Checker::Reporter::Default.new }
    let(:english_locale) do
      english_locale = {}
      english_locale['en'] = {}
      english_locale
    end
    let(:results) do
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
    end
    it 'should be display result' do
      reporter.report(results)
    end
  end
end
