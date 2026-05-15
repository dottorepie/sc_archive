s.options.device_("ASIO : ASIO4ALL v2");

o=s.options

o.memSize;

o.memSize = 2.pow(16);

s.options.numOutputBusChannels=3
//////////////////////////////////////////////////////////////////////////////

(
~sig = Signal.sineFill(1024,[1],[0]);
~sig.plot("signal");
~wt = ~sig.asWavetable;
~wt.collect({arg n; n}).plot("wavetable");
)
~sig.size;
~wt.size;


////////////////////////////////////////////////////////////////////////////////////////////////////Buffer Allocation
b = Buffer.alloc(s,2048);
(
~sig = Signal.sineFill(1024,[1],[0]);
~wt = ~sig.asWavetable;
b.loadCollection(~wt);
)
~sig.plot
b.plot;
{Osc.ar(b,MouseX.kr(100,1000,1),mul:0.2!2)}.play;
//note freq stacks in same osc with array[]{Osc.ar(b,MouseX.kr(100,1000,1)*[1,2.01],mul:0.2!2)}.play;

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////using envelopes for wavetable synthesis
b = Buffer.alloc(s,2048);
(
var env, sig, wt;
env = Env([0,0.6,-0.9,0.3,0],[4,3,2,1],\lin);
sig = env.asSignal(length:1024);
wt = sig.asWavetable;
b.loadCollection(wt);
)
b.plot;
{Osc.ar(b,MouseX.kr(10,10000,1)*[1,2.01],mul:0.2!2)}.play;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////vosc
(
~wt0 = Signal.sineFill(1024,1/(1..8),0!8).asWavetable;
~wt1 = Signal.sineFill(1024,[1,0,1/2,1,1/4],[0,0,pi,0,pi]).asWavetable;
)

~wt0.plot; ~wt1.plot;
////fill buff
(
~b0 = Buffer.loadCollection(s,~wt0);
~b1 = Buffer.loadCollection(s,~wt1);
)
~b0.numFrames;
////synthdef with(from) buf 0 to 1 swip
(
SynthDef.new(\vosc, {
	arg out=0, buf=0, numBufs=2;
	var sig, bufpos;
	bufpos = buf + MouseX.kr(0,numBufs-1);
	sig = VOsc.ar(bufpos, 300, mul:0.2!2);
	Out.ar(out,sig);
}).add;
)
Synth(\vosc,[\buf, ~b0.bufnum, \numBufs, 2]);

/////////////////////////////////load more than two buffers in the swip
(
~wt = Array.fill(4, { var numSegs = rrand(4,20);
	Env([0]++(({rrand(0.0,1.0)}!(numSegs-1))*[1,-1]).scramble++[0],
		{exprand(1,20)}!numSegs,
		{rrand(-20,20)}!numSegs).asSignal(1024).asWavetable;});
)
~buf = Buffer.allocConsecutive(4,s,2048);

(
~buf.do({ arg buf, i; buf.loadCollection(~wt[i]);
});
)
~wt.do({arg n,i; n.plot(~buf[i].bufnum.asString)});

(
SynthDef.new(\vosc, {
	arg out=0, buf=0, numBufs=2, amp = 0.2;;
	var sig, bufpos, detuneSig;
	// multichanelexpansion with slight detune detuneSig = LFNoise1.kr(0.2!8).bipolar(0.2).midiratio;
	bufpos = buf + MouseX.kr(0,numBufs-1);
//rabdomize swip control bufpos = buf + LFNoise1.kr(0.5).range(0, numBufs-1);
	sig = VOsc.ar(bufpos, 300, mul:0.2!2);
//spread all sources across stero field sig = Splay.ar(sig)
//remove dc offset sig = LeakDc.ar(sig)*amp
	Out.ar(out,sig);
}).add;
	)
Synth(\vosc,[\buf, ~buf[0].bufnum, \numBufs, 4]);

////////////////////////////////////////////////////shaper
//with shaper you need to use +1 in the buffer length and NoWrap in wavetable placement
b = Buffer.alloc(s,2048);
(
~tf = Env([-1,0,1],[1,1],[64,-64]).asSignal(1024+1);
~tf = ~tf.asWavetableNoWrap;
)
~tf.plot;
~tf.size;
~tfBuf = Buffer.loadCollection(s,~tf);b.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(400))*0.2!2}.play
//////////
(
~tf = Env([-1,1],[1],[0]).asSignal(1025);
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