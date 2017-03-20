module I18nChecker
  module Collectible
    def collect(file)
    end

    def collect_all(files)
      texts = files.map { |file| collect(file) }
      texts.reduce { |merged_texts, n| merged_texts.concat(n) }
    end
  end
end
