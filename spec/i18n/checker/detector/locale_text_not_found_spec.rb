describe I18n::Checker::Detector::LocaleTextNotFound do
  describe '#detect' do
    let(:locale_texts) do
      I18n::Checker::Haml::LocaleTexts.new([
        I18n::Checker::Haml::LocaleText.new(
          file: 'example.haml',
          text: 'nested.title',
          line: 1
        )
      ])
    end
    let(:locale_files) do
      en = I18n::Checker::Locale::LocaleFile.load_yaml_file('spec/fixtures/locales/en.yml')
      ja = I18n::Checker::Locale::LocaleFile.load_yaml_file('spec/fixtures/locales/ja.yml')
      I18n::Checker::Locale::LocaleFiles.new([ en, ja ])
    end
    let(:detector) { I18n::Checker::Detector::LocaleTextNotFound.new(locale_files) }
    subject { detector.detect(locale_texts) }
    it 'should be return detected texts' do
      expect(subject.locale_texts.size).to eq 1
      expect(subject.locale_texts.first.file_name).to eq 'example.haml'
    end
  end
end
