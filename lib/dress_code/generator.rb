require 'mustache'
require_relative '../dress_code'

class DressCode::Generator

  STATIC = "#{File.dirname(__FILE__)}/../static"
  TEMPLATE = "#{STATIC}/styleguide.html.mustache"

  def initialize(opts)
    @out_file = opts[:out_file] || 'styleguide.html'
    @docs = opts[:docs]
    @css = opts[:css]
    @js = opts[:js]
    @template = opts[:template] || TEMPLATE
    @inline_css = opts[:dress_code_css].nil? ? true : !!opts[:dress_code_css] 
    @inline_js = opts[:dress_code_js].nil? ? true : !!opts[:dress_code_js] 
  end

  def generate
    template = File.read(@template)
    write_file(@out_file, Mustache.render(template, {
      :docs => map_docs,
      :css => @css,
      :js => @js,
      :dress_code_css => dress_code_css,
      :dress_code_js => dress_code_js
    }))
  end

  def dress_code_css
    return unless @inline_css
    File.read("#{STATIC}/base.css") + File.read("#{STATIC}/github.css")
  end

  def dress_code_js
    return unless @inline_js
    File.read("#{STATIC}/docs.js")
  end

  def map_docs
    @docs.map { |doc| map_doc(doc) }
  end

  def map_doc(doc)
    {
      :id => "#{doc.component.gsub(' ', '_').downcase}",
      :prose => doc.to_html,
      :component => doc.component,
      :file => doc.relative_path
    }
  end

  def write_file(path, content)
    File.open(path, 'w') do |file|
      puts "# writing file: #{path}"
      file.write(content)
    end
  end

end

