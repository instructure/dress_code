require_relative 'spec_helper'

describe DressCode::Generator do

  before :each do
    doc = DressCode::Document.new({
      :component => 'button',
      :prose => "```html\n<button>I am a button</button>\n```",
      :path => '/whever/button.css',
      :relative_path => 'button.css'
    })
    @docs = [doc]
  end

  it "generates the styleguide html file" do
    generator = DressCode::Generator.new({
      :out_file => 'tmp/styleguide.html',
      :docs => @docs
    })
    generator.generate()
    File.exists?('tmp/styleguide.html').should == true
    # nokogiri this crap up
  end

  it "includes css files"
  it "includes js files"

end

