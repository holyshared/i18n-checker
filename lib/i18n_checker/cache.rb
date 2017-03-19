require 'forwardable'

module I18nChecker
  module Cache
    class Files
      extend Forwardable

      include Enumerable

      attr_reader :files

      def_delegators :files, :size, :each

      def initialize(files = {})
        @files = files
      end

      def read(file)
        return files[file] if files.key?(file)
        files[file] = I18nChecker::Cache::File.of(file)
        files[file]
      end
    end

    class File
      attr_reader :file, :lines

      class << self
        def of(file)
          new(file, Lines.of(::File.read(file)))
        end
      end

      def initialize(file, lines)
        @file = file
        @lines = lines
      end

      def [](scope)
        lines[scope]
      end

      def to_s
        lines.to_s
      end
    end

    class Lines
      extend Forwardable

      include Enumerable

      attr_reader :lines

      def_delegators :lines, :size, :each

      class << self
        def of(source)
          lines = {}
          source.split("\n").each_with_index do |content, i|
            line_number = i + 1
            lines[line_number] = Line.new(line_number, content)
          end
          last_key = lines.keys.last
          lines.delete last_key if lines[last_key] == ''
          new(lines)
        end
      end

      def initialize(lines = {})
        @lines = lines
      end

      def [](scope)
        return lines_of(scope) if scope.is_a?(Range)
        return line_of(scope) if scope.is_a?(Integer)
      end

      def line_of(line_number)
        lines[line_number]
      end

      def lines_of(range)
        results = {}
        raise StandardError, "invalid line number #{range.first}" if range.first <= 0
        raise StandardError, "invalid line number #{range.last}" if lines.size < range.last
        range.each do |i|
          results[i] = lines[i]
        end
        self.class.new(results)
      end

      def to_s
        lines.values.join("\n")
      end
    end

    class Line
      attr_reader :line, :content

      def initialize(line_number, content)
        @line = line_number
        @content = content
      end

      def [](range)
        columns_of(range)
      end

      def columns_of(range)
        content[range.first - 1, range.last]
      end

      def start_of(text)
        content.index(text)
      end

      def to_s
        content
      end
    end
  end
end
