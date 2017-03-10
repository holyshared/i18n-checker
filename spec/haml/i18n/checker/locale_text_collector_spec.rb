describe Haml::I18n::Checker::LocaleTextCollector do
  describe '#collect' do
    let(:haml_file) { 'spec/fixtures/simple.haml' }
    let(:collector) { Haml::I18n::Checker::LocaleTextCollector.new }
    subject { collector.collect(haml_file).first }
    it 'should be return locale text' do
      expect(subject.file).to eq(haml_file)
      expect(subject.text).to eq('nested.title')
      expect(subject.line).to be 9
    end
  end
end
