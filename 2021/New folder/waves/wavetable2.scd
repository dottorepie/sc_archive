s.options.device_("ASIO : ASIO4ALL v2");

o=s.options

o.memSize;

o.memSize = 2.pow(16);

s.options.numOutputBusChannels= 2;

s.record(numChannels:2);
/////////////////////////////

///////////////////////////////////////////////////shaper
//with shaper you need to use +1 in the buffer length and NoWrap in wavetable placement
b = Buffer.alloc(s,2048);
(
~tf =  Env([0,-1,0,1,0],[1,1,1,1],[-2,2,-2,2]).asSignal(1024+1);
~tf = ~tf.asWavetableNoWrap;
)
~tf.plot;
~tf.size;
~tfBuf = Buffer.loadCollection(s,~tf);b.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(400))*0.2!2}.play
///////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////
(
~tf =  Env([0,-1,0,1,0],[1,1,1,1],[-2,2,-2,2]).asSignal(1025);
~tf = ~tf + (Signal.sineFill(1025,(0!3) ++ [0,0,0,1,1,1].scramble ,
	{rrand(0,2pi)}!9)/4;
);
~tf = ~tf.normalize;
~tf.plot;
~tfBuf = Buffer.loadCollection(s,~tf.asWavetableNoWrap);
)
~tfBuf.numFrames;
~tfBuf.plot;
(
{var sig,input;
	input = SinOsc.ar(120) * Line.kr(0.1,1,20);
	// randomize detune  freq*Rand(-0.1,0.1).midiratio}!8
	// randomize amp input 8 LFNoise.kr(0.5!8).range(0.1,1);
	sig = Shaper.ar(~tfBuf, input);
	sig = sig*0.3!2;
}.play;
)
s.freeAll

//////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////


~tf = Env([0,-1,0,1,0],[1,1,1,1],[-2,2,-2,2])//.asSignal(1024+1);

~tf.plot