require "spec_helper"
require "action_controller"
require "simple_calendar/timeslot"
require "support/view_context"

describe SimpleCalendar::Timeslot::TimeslotCalendar do
  describe "#todo" do
    it "can be instantiated" do
      today = Date.today
      calendar = SimpleCalendar::Timeslot::TimeslotCalendar.new(ViewContext.new, start_date: Date.today)
      expect(calendar).not_to eq(nil)
    end
  end
end
