module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    html = ""
    messages = resource.errors.full_messages.each do |errmsg|
      html += <<-EOF
      <p><span class="glyphicon glyphicon-exclamation-sign" aria-hidden="true"></span> #{errmsg}</p>
      EOF
    end
    html.html_safe
  end

  def devise_error_messages?
    resource.errors.empty? ? false : true
  end

end