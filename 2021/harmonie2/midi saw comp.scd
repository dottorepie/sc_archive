TempoClock.default.tempo_(120/60);
MIDIClient.init;
MIDIIn.connectAll;
(
~notes1 = Array.newClear(128);
~notes2 = Array.newClear(128);
~notes3 = Array.newClear(128);
~notes4 = Array.newClear(128);
)
(
MIDIdef.noteOn(\noteOn1, { arg vel,nn,chan,src; [vel,nn].postln;
	~notes1[nn] = Synth.new(\id1, [\f,nn.midicps,\gate,1]);
});

MIDIdef.noteOn(\noteOn2, { arg vel,nn,chan,src; [vel,nn].postln;
	~notes2[nn] = Synth.new(\id2, [\f,nn.midicps,\gate,1]);
});
MIDIdef.noteOn(\noteOn3, { arg vel,nn,chan,src; [vel,nn].postln;
	~notes3[nn] = Synth.new(\id3, [\f,nn.midicps,\gate,1]);
});
MIDIdef.noteOn(\noteOn4, { arg vel,nn,chan,src; [vel,nn].postln;
	~notes4[nn] = Synth.new(\id4, [\f,nn.midicps,\gate,1]);
});

MIDIdef.noteOff(\noteOff1, {arg vel,nn; [vel,nn].postln;
	~notes1[nn].set(\gate,0);
	~notes1[nn]=nil;
});
MIDIdef.noteOff(\noteOff2, {arg vel,nn; [vel,nn].postln;
	~notes2[nn].set(\gate,0);
	~notes2[nn]=nil;
});
MIDIdef.noteOff(\noteOff3, {arg vel,nn; [vel,nn].postln;
	~notes3[nn].set(\gate,0);
	~notes3[nn]=nil;
});
MIDIdef.noteOff(\noteOff4, {arg vel,nn; [vel,nn].postln;
	~notes4[nn].set(\gate,0);
	~notes4[nn]=nil;
});
)



(
(
SynthDef.new(\id1, {

	arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=0.01,f=20,l=440,gate=0;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
l=MouseX.kr(440,10000);
	    env=EnvGen.ar(Env.perc(a,1.2,1/6,[-4,-4]),gate:gate,doneAction:2);
		200.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*6,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l,MouseY.kr(0.1,1));
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id2, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=0.01,f=20,l=440,gate=0;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
l=MouseX.kr(440,3200);
	env=EnvGen.ar(Env.perc(a,2,1/8,[-4,-4]),gate:gate,doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*8,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id3, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=0.01,f=20,l=440,gate=0;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
l=MouseX.kr(440,3200);
	    env=EnvGen.ar(Env.perc(a,2,1/9,[-4,-4]),gate:gate,doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*9,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
);
(
SynthDef.new(\id4, {

		arg dur=1,pr=1,pass=1,n=1,b=0,sp=10000,a=0.01,f=20,l=440,gate=0;
	var sig,x=0,amp=1,audio=0;
	var env,freq;
l=MouseX.kr(440,3200);
	    env=EnvGen.ar(Env.perc(a,2,1/12,[-4,-4]),gate:gate,doneAction:2);
		32.do{
		sig=PanAz.ar(2,FSinOsc.ar(f*12,mul:1/amp),LFSaw.ar(amp),width:2);
		audio = audio +sig;
		x=x+1;
		freq=(x+1)/x;
		f=f*freq*n;
		amp=amp*freq*n;
	};
	audio=BLowPass.ar(audio,l);
	Out.ar(0,audio*env);
}).add;
)
)

//////////////////////////

{SoundIn.ar(0)}.play