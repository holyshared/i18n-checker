describe I18nChecker::Locale do
  describe '#texs_of' do
    let(:resources) { FileList['spec/fixtures/haml/**', 'spec/fixtures/ruby/**'] }
    subject { I18nChecker::Locale::texts_of(resources) }
    it 'should be display result' do
      expect(subject.size).to eq(6) 
    end
  end
end
