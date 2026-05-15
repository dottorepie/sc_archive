~a={Out.ar(0,PanAz.ar(4,BLowPass.ar(WhiteNoise.ar(mul:1),880),LFSaw.ar(1/8),width:3))}.play
~a.free


a= Buffer.read(s,path:);
b= Buffer.read(s,path:);
c= Buffer.read(s,path:);
d= Buffer.read(s,path:);



(
(
SynthDef(\a,{
var sig;

	sig=PlayBuf.ar(1,0,BufRateScale.kr(0),loop:inf);
	Out.ar(0,sig);
}).add;
);
(
SynthDef(\b,{
var sig;
	sig=PlayBuf.ar(1,1,BufRateScale.kr(1),loop:inf);
	Out.ar(1,sig);
}).add;
);
(
SynthDef(\c,{
var sig;

	sig=PlayBuf.ar(1,2,BufRateScale.kr(2),loop:inf);
	Out.ar(2,sig);
}).add;
);
(
SynthDef(\d,{
var sig;

	sig=PlayBuf.ar(1,3,BufRateScale.kr(3),loop:inf);
	Out.ar(3,sig);
}).add;
);
)

(
Synth.new(\a);
Synth.new(\b);
Synth.new(\c);
Synth.new(\d);
)
