require_relative '../dress_code'
require_relative 'renderer'

class DressCode::Document

  MD = Redcarpet::Markdown.new(DressCode::Renderer.new, {
    fenced_code_blocks: true,
    strikethrough: true,
    superscript: true
  })

  attr_accessor :path, :relative_path, :prose, :component

  def initialize(attributes)
    @attributes = attributes
    @path = @attributes[:path]
    @relative_path = @attributes[:relative_path]
    @prose = @attributes[:prose]
    @component = @attributes[:component]
  end

  def to_html
    MD.render(@prose)
  end

end

