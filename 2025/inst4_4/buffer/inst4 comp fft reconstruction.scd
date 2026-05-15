(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=2;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*8;
s.waitForBoot;
)

~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Dokuments/EXTERNAL/music/Nisi Dominus - Cum Dederit de Antonio Vivaldi. Andreas Scholl.wav",channels:0 );

~dur=((~c1.numFrames/512)/44100)

{Out.ar(2,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2))}.play;

({
		var n=1.neg;
	~k=(512).collect{
		n=n+1;
		}
		}.value
	)


(
~b=Pxrand(~k,512,1).asStream;
512.do{
	|i|
(
		SynthDef.new(\obin_++i, {

    var b=1.neg;
    var in1,chain1,chain2,chain3,chain4;
	var sig1,sig2,sig3,sig4;
	var bank,frames=1024;
	var samplerate=44100;
	var env;

env=EnvGen.ar(Env([0,1,1,0],[0,duration,0]));
			in1 = InFeedback.ar(4);
			in2 = InFeedback.ar(5);
			in3 = InFeedback.ar(6);
			in4 = InFeedback.ar(7);


	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in1);
			b=~b.next.postln;

sig1 = chain1.pvcollect(frames, {|magnitude, phase, bin|
		[magnitude,phase]

}, frombin: b, tobin: b, zeroothers: 1);

sig2 = chain2.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phased]

}, frombin: b, tobin: b, zeroothers: 1);

sig3 = chain3.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phased]

}, frombin: b, tobin: b, zeroothers: 1);

sig4 = chain4.pvcollect(frames, {|magnitude, phase, bin|

		[magnitude,phased]

}, frombin: b, tobin: b, zeroothers: 1);

		Out.ar(0,IFFT(sig1)*env);
		Out.ar(1,IFFT(sig2)*env);
		Out.ar(2,IFFT(sig3)*env);
		Out.ar(3,IFFT(sig4)*env);
			chain1.clear;
			chain2.clear;
			chain3.clear;
			chain4.clear;

}).add;
);
}
)

~m=Pxrand(~k,512,1).asStream;
Synth(\obin_++(~m.next))
