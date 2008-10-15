require 'jour'

class AppJour 
  include Jour
  
  service_name 'app'
  nib_name 'AppJour'
  
  attr_accessor :url
  
  def setup
    @text = @service.name
    @url = 'resolving'
  end
  
  def resolved!
    self.url = "http://#{@service.hostName}:#{@service.port}"
  end
  
  def open(sender)
    return unless self.url
    system "open '#{self.url}'"
  end
end
