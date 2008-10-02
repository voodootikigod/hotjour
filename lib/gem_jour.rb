require 'jour'

class GemJour
  include Jour
  
  service_name 'gem'
  
  def setup
    @text = @service.name
  end

  # def resolved!
    # system "gem list -r --source=http://#{host.host}:#{host.port}"
  # end
end
