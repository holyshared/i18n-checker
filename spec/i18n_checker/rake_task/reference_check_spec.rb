describe I18nChecker::RakeTask::ReferenceCheck do
  describe '#invoke' do
    before do
      I18nChecker::RakeTask::ReferenceCheck.new do |task|
        task.source_paths = FileList[
          'spec/fixtures/reference_check/haml/*',
          'spec/fixtures/reference_check/ruby/*'
        ]
        task.locale_file_paths = FileList['spec/fixtures/reference_check/locales/*']
      end
    end
    it 'should be display result' do
      expect { Rake::Task[:locale_reference_check].invoke }.to raise_error(SystemExit)
    end
  end
end
