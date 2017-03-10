describe Haml::I18n::Checker::LocaleTextCollector do
  describe '#collect' do
    let(:collector) { Haml::I18n::Checker::LocaleTextCollector.new }
    context 'when has oneline_child element' do
      let(:haml_file) { 'spec/fixtures/oneline_child.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 9
      end
    end
    context 'when has children element' do
      let(:haml_file) { 'spec/fixtures/children.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 10
      end
    end
  end
end
