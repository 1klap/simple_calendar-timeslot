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

All options are optional, below you see all possible values commented out with their default value behind the colon and a short description afterwards.

Your model must implement a `start_time` and `end_time` function that returns a datetime, or you can specify alternatives as options to the call below
as `attribute: :my_start_time` and `end_attribute: :my_end_time` (without the `#` of course).

```erb
<%= timeslot_calendar(events: @events,
                      # number_of_days: 4, 
                      # layout: :vertical, # possible values: :vertical, :horizontal, :horizontal_date_on_top
                      # px_per_minute: 0.65, # define size of one minute
                      # display_grid: true, 
                      # grid_width: "20px", # can be any valid css size px, %, em
                      # display_current_time_indicator: false, # draw a line to show the current time, stylable class: tscal-current-time-indicator
                      # body_size_px: false, # only vertical layout: set integer if your want to limit the height
                      # day_height_px: 200, # only horizontal and horizontal_date_on_top layout: set height for a day
                      # bucket_by: false, # give model function as symbol if you want to bucket events by this function (f.ex. :event_type)
                      # display_bucket_title: false,
                      # date_format_string: false,
                      # date_heading_format_string: "%B %Y",
                      # attribute: :my_start_time, # provide alternative to :start_time model function 
                      # end_attribute: :my_end_time, # provide alternative to :end_time model function 
                     ) do |event| %>
  <div class="timeslot-event">
    <%= event.title %>
  </div>
<% end %>
```

## Customization

Style away as much as you want. This gem is mainly concerned to move the right pieces to the right place, how they look is up to you. Have a look
at the generated HTML or start with these classes
- `.tscal-event-wrapper`
- `.tscal-current-time-indicator`
- `.tscal-hour-cell`

Some words of caution: overflow is hidden for the scrolling part of the calendar, that is a div with class `.buckets-wrapper`. If you see your box-shadows clipped, that is probably causing it. You can of course overwrite clipping (with `.timeslot-calendar .buckets-wrapper { overflow: visible; }`), but then I recommend setting `overflow: hidden;` on `.tscal-event-wrapper`, otherwise you risk to see scrolling where you don't want to, when to content of the event is overflowing.

Here is an example with some basic styling

![Styled calendar](https://raw.githubusercontent.com/1klap/simple_calendar-timeslot/c844c11f99c51f1b44bab825943615c295acde29/img/simple_calendar-timeslot_styled.png)

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

I could use some help with the test suite.
Bug reports and pull requests are welcome on GitHub at https://github.com/1klap/simple_calendar-timeslot.
