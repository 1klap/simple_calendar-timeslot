## [Unreleased]

## [0.90.0] - 2021-11-17
### Changed
- **Mayor changes** to complete html layout
- **Option arguments changed**:
    - `orientation` has been removed for `layout`
    - `split_by_type` has been renamed to `bucket_by`
    - `horizontal_height_px` has been renamed to `day_height_px`
### Added
- New Layout `horizontal_date_on_top`
- New option `body_size_px` that limits the calendar body height if set and makes it scrollable.
- New option `date_format_string`, that applies the format string before displaying the date above each day
- New option `date_header_format_string`, that applies the format string before displaying the `start_date` url parameter in the heading of the calendar (between previos and next links)


## [0.8.0] - 2021-11-15
### Changed
- Shuffle html layout around a bit for easier css styling like sticky

## [0.7.0] - 2021-11-15
### Added
- new option to display a current time indicator line (based on Time.zone.now), that is invisible unless styled, the css-class is
`current_time_indicator`
### Fixed
- minor z-index inconsistencies for event rendering

## [0.6.0] - 2021-11-15
### Added
- Added option horizontal_scroll_split to view helper, which defaults to false. This option affects
horizontal orientation only. If set to false, the
different days of the calendar scroll together horizontally, which is more consistent with the
behaviour of the vertical layout. If set to true, the days scroll independently.

## [0.5.1] - 2021-11-15
### Fixed
- Fixed reliance of calendar on legacy function to
calculate event height

## [0.5.0] - 2021-11-14
- Removed images for the README from the gem, sry :(

## [0.4.0] - 2021-11-14
### Added
- Added compatibilty with the attribute and end_attribute options in the view helper
- Added documentation to README

## [0.3.0] - 2021-11-14
### Fixed
- Fix issue with css styles when including style of this gem and simple_calendar

## [0.2.0] - 2021-11-14
### Fixed
- Fix css styles to be tailwind agnostic

## [0.1.0] - 2021-11-12

- Initial release
