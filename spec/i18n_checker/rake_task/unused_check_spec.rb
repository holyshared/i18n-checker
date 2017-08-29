describe I18nChecker::RakeTask::UnusedCheck do
  describe '#invoke' do
    before do
      I18nChecker::RakeTask::UnusedCheck.new do |task|
        task.source_paths = FileList[
          'spec/fixtures/unused_check/haml/*',
          'spec/fixtures/unused_check/ruby/*'
        ]
        task.locale_file_paths = FileList['spec/fixtures/unused_check/locales/*']
      end
    end
    it 'should be display result' do
      expect { Rake::Task[:locale_unused_check].invoke }.to raise_error(SystemExit)
    end
  end
end
