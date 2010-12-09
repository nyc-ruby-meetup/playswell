require 'hotcocoa'

class Application
  include HotCocoa

  def start
    application(:name => "Postie") do |app|
      app.delegate = self
      window(:frame => [100, 100, 500, 500], :title => "Postie") do |win|
        win << label(:text => "Hello from HotCocoa", :layout => {:start => false})
        win.will_close { exit }
      end
    end
  end
end

Application.new.start