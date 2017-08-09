require 'haml_parser'
require 'haml_parser/parser'
require 'i18n_checker/collectible'
require 'i18n_checker/locale/texts'

module I18nChecker
  module Locale
    module Collector
      class Haml
        include I18nChecker::Collectible

        attr_reader :file_caches

        def initialize(file_caches = I18nChecker::Cache::Files.new)
          @file_caches = file_caches
        end

        def collect(template_file)
          template = read_template_file(template_file)
          parser = HamlParser::Parser.new(filename: template_file)
          I18nChecker::Locale::Texts.new(collect_locale_texts(parser.call(template)))
        end

        private

          def read_template_file(template_file)
            file_caches.read(template_file).to_s
          end

          def collect_locale_texts(ast)
            locale_texts = []
            locale_texts << collect_locale_text(ast)
            return unless ast.respond_to?(:children)
            locale_texts << ast.children.map { |child| collect_locale_texts(child) }
            locale_texts.flatten.compact
          end

          def collect_locale_text(ast)
            return locale_text_from_script(ast) if ast.is_a?(HamlParser::Ast::Script)
            return unless ast.respond_to?(:oneline_child)
            return unless ast.oneline_child.is_a?(HamlParser::Ast::Script)
            locale_text_from_script(ast.oneline_child)
          end

          def locale_text_from_script(script_node)
            return if script_node.script == '""'
            translate_scripts = translate_scripts_from_script(script_node)
            return if translate_scripts.empty?

            translate_scripts.map do |script_params|
              (text_key, line, column) = script_params

              locale_text = if text_key =~ /^\.(.+)/
                              action_view = action_view_name_from_script(script_node)
                              "#{action_view}#{text_key}"
                            else
                              text_key
                            end

              I18nChecker::Locale::Text.new(
                file: script_node.filename,
                line: line,
                column: column,
                text: locale_text,
              )
            end
          end

          def translate_scripts_from_script(script_node)
            results = []
            file_cache = file_caches.read(script_node.filename)
            script_lines = script_node.script.split('\n')
            script_lines.each_with_index do |script_line, i|
              offset_at = 0
              translate_scripts = script_line.scan(/t\('[^']+'\)/)
              map_results = translate_scripts.map do |script|
                line = script_node.lineno + i
                text_key = script.gsub!(/t\('|'\)/, '')
                column = file_cache[line].start_of(text_key, offset_at)
                offset_at = column + 1
                [
                  text_key,
                  line,
                  column
                ]
              end
              results.concat(map_results)
            end
            results
          end

          # Translation key for lazy lookup
          # @see http://guides.rubyonrails.org/i18n.html#lazy-lookup
          def action_view_name_from_script(script_node)
            filename = script_node.filename.dup
            filename.gsub!(%r{(.+)/app/views/}, '')
            filename.gsub!(/\.html\.haml\z/, '')
            filename.split('/').join('.')
          end
      end
    end
  end
end
