describe I18nChecker::Ruby::LocaleTextCollector do
  describe '#collect' do
    let(:collector) { I18nChecker::Ruby::LocaleTextCollector.new }
    let(:ruby_source_file) { 'spec/fixtures/ruby/lookup.rb' }
    subject { collector.collect(ruby_source_file).first }
    it 'should be return locale text' do
      expect(subject.file).to eq(ruby_source_file)
      expect(subject.text).to eq('example.title')
      expect(subject.line).to be 4
      expect(subject.column).to be 9
    end
  end
end
