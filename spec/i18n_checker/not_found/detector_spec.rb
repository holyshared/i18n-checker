describe I18nChecker::NotFound::Detector do
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
      en = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/not_found/en.yml')
      ja = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/not_found/ja.yml')
      models_en = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/not_found/models.en.yml')
      models_ja = I18nChecker::Locale::File.load_yaml_file('spec/fixtures/locales/not_found/models.ja.yml')
      I18nChecker::Locale::Files.new([en, ja, models_en, models_ja])
    end
    let(:detector) { I18nChecker::NotFound::Detector.new(locale_files) }
    subject { detector.detect(locale_texts) }
    it 'should be return detected texts' do
      expect(subject.locale_texts.size).to eq 1
      expect(subject.locale_texts.first.file).to eq 'example.haml'
    end
  end
end
