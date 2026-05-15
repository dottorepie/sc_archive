
(
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=12;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.5);
s.options.memSize = 8192*64;
s.options.blockSize = 64*8;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 48000;
s.waitForBoot
);

Buffer.freeAll
(
~s = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/SC_241128_154919.wav");
)

/////synths////
(
SynthDef.new(\ospace1, {
	arg cuttfreq,band,duration;
	var env,in,sig,delay;

	env=EnvGen.ar(Env.sine(duration));
	in=InFeedback.ar(6,6);
	sig=BPF.ar(in,cuttfreq,band,1/(band.sqrt));
	delay=CombC.ar(sig);
	Out.ar(0,delay*env);
}).add;
);

//////////pattern for mobius strib of sequential or parallel play of directions
(
~aa=Pdef(\1, Pbind(\instrument, \ospace1,
	\dur,Pbrown(1,1,1,inf),
	\duration,Pbrown(2,8,1,inf),
	\cuttfreq,Pexprand(20,20000,inf),
	\band,Pexprand(0.00001,1,inf);

));
	);
	TempoClock.default.tempo_(1/1);

//s.record(numChannels:4);
	/////////////////////scales
//Scale.directory;

		//	s.record(numChannels:4);

	(
Tdef.new(\h,{
//loop({
			(1).wait;
//s.record(numChannels:4);
			(1).wait;
		//	s.record(numChannels:4);
~aa.play;
{Out.ar(6, PlayBuf.ar(6, ~s.bufnum, BufRateScale.kr(~s), loop: 0, doneAction:2))}.play;

s.record(numChannels:6);
			(1).wait;
//s.stopRecording
//	})
})
);



//Tdef(\h).stop;
//Tdef(\h).play;
//Tdef(\h).clear;

}
)
