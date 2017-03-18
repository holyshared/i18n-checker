describe I18nChecker::Cache::Lines do
  let(:lines) { I18nChecker::Cache::Lines.of("a\nb\nc\n") }
  describe '#lines_of' do
    subject { lines.lines_of(1..3) }
    context 'when valid range' do
      it 'should be return lines of range' do
        expect(subject.size).to eq(3)
      end
    end
    context 'when invalid range' do
      it 'should be raise error' do
        expect { lines.lines_of(0..1) }.to raise_error StandardError
        expect { lines.lines_of(1..4) }.to raise_error StandardError
      end
    end
  end
end
