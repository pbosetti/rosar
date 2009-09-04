RosaR
=====

Ruby/OSA to Gnu-R interface, useful to plot and analyze data from within ruby.
It relies on AppleScript, so only works on Apple OS X (Snow Leopard tested).

If you have troubles with ruby-osa, install my rubyosa gem:

	sudo gem install pbosetti-rubyosa

Example
=======

	require '../lib/rosar'
 
	r = ROSAR.instance
 
	df = {
	  :x => (0..4).to_a,
	  :y => [7,2,5.5,8,9,10]
	}
	cols = %w(red green blue darkred darkgreen darkblue)
	r.transfer :p=>(0...100).to_a
	r.plot :x=>:p, :y=>"p^2", :typ=>"'l'"
	2.upto 7 do |i|
	  r.lines :x=>:p, :y=>"#{i}*p^2", :col=>"'#{cols[i-2]}'"
	end
	sleep(2)
	r.data_frame :df, df
	r.attach :df
	r.plot :x=>:x, :y=>"y/2", :typ=>"'b'", :col=>"'darkred'", :xlab=>"'Time (s)'"
	r.grid
	r.abline :h=>[2.5,3.5]
	r.abline "a=0, b=1"
	r.detach :df