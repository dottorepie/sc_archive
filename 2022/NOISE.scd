
s.options.numOutputBusChannels=20;

(
{
	var an=0 ,pang = an.wrap(0, 360);
	var x=0, over=1;

	10.do{
		Out.ar(0,PanAz.ar(10,BPF.ar(BrownNoise.ar(10/over),440*over,0.001),pos:LFSaw.ar(440),width:1,orientation:pang.linlin(0,360,0,10).postln));

		x = x+1;
		over = (x+1)/1;

an = an+137.5;
		pang = an.wrap(0, 360);
	}
}.play
)


(
{
	var an=0 ,pang = an.wrap(0, 360);
	var x=0, over=1,under=1;

	20.do{
		Out.ar(0,PanAz.ar(20,BrownNoise.ar(1/over),pos:LFSaw.ar(20*over),width:1,orientation:pang.linlin(0,360,0,20).postln));

		x = x+1;
		over = (x+1)/1;
			under = 1/(x+1);

an = an+137.5;
		pang = an.wrap(0, 360);
	}
}.play
)

(
{
	var an=0 ,pang = an.wrap(0, 360);
	var x=0, over=1,under=1;

	20.do{
		Out.ar(0,PanAz.ar(20,SinOsc.ar(100,mul:1),pos:LFSaw.ar(100),width:1,orientation:pang.linlin(0,360,0,20).postln));

		x = x+1;
		over = (x+1)/1;
			under = 1/(x+1);

an = an+137.5;
		pang = an.wrap(0, 360);
	}
}.play
)