describe I18nChecker::Locale::Collector::Haml do
  describe '#collect' do
    let(:collector) { I18nChecker::Locale::Collector::Haml.new }
    context 'when has oneline_child element' do
      let(:haml_file) { 'spec/fixtures/haml/oneline_child.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 9
      end
    end
    context 'when has children element' do
      let(:haml_file) { 'spec/fixtures/haml/children.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('nested.title')
        expect(subject.line).to be 10
      end
    end
    context 'when has lazy lookup' do
      let(:haml_file) { 'spec/fixtures/haml/rails/app/views/books/index.html.haml' }
      subject { collector.collect(haml_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(haml_file)
        expect(subject.text).to eq('books.index.title')
        expect(subject.line).to be 10
      end
    end
  end
end
