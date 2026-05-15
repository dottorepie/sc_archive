MIDIClient.init;
MIDIIn.connectAll;

/////

// MIDIdef.cc(\dataentry,{|val,chan,src|[val,chan,src].postln; ~a.set(\cutt,val.linlin(1,127,110,880))},7);
// ~a=Synth.new(\oa);
// ~a.set(\cutt,220)

MIDIdef.noteOn(\synhtone, { |val, num, chan, src|
	[val, num, chan, src].postln;
	if(num < 49) {
		num = num - 1
	};
	Synth(\oa, [n1: num - 48, out: [(0..1).rotate(2.rand)], x:0.9999.rand,y:0.9999.rand,z:0.9999.rand,rx:0.9999.rand,ry:0.9999.rand,rz:0.9999.rand,decay:5.9999.rand]);

}, noteNum: (36..96))



/*d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7], 1), inf).clump(8).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));*/