require 'hotcocoa'

# Replace the following code with your own hotcocoa code

class Application

  include HotCocoa
  
  def start
    application :name => "HotJour" do |app|
      app.delegate = self
      window :frame => [100, 100, 500, 500], :title => "HotJour" do |win|
        @table = table_view(
          :columns => [ 
          column(:id => :klass, :text => "Service"),
          column(:id => :ancestors, :text => "Host") 
          ]  )  
        # put the table inside a scroll view 
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

Application.new.start