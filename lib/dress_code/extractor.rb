require_relative '../dress_code'
require_relative 'document'

class DressCode::Extractor

  attr_accessor :files

  def initialize(opts)
    @files = opts[:files]
    @base_dir = opts[:base_dir]
    @matcher = %r{/*\s+@styleguide\s+([^\n]+)(.+?)\*/}m
  end

  def extract
    parse_files.sort_by { |doc| doc.component }
  end
  alias_method :docs, :extract

  def parse_files
    @files.flat_map { |path| parse_file(path) }.compact
  end

  def parse_file(path)
    src = File.read(path)
    matches = scan(src)
    return unless matches.length
    matches.map { |match| create_doc(match, path) }
  end

  def scan(src)
    src.scan(@matcher)
  end

  # must return an instance of Doc
  def create_doc(match, path)
    DressCode::Document.new({
      :component => match[0],
      :prose => match[1].strip,
      :path => path,
      :relative_path => path.gsub(@base_dir, '').gsub(/^\//, '')
    })
  end

end

