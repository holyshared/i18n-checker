describe I18nChecker::Locale::Collector::Ruby do
  let(:collector) { I18nChecker::Locale::Collector::Ruby.new }
  describe '#collect' do
    context 'when t(\'xyz\')' do
      let(:ruby_source_file) { 'spec/fixtures/ruby/lookup.rb' }
      subject { collector.collect(ruby_source_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(ruby_source_file)
        expect(subject.text).to eq('example.title')
        expect(subject.line).to be 4
        expect(subject.column).to be 9
      end
    end
    context 'when I18n.t(\'xyz\')' do
      let(:ruby_source_file) { 'spec/fixtures/ruby/lookup_receiver.rb' }
      subject { collector.collect(ruby_source_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(ruby_source_file)
        expect(subject.text).to eq('recevier.example.title')
        expect(subject.line).to be 4
        expect(subject.column).to be 14
      end
    end
    context 'when I18n.t \'xyz\'' do
      let(:ruby_source_file) { 'spec/fixtures/ruby/lookup_bracket.rb' }
      subject { collector.collect(ruby_source_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(ruby_source_file)
        expect(subject.text).to eq('bracket.example.title')
        expect(subject.line).to be 4
        expect(subject.column).to be 14
      end
    end
    context 'when "expression: t(\'xyz\')"' do
      let(:ruby_source_file) { 'spec/fixtures/ruby/lookup_expression.rb' }
      subject { collector.collect(ruby_source_file).first }
      it 'should be return locale text' do
        expect(subject.file).to eq(ruby_source_file)
        expect(subject.text).to eq('expression.example.title')
        expect(subject.line).to be 4
        expect(subject.column).to be 24
      end
    end
  end
end
