module Haml
  module I18n
    module Checker
      class LocaleText
        attr_reader :file, :text, :line

        def initialize(file:, text:, line:)
          @file = file
          @text = text
          @line = line
        end
      end
    end
  end
end
