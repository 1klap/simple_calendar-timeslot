require "simple_calendar"

module SimpleCalendar
  module Timeslot    
    class TimeslotCalendar < SimpleCalendar::Calendar
      MINUTE_HEIGHT_PX = 0.65
      FIRST_HOUR_SLOT = 0

      def orientation
        @options.fetch(:orientation, :vertical)
      end

      def horizontal_height_px
        @options.fetch(:horizontal_height_px, 300)
      end

      def split_by_type
        @options.fetch(:split_by_type, false)
      end

      def px_per_minute
        @options.fetch(:px_per_minute, TimeslotCalendar::MINUTE_HEIGHT_PX)
      end

      def display_bucket_title
        @options.fetch(:display_bucket_title, false)
      end

      def bucket_title_size
        if display_bucket_title
          @options.fetch(:bucket_title_size, 20)
        else
          0
        end
      end

      def grid_top_offset(hour)
        4.16666667 * hour
      end

      def grid_width
        if display_grid
          @options.fetch(:grid_width, "20px")
        else
          0
        end
      end

      def display_grid
        @options.fetch(:display_grid, true)
      end

      def horizontal_scroll_split
        @options.fetch(:horizontal_scroll_split, false)
      end

      def height
        #h = (24 - TimeslotCalendar::FIRST_HOUR_SLOT) * 60 * px_per_minute
        h = 24 * 60 * px_per_minute
        h = h+bucket_title_size if display_bucket_title
        h
      end

      def event_height(event, day)
        minutes = if event.send(attribute).to_date != day
                    (event.send(end_attribute) - event.send(end_attribute).midnight)/60
                  elsif event.send(attribute).to_date < event.send(end_attribute).to_date
                    (event.send(end_attribute).midnight - 60 - event.send(attribute))/60
                  else
                    (event.send(end_attribute) - event.send(attribute))/60
                  end
        minutes * px_per_minute 
      end

      def event_top_distance(event, day)
        return 0 if event.send(attribute).to_date != day
        #(event.send(attribute).hour - TimeslotCalendar::FIRST_HOUR_SLOT) * 60 * px_per_minute + event.send(attribute).min * px_per_minute
        event.send(attribute).hour * 60 * px_per_minute + event.send(attribute).min * px_per_minute
      end

      def split_into_buckets(events)
        if split_by_type
          events.group_by{|e| e.send split_by_type}.values
        else
          [events]
        end
      end

      def slot_events(events, day)
        r = {}
        events.each do |event|
          r[event] = [0, 0, event_height(event, day), event_top_distance(event, day)]
        end
        # Credit: https://stackoverflow.com/questions/11311410/visualization-of-calendar-events-algorithm-to-layout-events-with-maximum-width
        # Author: Markus Jarderot (https://stackoverflow.com/users/22364/markus-jarderot)
        columns = [[]]
        last_event_ending = nil
        events.each do |event|
          if !last_event_ending.nil? && event.send(attribute) > last_event_ending
            pack_events(r, columns)
            columns = [[]]
            last_event_ending = nil
          end
          placed = false
          columns.each do |col|
            unless events_collide(r, col.last, event)
              col << event
              placed = true
              break
            end
          end
          unless placed
            columns << [event]
          end
          event_end_time = event.send(end_attribute)
          if last_event_ending.nil? || event_end_time > last_event_ending
            last_event_ending = event_end_time
          end
        end
        if columns.size > 0
          pack_events(r, columns)
        end
        r
      end

      private

      def pack_events(r, columns)
        num_columns = columns.size.to_f
        columns.each_with_index do |col, iter_col|
          col.each do |event|
            col_span = expand_event(r, event, iter_col, columns)
            r[event][1] = (iter_col / num_columns)*100
            r[event][0] = ((iter_col + col_span)/ (num_columns  ))*100 - r[event][1]
          end
        end
      end

      def events_collide(r, event1, event2)
        return false if event1.nil? || event2.nil?
        event1_bottom = r[event1][3] + r[event1][2]
        event2_bottom = r[event2][3] + r[event2][2]
        event1_bottom > r[event2][3] && r[event1][3] < event2_bottom
      end

      def expand_event(r, event, iter_col, columns)
        col_span = 1
        columns.each_with_index do |column, index|
          if index > iter_col
            column.each do |event_iter|
              return col_span if events_collide(r, event, event_iter)
            end
            col_span = col_span+1
          end
        end
        col_span
      end
    end
  end
end