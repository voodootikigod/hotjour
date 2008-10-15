require 'jour'

class PasteJour
  include Jour
  service_name 'paste'
  nib_name 'PasteJour'

  attr_accessor :pasted

  def setup
    (from, to) = *@service.name.split('-')

    @text = "from #{from}"
    @text << " to #{to}" if to
  end

  def paste(sender)
    # self.pasted = ` '#{@service.name}'`
    system("/usr/bin/env pastejour | pbcopy")
  end
end

