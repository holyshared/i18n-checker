describe I18nChecker::Detector::LocaleTextNotFound do
  describe '#detect' do
    let(:locale_texts) do
      I18nChecker::Locale::LocaleTexts.new([
        I18nChecker::Locale::LocaleText.new(
          file: 'example.haml',
          text: 'nested.title',
          line: 1,
          column: 1
        )
      ])
    end
    let(:locale_files) do
      en = I18nChecker::Locale::LocaleFile.load_yaml_file('spec/fixtures/locales/en.yml')
      ja = I18nChecker::Locale::LocaleFile.load_yaml_file('spec/fixtures/locales/ja.yml')
      I18nChecker::Locale::LocaleFiles.new([ en, ja ])
    end
    let(:detector) { I18nChecker::Detector::LocaleTextNotFound.new(locale_files) }
    subject { detector.detect(locale_texts) }
    it 'should be return detected texts' do
      expect(subject.locale_texts.size).to eq 1
      expect(subject.locale_texts.first.file_name).to eq 'example.haml'
    end
  end
end
