(
{PanAz.ar(2,SinOsc.ar((6*3.pow(4)*1),mul:1/6),pos:LFSaw.ar(1/6),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(4)*(4/3)),mul:1/8),pos:LFSaw.ar(1/8),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(4)*(3/2)),mul:1/9),pos:LFSaw.ar(1/9),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(4)*(2/1)),mul:1/12),pos:LFSaw.ar(1/12),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(3)*1),mul:1/6),pos:LFSaw.ar(1/6),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(3)*(4/3)),mul:1/8),pos:LFSaw.ar(1/8),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(3)*(3/2)),mul:1/9),pos:LFSaw.ar(1/9),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(3)*(2/1)),mul:1/12),pos:LFSaw.ar(1/12),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(2)*1),mul:1/6),pos:LFSaw.ar(1/6),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(2)*(4/3)),mul:1/8),pos:LFSaw.ar(1/8),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(2)*(3/2)),mul:1/9),pos:LFSaw.ar(1/9),width:1)}.play;
{PanAz.ar(2,SinOsc.ar((6*3.pow(2)*(2/1)),mul:1/12),pos:LFSaw.ar(1/12),width:1)}.play;

)

s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=14;
TempoClock.default.tempo_(120/80);
s.options.memSize = 8192*8;
s.options.sampleRate = 44100;
s.options.numBuffers = 1024*1;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.record(numChannels:6) ;

(
{
	var x=0,y=1,sig,audio=0,an=0,pan=an.wrap(0,360);
43.do{
		sig=	Pan2.ar(BPF.ar(BrownNoise.ar(mul:(1/y).wrap(1,2)),freq:8*y,rq:0.002),pos:pan.wrap(-1,1));

			 an=an+137.5;
		pan=an.wrap(0,360);

	x=x+1;
	y=6*x;
		y.postln;
		audio=audio+sig;
};
Out.ar(0,audio);
}.play;
)

(
{PanAz.ar(2,SinOsc.ar(16*66,mul:1/66),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*60,mul:1/60),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*54,mul:1/54),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*48,mul:1/48),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*54,mul:1/42),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*36,mul:1/36),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*30,mul:1/30),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*24,mul:1/24),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*18,mul:1/18),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*12,mul:1/12),pos:0,width:2)}.play;
{PanAz.ar(2,SinOsc.ar(16*6,mul:1/6),pos:0,width:2)}.play;


)



(
	var x=0,y=1;
171.do{


	x=x+1;
	y=6*x;
		y.postln;
};
)
