module I18nChecker
  module NotFound
    class Detector
      def initialize(locale_files)
        @locale_texts = locale_files.to_h
      end

      def detect(locale_texts)
        results = locale_texts.map { |local_text| detect_not_found(local_text) }
        Result.new(results.compact.flatten)
      end

      private

        def detect_not_found(locale_text)
          not_founds = @locale_texts.reject do |_lang, texts|
            next false if texts.nil?
            texts.key?(locale_text.text)
          end
          not_founds.keys.map do |not_found_lang|
            Text.new(
              lang: not_found_lang.to_sym,
              locale_text: locale_text,
            )
          end
        end
    end
  end
end
