require_relative 'spec_helper'

describe DressCode::Renderer do

  before :each do
    @md = Redcarpet::Markdown.new(DressCode::Renderer.new, {
      fenced_code_blocks: true
    })
    @prose = "Hello\n\n```html\n<p>foo</p>\n```"
  end

  it "both renders and displays html code blocks" do
    html = @md.render(@prose)
    html.should == "<p>Hello</p>\n<div class='code-demo'><div class=\"highlight\"><pre><span class=\"nt\">&lt;p&gt;</span>foo<span class=\"nt\">&lt;/p&gt;</span>\n</pre></div> <div class='code-rendered'><p>foo</p>\n</div></div>"
  end

end

