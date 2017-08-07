require 'yaml'

describe I18nChecker::Locale::Files do
  describe '#to_h' do
    let(:ja_locale_file) { 'spec/fixtures/locales/files/ja.yml' }
    let(:en_locale_file) { 'spec/fixtures/locales/files/en.yml' }
    let(:locale_files) do
      I18nChecker::Locale::Files.new([
        I18nChecker::Locale::File.load_yaml_file(ja_locale_file),
        I18nChecker::Locale::File.load_yaml_file(en_locale_file)
      ])
    end
    subject { locale_files.to_h }
    it 'should be convert to hash object' do
      expect(subject['en']['nested.title']).to eq('title')
      expect(subject['ja']).to be_nil
    end
  end
end
