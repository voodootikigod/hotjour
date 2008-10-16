require 'bonjour_watcher'
require 'hotcocoa'

# Replace the following code with your own hotcocoa code

class Application
  include HotCocoa
  
  def start
	@bonjour_watcher = BonjourWatcher.new.browse{|service_listing| @table.data=service_listing }
    application :name => "HotJour" do |app|
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "HotJour" do |win|
        @table = table_view(
          :columns => [ 
          column(:id => :service, :text => "Service"),
          column(:id => :name, :text => "Name"),
          column(:id => :host, :text => "Host") 
          ]  )  
        # put the table inside a scroll view 
		win << button(:title => "Refresh", :bezel => :regular_square).on_action { 
			@bonjour_watcher.refresh_listing
		}
		win << scroll_view(:layout => {:expand => [:width, :height]}) do |scroll| 
          scroll << @table 
        end

        win.will_close { exit }
      end
    end
  end
  
  # file/open
  def on_open(menu)
  end
  
  # file/new 
  def on_new(menu)
  end
  
  # help menu item
  def on_help(menu)
  end
  
  # This is commented out, so the minimize menu item is disabled
  #def on_minimize(menu)
  #end
  
  # window/zoom
  def on_zoom(menu)
  end
  
  # window/bring_all_to_front
  def on_bring_all_to_front(menu)
  end
end


NSApplication.sharedApplication
Application.new.start
NSApp.run