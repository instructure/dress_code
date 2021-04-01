require_relative 'spec_helper'

describe DressCode::Extractor do
  let(:file) { Tempfile.new }
  after(:each) { file.unlink }

  it "extracts documentation from files" do
    file.write <<~EOF
      /* @styleguide button

      ```html
      <button>I am a button</button>
      ```

      */

      button { background: OldLace; }

      /* @styleguide anchor

      ```html
      <a>I am an anchor</a>
      ```

      */

      a { background: BurlyWood; }
    EOF

    file.close

    extractor = DressCode::Extractor.new({
      :files => [file.path],
      :base_dir => 'tmp'
    })

    docs = extractor.extract
    docs.length.should == 2
    docs[0].component.should == 'anchor'
    docs[0].prose.should == "```html\n<a>I am an anchor</a>\n```"
    docs[0].path.should == file.path
    docs[1].component.should == 'button'
    docs[1].prose.should == "```html\n<button>I am a button</button>\n```"
    docs[1].path.should == file.path
  end

  it "doesn't choke on utf8 content" do
    file.write <<~EOF
      button {
        content: '▲';
      }
    EOF

    file.close

    extractor = DressCode::Extractor.new({
      :files => [file.path],
      :base_dir => 'tmp'
    })

    extractor.extract
  end
end

