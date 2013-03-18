require_relative '../lib/dress_code'
require 'fileutils'

def create_test_file
  path = "tmp/test.css"
  directory = File.dirname(path)
  FileUtils.mkdir_p(directory) unless Dir.exists?(directory)
  test_file_content = "
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
"
  File.open(path, 'w') do |file|
    file.write(test_file_content)
  end
  path
end

