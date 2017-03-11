module I18n
  module Checker
    module Reporter
      class Default
        def report(results = [])
          results.each do |result|
            puts result.file_name
            puts "  #{result.line_of_file}: #{result.locale_text}"
          end
        end
      end
    end
  end
end
