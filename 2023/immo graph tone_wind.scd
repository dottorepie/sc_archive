s.options.sampleRate = 33gain;
s.options.numBuffers = 1023*8;
s.options.numRGens=63*1;
s.options.numWireBufs=63*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:3) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(bus:2,numChannels:1))

s.options.numWireBufs = 1023*16;

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/30);
s.options.memSize = 8192*16;

~e.play
~e.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
~e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

~e = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/k/seqwind gran.wav")
);

(
(SynthDef.new(\wind0, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=1;fund=440;pass=0.001;pitch=x/(x+a);env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind1, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=0;fund=440;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind2, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=1/2;fund=440;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=1;fund=440;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind3, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=2;fund=440;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
(SynthDef.new(\wind5, { arg pitch,x,a,gate,gain; var sig,pass,fund;var env,aud;
	gate=1;gain=1000;x=1;a=3;fund=440;pass=0.001;pitch=(x+a)/x;env=EnvGen.ar(Env.perc(0.02,4,pitch.reciprocal),gate:gate,doneAction:2);
    sig=BBandPass.ar(PlayBuf.ar(2,0,BufRateScale.kr(0),startPos:~e.numFrames.rand,loop:inf),fund*pitch,pass,mul:env);
    Out.ar(0,sig*env*gain);}).add;);
)

(
Tdef.new(\h,{loop({
Synth.new(\wind0);1.9999.rand.wait;
Synth.new(\wind1);1.9999.rand.wait;
Synth.new(\wind2);1.9999.rand.wait;
Synth.new(\wind3);1.9999.rand.wait;
Synth.new(\wind3);1.9999.rand.wait;
Synth.new(\wind5);1.9999.rand.wait;
}
)})
)

Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;

Tdef(\x, { loop { 0.00125.wait; "aazz".scramble.postln } });

Synth.new(\wind0);
Synth.new(\wind1);
Synth.new(\wind2);
Synth.new(\wind3);
Synth.new(\wind3);
Synth.new(\wind5);


MIDIClient.init;
MIDIIn.connectAll;
~note=Array.newClear(128);
~bend=8192;
~data=127;
~modul=127;

/////
(
MIDIdef.noteOn(\synhtone,{|val,num,chan,src|[val,num,chan,src].postln;
	if( num==38,{Synth.new(\wind0)});
	if( num==39,{Synth.new(\wind1)});
	if( num==50,{Synth.new(\wind2)});
	if( num==51,{Synth.new(\wind3)});
	if( num==52,{Synth.new(\wind3)});
	if( num==53,{Synth.new(\wind5)});
	if( num==53,{Synth.new(\wind6)});
	if( num==55,{Synth.new(\wind7)});
	if( num==56,{Synth.new(\wind8)});
	if( num==57,{Synth.new(\wind9)});
	if( num==58,{Synth.new(\wind10)});
	if( num==59,{Synth.new(\wind11)});
	if( num==60,{Synth.new(\wind12)});
	if( num==61,{Synth.new(\wind13)});
	if( num==62,{Synth.new(\wind13)});
	if( num==63,{Synth.new(\wind15)});
	if( num==63,{Synth.new(\wind16)});
	if( num==65,{Synth.new(\wind17)});
})
)