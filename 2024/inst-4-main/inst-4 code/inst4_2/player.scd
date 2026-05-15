
////server setup
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(0.1);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

/////wavetables
Buffer.freeAll

(
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180252.wav");
~c2 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180341.wav");
~c3 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180440.wav");
~c4 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180528.wav");
~c5 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180616.wav");
~c6 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/SC_241013_180718.wav");
)

(
{

	Out.ar(0,PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));
	//Out.ar(0,PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));
	//Out.ar(0,PlayBuf.ar(4, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2));
	//Out.ar(0,PlayBuf.ar(4, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2));
	//Out.ar(0,PlayBuf.ar(4, ~c5.bufnum, BufRateScale.kr(~c5), loop: 0, doneAction:2));
	//Out.ar(0,PlayBuf.ar(4, ~c6.bufnum, BufRateScale.kr(~c6), loop: 0, doneAction:2));

}.play;
//s.record(numChannels:4,duration:45)
)


(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

////normal and reverse. beg,end
(
~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241021_125748.wav",channels:0);
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241021_125748.wav",channels:1);
~c3 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241021_125748.wav",channels:2);
~c4 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/inst-4/piknotites6/SC_241021_125748.wav",channels:3);
)


(
{

	Out.ar(0,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));
	Out.ar(1,PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));
	Out.ar(0,PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2));
	Out.ar(1,PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2));


}.play;
//s.record(numChannels:2)
)


(
Tdef.new(\h,{loop({

	Out.ar(0,PlayBuf.ar(4, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2));(1).wait;
	Out.ar(0,PlayBuf.ar(4, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2));

	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;


//////////


({Out.ar(0,SoundIn.ar(0))}.play;)