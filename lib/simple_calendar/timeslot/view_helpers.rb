module SimpleCalendar
  module Timeslot
    module ViewHelpers
      def timeslot_calendar(options = {}, &block)
        raise "calendar requires a block" unless block
        TimeslotCalendar.new(self, options).render(&block)
      end
    end
  end
end