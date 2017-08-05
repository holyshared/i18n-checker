module I18nChecker
  module NotFound
    class Detector
      def initialize(locale_files)
        @locale_files = locale_files
      end

      def detect(locale_texts)
        results = locale_texts.map { |local_text| detect_not_found(local_text) }
        Result.new(results.compact.flatten)
      end

      private

        def detect_not_found(locale_text)
          locale_files = @locale_files.dup
          locale_files.delete_if { |locale_file| locale_file.include?(locale_text) }
          locale_files.map do |locale_file|
            Text.new(
              locale_text: locale_text,
              locale_file: locale_file
            )
          end
        end
    end
  end
end