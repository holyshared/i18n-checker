require 'haml_parser'
require 'haml_parser/parser'
require 'i18n_checker/collectible'
require 'i18n_checker/locale/texts'
require 'i18n_checker/locale/file_helper'

module I18nChecker
  module Locale
    module Collector
      class Haml
        include I18nChecker::Collectible
        include I18nChecker::Locale::FileHelper

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
            return locale_text_from_text(ast) if ast.is_a?(HamlParser::Ast::Text)
            return locale_text_from_script(ast) if ast.is_a?(HamlParser::Ast::Script)
            return unless ast.respond_to?(:oneline_child)
            if ast.oneline_child.is_a?(HamlParser::Ast::Text)
              locale_text_from_text(ast.oneline_child)
            elsif ast.oneline_child.is_a?(HamlParser::Ast::Script)
              locale_text_from_script(ast.oneline_child)
            end
          end

          def locale_text_from_text(text_node)
            return if text_node.text == '""'
            translate_scripts = translate_scripts_from_node(text_node)
            return if translate_scripts.empty?
            create_node_result(text_node, translate_scripts)
          end

          def locale_text_from_script(script_node)
            return if script_node.script == '""'
            translate_scripts = translate_scripts_from_node(script_node)
            return if translate_scripts.empty?
            create_node_result(script_node, translate_scripts)
          end

          def create_node_result(ast_node, translate_scripts)
            translate_scripts.map do |script_params|
              (text_key, line, column) = script_params

              locale_text = if text_key =~ /^\.(.+)/
                              action_view = action_view_name_of(ast_node.filename.dup)
                              "#{action_view}#{text_key}"
                            else
                              text_key
                            end

              I18nChecker::Locale::Text.new(
                file: ast_node.filename,
                line: line,
                column: column,
                text: locale_text,
              )
            end
          end

          def translate_scripts_from_node(ast_node)
            results = []
            file_cache = file_caches.read(ast_node.filename)

            node_lines = if ast_node.is_a?(HamlParser::Ast::Text)
                           ast_node.text.split("\n")
                         elsif ast_node.is_a?(HamlParser::Ast::Script)
                           ast_node.script.split("\n")
            end

            node_lines.each_with_index do |node_line, i|
              offset_at = 0
              translate_scripts = node_line.scan(/t\(('[^']+'|"[^"]+")\)/).map(&:first)
              map_results = translate_scripts.map do |script|
                line = ast_node.lineno + i
                text_key = script.gsub!(/'|"/, '')
                column = file_cache[line].start_of(text_key, offset_at)
                offset_at = column + 1
                [
                  text_key,
                  line,
                  column,
                ]
              end
              results.concat(map_results)
            end
            results
          end
      end
    end
  end
end
