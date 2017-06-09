class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :mobile_device?

  def mobile_device?
    result  = request.env['HTTP_USER_AGENT']
    puts result
      if result =~ /iPhone|Android|iPad/
        @browser = "Mobile"
        @mobile = true
      else
      case 
      when result =~ /Chrome/
        @browser = "Google Chrome"
        @mobile = false
      when result =~ /Firefox/
        @browser = "Firefox"
        @mobile = false
      when result =~ /Safari/
        @browser = "Safari"
        @mobile = false
      when result =~ /MSIE/
        @browser = "Internet Explorer"
        @mobile = false        
      end 
      end
    puts "********************** #{@browser} / Mobile: #{@mobile} ************************" 
       @mobile
  end
end
