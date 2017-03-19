describe I18nChecker::Cache::Files do
  let(:file) { 'spec/fixtures/haml/children.haml' }
  let(:files) { I18nChecker::Cache::Files.new }
  let(:lines) { I18nChecker::Cache::Lines.new }
  describe '#read' do
    context 'when read of file' do
      subject { files.read(file) }
      it 'should be return file' do
        expect(subject.lines.size).to eq(10)
      end
    end
    context 'when cache exist' do
      let(:caches) do
        caches = double('caches')
        allow(caches).to receive(:key?).and_return(true)
        allow(caches).to receive(:[]).and_return(I18nChecker::Cache::File.new(file, lines))
        caches
      end
      let(:files) { I18nChecker::Cache::Files.new(caches) }
      it 'should be return cache' do
        expect(caches).to receive(:key?).with(file).once
        expect(caches).to receive(:[]).with(file).once
        files.read(file)
      end
    end
  end
end
