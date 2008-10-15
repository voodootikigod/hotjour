require 'jour'

class GitJour
  include Jour

  service_name 'git'
  
  def setup
    @text = @service.name
  end

end
