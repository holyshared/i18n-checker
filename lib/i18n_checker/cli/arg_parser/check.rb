require 'optparse'

module I18nChecker
  module CLI
    class ArgParser
      class Check
        attr_reader :source_files, :locale_files, :reporter

        def initialize
          @parser = OptionParser.new
          @parser.on('--source SOURCE_PATH') do |s|
            @source_files.concat(files_from(s))
          end
          @parser.on('--locale LOCALE_PATH') do |s|
            @locale_files.concat(files_from(s))
          end
          @source_files = []
          @locale_files = []
          @reporter = I18nChecker::NotFound::Reporter::Default.new
        end

        def parse(*args)
          @parser.parse!(args)
          {
            source_files: source_files,
            locale_files: locale_files,
            reporter: reporter
          }
        end

        private

        def files_from(path)
          Dir.glob(path).delete_if { |f| ::File.directory?(resource) }
        end
      end
    end
  end
end
