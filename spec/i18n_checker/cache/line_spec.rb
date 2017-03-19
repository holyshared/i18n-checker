describe I18nChecker::Cache::Line do
  let(:line) { I18nChecker::Cache::Line.new(1, 'abcd') }
  describe '#[]' do
    subject { line[(1..3)] }
    context 'when valid range' do
      it 'should be return columns of range' do
        expect(subject.size).to eq(3)
      end
    end
  end
end
