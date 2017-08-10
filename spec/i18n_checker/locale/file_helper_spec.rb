describe I18nChecker::Locale::FileHelper do
  let(:included_object) do
    object = Object.new
    object.extend(I18nChecker::Locale::FileHelper)
  end
  describe '#action_view_name_of' do
    context 'when rails root directory' do
      let(:file_path) { 'app/views/books/index.html.haml' }
      subject { included_object.action_view_name_of(file_path) }
      it 'should be return locale text prefix' do
        expect(subject).to eq('books.index')
      end
    end
    context 'when not rails root directory' do
      let(:file_path) { '/var/foo/app/views/books/index.html.haml' }
      subject { included_object.action_view_name_of(file_path) }
      it 'should be return locale text prefix' do
        expect(subject).to eq('books.index')
      end
    end
  end
end
