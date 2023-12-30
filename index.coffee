#
# Fuzzy Time  widget for Übersicht
# Geoff Oliver
# github.com/plan8studios/fuzzytime
#

#
# Adjust the styles as you like
#
style =
	# Define the maximum width of the widget.
	width: "5.75em"

	# Define the position, where to display the time.
	# Set properties you don't need to "auto"
	position:
		top:    "1vw"
		left:   "1vw"

	# Font properties
	font:            "'Avenir Next', sans-serif"
	font_color:      "rgba(252, 252, 252, 0.7)"
	font_size:       "4rem"
	font_weight:     "100"
	letter_spacing:  "0.025em"
	line_height:     "0.9"
	opacity:		"1"

	# Misc
	text_align:     "left"
	text_transform: "uppercase"

# Get the current hour as word.
command: "echo hello"

# Lower the frequency for more accuracy.
refreshFrequency: (1000 * 3) # (1000 * n) seconds

render: (o) -> """
	<div id="content">
		<span id="time"></span>
	</div>
"""


update: (output, dom) ->
	hours = [null, "one", "two", "three", "four", "five", "six", "seven",
		"eight", "nine", "ten", "eleven", "twelve"]
	times = ["%h o'clock", "five after %h", "ten after %h", "quarter past %h",
		"twenty after %h", "twenty five after %h", "half past %h", "twenty five to %H",
		"twenty to %H", "quarter to %H", "ten to %H", "five to %H"]
	fuzzies = [
		{ minute: 55, index: 11 }
		{ minute: 50, index: 10 },
		{ minute: 45, index: 9 },
		{ minute: 40, index: 8 },
		{ minute: 35, index: 7 },
		{ minute: 30, index: 6 },
		{ minute: 25, index: 5 },
		{ minute: 20, index: 4 },
		{ minute: 15, index: 3 },
		{ minute: 10, index: 2 },
		{ minute: 5,  index: 1 },
		{ minute: 0,  index: 0 },
	]
	date   = new Date()
	minute = date.getMinutes()
	hour   = date.getHours()
	hour   = hour % 12
	hour   = 12 if hour == 0
	nextHour = hour + 1
	if nextHour > 12
		nextHour = 1

	hour_str = hours[hour]
	next_hour_str = hours[nextHour]
	time_str = hour_str
	for i in fuzzies
		if i.minute <= minute
			time_str = times[i.index].replace(/%h/g, hour_str).replace(/%H/g, next_hour_str)
			break

	$(dom).find("#time").html(time_str)


style: """
	top: #{style.position.top}
	left: #{style.position.left}
	width: #{style.width}
	font-family: #{style.font}
	color: #{style.font_color}
	opacity: #{style.opacity}
	font-weight: #{style.font_weight}
	text-align: #{style.text_align}
	text-transform: #{style.text_transform}
	font-size: #{style.font_size}
	letter-spacing: #{style.letter_spacing}
	-webkit-font-smoothing: antialiased
	line-height: #{style.line_height}
"""
