describe Haml::I18n::Checker::LocaleTextCollector do
  describe '#collect' do
    let(:haml_file) { 'spec/fixtures/simple.haml' }
    let(:haml_template) { File.open(haml_file, &:read) }
    let(:collector) { Haml::I18n::Checker::LocaleTextCollector.new }
    subject { collector.collect(haml_template) }
    it 'should be return locale text' do
      expect(subject).to eql(['nested.title'])
    end
  end
end
