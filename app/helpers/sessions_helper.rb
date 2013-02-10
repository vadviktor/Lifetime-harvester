module SessionsHelper
  def flash_this message
    flash = ''
    if message.respond_to? 'each'
      flash << '<ul>'
      message.each do |m|
        flash << "<li>#{m}</li>"
      end
      flash << '</ul>'
    else
      flash << message
    end
    flash
  end
end
