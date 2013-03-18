Dress Code
==========

You haven't shown up to the office in your underwear, neither should your UI.

## About

Dress Code extracts certain comment blocks from your stylesheets and creates a styleguide with them.

Its really flexible, you can:

- Include your own CSS
- Include your own JS
- Render the styleguide with your own template

## Installation

`gem install dress_code`

Dress code requires the python library "pygments" for syntax highlighting.

`sudo easy_install pygments`

## Usage

Dress Code is generally used as a command line tool that takes a yaml config file. It will search your files and extract documentation that matches a regular expresssion.

Usage:

    dress_code [config_path]

Example:

    dress_code config/styleguide.yml

Example config yaml file:

```yaml
# required - the file to generate
out_file: styleguide/index.html

# required - the files to extract docs from
glob: stylesheets/**/*.css

# optional - components can display where they are defined, this will be
# stripped from that definition
base_dir: stylesheets

# optional - mustache template rendered for the `out_file`
template: styleguide/index.mustache

# optional - CSS files to load in the template
css:
  - public/stylesheets/framework.css
  - public/stylesheets/app.css

# optional - Inline DressCode CSS styles, defaults to true
dress_code_css: false

# optional - JavaScript files to load in the template
js:
  - public/js/behaviors.js

# optional - Inline DressCode JS, defaults to true
dress_code_js: false
```

## Documentation Syntax

Comments like the following will be extracted from your stylesheets:

    /*
    @styleguide Buttons

    Buttons are amazing.

    ```html
    <button class="btn">Button</button>
    ```
    */

The content of your comment block is parsed as markdown with github-style code fences. HTML code fences will be syntax highlighted and rendered (YES RENDERED!) in your styleguide.

Feel free to extend `DressCode::Extractor` to match your own style of comments.

## API

You can require any of the classes in lib to extend Dress Code for your particular needs. Check out `bin/dress_code` to see how to use them.

