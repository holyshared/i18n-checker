require 'optparse'

module I18nChecker
  module CLI
    class ArgParser
      class Clean
        attr_reader :source_files, :locale_files, :reporter

        def initialize
          @source_files = []
          @locale_files = []
          logger = Logger.new(STDOUT, formatter: proc { |_severity, _datetime, _progname, message| "#{message}\n" })
          @reporter = I18nChecker::Unused::Reporter::Default.new(logger: logger)
          define_options
        end

        def parse(*args)
          @parser.parse!(args)
          {
            source_files: source_files,
            locale_files: locale_files,
            reporter: reporter,
          }
        end

        private

          def define_options
            @parser = OptionParser.new
            @parser.on('--source SOURCE_PATH') do |s|
              @source_files.concat(files_from(s))
            end
            @parser.on('--locale LOCALE_PATH') do |s|
              @locale_files.concat(files_from(s))
            end
          end

          def files_from(path)
            Dir.glob(path).delete_if { |_f| ::File.directory?(resource) }
          end
      end
    end
  end
end
