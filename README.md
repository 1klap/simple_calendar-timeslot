# SimpleCalendar::Timeslot

This gem is an extension of the rubygem `simple_calendar` by Chris Oliver aka excid3. It allows 
for simple calendar creation in a Ruby on Rails app with an timeslot representation of events 
in a 24h day. 

This helps to visually grasps the length of events and the time between them. In case of overlapping, the respective events are shown side-by-side. It is also possible to categorise events in buckets according to some function, then they will be shown next to one another in the 24h timeline.

Different layouts are selectable via options, just like many other ones.

All layouts support the following options:
- event rendering can be completely controlled, the calendar provides a wrapping div around with the correct dimensions at the right place
- responsive design which can (and should) be styled to your liking
- turn hour grid on/off
- set the width of the grid in `px` or `%`
- adjust the pixel-size corresponding to one minute
- limit the overall size of day, making part of it scroll
- for horizontal layouts: determine the breadth of one day
- "bucketing" of events by same value, any event function can be provided (see colums "Me" and "Mom" in image below and symbol `:event_type_name` in code)
- displaying of bucket label by provided function on event
- formating of date above day
- formating of date in heading
- turn current time indicator on/off, this is an invisible css-stylable div with class `tscal-current-time-indicator` (can be seen in examples below)
- by default, the 24h-grid hides any overflow which is recommended not to overwrite, otherwise there might be 2-directional scrolling

**Note:** events are styled in the examples with the following minimalistic styles to show their outline. This is not the case when the gem is used out of the box, because it would make the style hard to overwrite because of css-predence rules.
```css
.event-wrapper {
  border: solid 1px black;
}
```

### Vertical layout
This layout grows vertically, and can be limited in height by option `body_size_px` and will then scroll.
The horizontal direction is responsive.
![Vertical Layout](https://raw.githubusercontent.com/1klap/simple_calendar-timeslot/90a0c2b72b172a113105412ef34dd00f728e50e4/img/simple_calendar-timeslot_vertical-v2.png)

Code
```erb
<%= timeslot_calendar(events: @events,
                      layout: :vertical,
                      number_of_days: 2,
                      px_per_minute: 1.3,
                      #display_grid: true,
                      grid_width: "30px",
                      body_size_px: 600,
                      bucket_by: :event_type,
                      date_format_string: "%d.%m.%Y",
                      #date_heading_format_string: "%d.%m.%Y",
                      display_bucket_title: :event_type_name,
                      display_current_time_indicator: true
      ) do |event| %>
  <div class="timeslot-event">
    <%= event.title %>
  </div>
<% end %>
```

### Horizontal layout
This layout is basicall the vertical one toppled over. The days grows horizontally, if it has not enough space (which is likely this direction) the day will scroll with the day and bucket headings staying fixed. Multiple days scroll together. The height per day can be adjusted as option, the events scale responsively.

One advantage over vertical layout is that the horizontal scrolling works better for mobile devices, combined with vertical scroll to scroll further down. 
![Horizontal Layout](https://raw.githubusercontent.com/1klap/simple_calendar-timeslot/90a0c2b72b172a113105412ef34dd00f728e50e4/img/simple_calendar-timeslot_horizontal-v2.png)

Code:
```erb
<%= timeslot_calendar(events: @events,
                      layout: :horizontal,
                      day_height_px: 100,
                      #...
      ) do |event| %>
    <div class="timeslot-event">
      <%= event.title %>
    </div>
  <% end %>
```

### Horizontal - Date on top
My personal favorite: like horizontal layout, but the date is moved above the scrolling day, freeing up space. Forcibly, the scroll between days is separated (this could be restored with a javascript scroll-lock).
![Horizontal Layout](https://raw.githubusercontent.com/1klap/simple_calendar-timeslot/90a0c2b72b172a113105412ef34dd00f728e50e4/img/simple_calendar-timeslot_horizontal2-v2.png)

Code:
```erb
<%= timeslot_calendar(events: @events,
                      layout: :horizontal_date_on_top,
                      #...
      ) do |event| %>
    <div class="timeslot-event">
      <%= event.title %>
    </div>
  <% end %>
```



## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_calendar-timeslot'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install simple_calendar-timeslot


**Important** Then include the stylesheet in your rails app.

If you have an `application.css` file, include the following (before `*= require_tree .` and `*= require_self` if you want to overwrite styles with equal specificity):
```ruby
*= require simple_calendar-timeslot
```
If you use an SCSS file (`application.scss`), add the following line instead:
```ruby
@import 'simple_calendar-timeslot';
```

## Usage

Include a code snipped like the one below anywhere in your `.html.erb` file, set `@events` in your calling controller to be a collection of your model object to be displayed. You can refer to the documentation on [simple_calendar/Rendering_Events](https://github.com/excid3/simple_calendar#rendering-events) (thats from the gem on which this one is built on top of), the complete paragraph applies to this gem as well.

Your model must implement a `start_time` and `end_time` function that returns a datetime,
or you can specify alternatives as options to the call below
as `attribute: :my_start_time` and `end_attribute: :my_end_time` (without the `#` of course).

```erb
<%= timeslot_calendar(events: @events,
                      # number_of_days: 4, 
                      # layout: :vertical, # possible values: :vertical, :horizontal, :horizontal_date_on_top
                      # px_per_minute: 0.65, # define size of one minute
                      # display_grid: true, 
                      # grid_width: "20px", # can be any valid css size px, %, em
                      # display_current_time_indicator: false,
                      # body_size_px: false,
                      # day_height_px: 200,
                      # bucket_by: false,
                      # display_bucket_title: false,
                      # date_format_string: false,
                      # date_heading_format_string: "%B %Y",
                      # attribute: :my_start_time,
                      # end_attribute: :my_end_time,
                     ) do |event| %>
  <div class="timeslot-event">
    <%= event.title %>
  </div>
<% end %>
```
layout: :vertical
      bucket_by: false
      px_per_minute: 0.65
      display_bucket_title: false
      grid_width: "20px"
      display_grid: true
      display_current_time_indicator: false
      body_size_px: false
      day_height_px: 200
      date_format_string: false
      date_heading_format_string: "%B %Y"

Shortversion in the meantime:
- `orientation` (`:vertical`, `:horizontal`, default: :vertical)
- `px_per_minute` (defines size of calendar, default: 0.65)
- `horizontal_height_px` default: 300
- `horizontal_scroll_split` (scroll days separately or together, default: false)
- `split_by_type` (model function to call in case of bucketing f.ex.`:event_type`, default: false)
- `display_bucket_title` (model function to call in case of bucketing f.ex.`:event_type_name`, default: false)
- `bucket_title_size` default: 20
- `grid_width` default: 20px
- `display_grid` default: true
- `display_current_time_indicator` (display a stylable div across the timeline that display the current time, css-class: `current_time_indicator`, default: false)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/1klap/simple_calendar-timeslot.
