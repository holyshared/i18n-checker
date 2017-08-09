require 'fileutils'
require 'yaml'
require 'rspec/temp_dir'

describe I18nChecker::Locale::File do
  describe '#save' do
    include_context 'uses temp dir'
    let(:temp_yaml_file) { "#{temp_dir}/ja.yml" }
    subject { YAML.load(::File.open(temp_yaml_file, &:read)) }
    before do
      FileUtils.cp('spec/fixtures/locales/file/ja.yml', temp_yaml_file)

      locale_file = I18nChecker::Locale::File.load_yaml_file(temp_yaml_file)
      locale_file.save
    end
    it 'should be file save' do
      expect(subject['ja']['nested']['title']).to eq('title')
      expect(subject['ja']['nested']['description']).to eq('description')
    end
  end

  describe '#remove_texts' do
    let(:temp_yaml_file) { 'spec/fixtures/locales/file/ja.yml' }
    let(:locale_file) { I18nChecker::Locale::File.load_yaml_file(temp_yaml_file) }
    subject { locale_file.remove_texts(['nested.title']).locale_texts }
    it 'should be remove texts' do
      expect(subject['nested.title']).to be_nil
      expect(subject['title']).to eq('title')
      expect(subject['nested.description']).to eq('description')
    end
  end
end
