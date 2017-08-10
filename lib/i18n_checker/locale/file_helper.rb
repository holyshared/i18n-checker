module I18nChecker
  module Locale
    module FileHelper
      # Translation key for lazy lookup
      # @see http://guides.rubyonrails.org/i18n.html#lazy-lookup
      def action_view_name_of(file)
        filename = file.dup
        filename.gsub!(%r{(.+/)?app/views/}, '')
        filename.gsub!(/\.html\.haml\z/, '')
        filename.split('/').join('.')
      end
    end
  end
end
