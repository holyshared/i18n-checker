describe I18nChecker::Unused::Detector do
  describe '#detect' do
    let(:locale_texts) do
      I18nChecker::Locale::Texts.new([
        I18nChecker::Locale::Text.new(
          file: 'example.haml',
          text: 'nested.title',
          line: 1,
          column: 1,
        ),
      ])
    end
    let(:locale_files) do
      en = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/unused/en.yml')
      ja = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/unused/ja.yml')
      I18nChecker::Locale::Files.new([en, ja])
    end
    let(:detector) { I18nChecker::Unused::Detector.new(locale_files) }
    subject { detector.detect(locale_texts) }
    it 'should be return detected texts' do
      expect(subject.unused_texts.size).to eq 4
    end
  end
end
