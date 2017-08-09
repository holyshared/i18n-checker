require 'fileutils'
require 'yaml'
require 'rspec/temp_dir'

describe I18nChecker::Unused::Result do
  describe '#apply' do
    include_context 'uses temp dir'
    let(:temp_yaml_file) { "#{temp_dir}/ja.yml" }
    let(:locale_file) do
      FileUtils.cp('spec/fixtures/locales/unused/ja.yml', temp_yaml_file)
      I18nChecker::Locale::File.load_yaml_file(temp_yaml_file)
    end
    let(:unused_result) do
      I18nChecker::Unused::Result.new(
        [
          I18nChecker::Unused::Text.new(
            text: 'nested.title',
            file: locale_file,
          ),
          I18nChecker::Unused::Text.new(
            text: 'nested1.nested2.title',
            file: locale_file,
          ),
        ],
      )
    end
    subject { YAML.load(::File.open(temp_yaml_file, &:read)) }
    before do
      unused_result.apply([locale_file])
    end
    it 'should be remove unused texts' do
      expect(subject['ja']['nested'].key?('title')).to eq(false)
      expect(subject['ja']['nested'].key?('description')).to eq(true)
      expect(subject['ja']['nested1']['nested2'].key?('title')).to eq(false)
      expect(subject['ja']['nested1']['nested2'].key?('description')).to eq(true)
    end
  end
end
