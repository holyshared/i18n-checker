module I18nChecker
  module Collectible
    def collect(file)
    end

    def collect_all(files)
      files.map(&:collect).reduce { |texts, n| texts.concat(n) }
    end
  end
end
