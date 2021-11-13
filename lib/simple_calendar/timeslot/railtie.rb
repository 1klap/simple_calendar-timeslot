module SimpleCalendar
  module Timeslot
    class Engine < Rails::Engine
      initializer "simple_calendar-timeslot.view_helpers" do
        ActiveSupport.on_load(:action_view) do
          include ViewHelpers
        end
      end
    end
  end
end
