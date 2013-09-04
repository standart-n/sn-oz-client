

module.exports = (size) ->

	convert = (b) ->
	
		gb = 1 << 30
		mb = 1 << 20
		kb = 1 << 10
		
		if (b >= gb) then return (Math.round(b / gb * 100) / 100) + 'gb'
		if (b >= mb) then return (Math.round(b / mb * 100) / 100) + 'mb'
		if (b >= kb) then return (Math.round(b / kb * 100) / 100) + 'kb'
		
		b + 'b'

	if (typeof size is 'number') then return convert(size)

	parts = size.match(/^(\d+(?:\.\d+)?) *(kb|mb|gb)$/)
	n = parseFloat(parts[1])
	type = parts[2]

	map =
			kb: 1 << 10
			mb: 1 << 20
			gb: 1 << 30

	map[type] * n


