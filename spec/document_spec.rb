require_relative 'spec_helper'

describe DressCode::Document do

  before :each do
    @attributes = {
      :path => '/foo/bar',
      :relative_path => 'bar',
      :prose => "Hello\n\n```html\nhello\n```",
      :component => 'foobar'
    }
    @doc = DressCode::Document.new(@attributes)
  end

  it "initalizes with options" do
    @doc.path.should == @attributes[:path]
    @doc.relative_path.should == @attributes[:relative_path]
    @doc.prose.should == @attributes[:prose]
    @doc.component.should == @attributes[:component]
  end

  it "renders html with the the DressCode renderer" do
    @doc.to_html.should == "<p>Hello</p>\n<div class='code-demo'><div class=\"highlight\"><pre>hello\n</pre></div> <div class='code-rendered'>hello\n</div></div>"
  end

end

