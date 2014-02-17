require 'nokogiri'

module CoverPagesHelper
  # from http://www.emoticode.net/rails/html_truncate-a-rails-helper-to-correctly-truncate-html-strings.html
  def html_truncate(input, num_words = 15, truncate_string = "...")
    doc = Nokogiri::HTML(input)
    
    current = doc.children.first
    count = 0
    
    while true
      if current.is_a?(Nokogiri::XML::Text)
        count += current.text.split.length
        break if count > num_words
        previous = current
      end
      
      if current.children.length > 0
        current = current.children.first
      elsif !current.next.nil?
        current = current.next
      else 
        n = current
        while !n.is_a?(Nokogiri::HTML::Document) and n.parent.next.nil?
          n = n.parent
        end

        if n.is_a?(Nokogiri::HTML::Document)
          break;
        else
          current = n.parent.next
        end
      end
    end
    
    if count >= num_words
      unless count == num_words
        new_content = current.text.split
        index = num_words-(count-new_content.length)-1
        if index >= 0
          new_content = new_content[0..index]
          current.content = new_content.join(' ') + truncate_string
        else
          current = previous
          current.content = current.content + truncate_string
        end
      end
      
      while !current.is_a?(Nokogiri::HTML::Document)
        while !current.next.nil?
          current.next.remove
        end
        current = current.parent
      end
    end
    
    doc.root.children.first.inner_html
  end
end
