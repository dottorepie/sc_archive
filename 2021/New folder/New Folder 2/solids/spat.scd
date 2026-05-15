TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=30;
s.options.memSize = 65536;
s.options.numBuffers= 2048
s.options.maxNodes= 2048
s.options.numInputBusChannels=0;
MIDIClient.init;
MIDIIn.connectAll;
~notes=Array.newClear(128);
s.record(numChannels:2) ;

(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes[nn] = Synth.new(\solids1,[\t1, nn.midicps]);
	~notes[nn] = Synth.new(\solids2,[\t2, nn.midicps]);
	~notes[nn] = Synth.new(\solids3,[\t3, nn.midicps]);
	~notes[nn] = Synth.new(\solids4,[\t4, nn.midicps]);
	~notes[nn] = Synth.new(\solids5,[\t5, nn.midicps]);
	~notes[nn] = Synth.new(\solids6,[\t6, nn.midicps]);
	~notes[nn] = Synth.new(\solids7);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes[nn] = nil;
}));
)

(
(
SynthDef(\solids1,{ arg t1=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t1;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(24,plane);
}).add;
);
(
SynthDef(\solids2,{ arg t2=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t2;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(25,plane);
}).add;
);
(
SynthDef(\solids3,{ arg t3=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t3;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(26,plane);
}).add;
);
(
SynthDef(\solids4,{ arg t4=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t4;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(27,plane);
}).add;
);
(
SynthDef(\solids5,{ arg t5=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t5;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(28,plane);
}).add;
);
(
SynthDef(\solids6,{ arg t6=220;
	var x=0,y,m,d,f,g=1,a=1,b=[8,-8],plane=0,edge,envelope;

	3.do{x=x+1;
		y=(x+a)/x;
		f=y*t6;
		m=1/y;
		d=m/y;
		envelope=EnvGen.kr(Env.perc(d,d,g,b),doneAction:2);
		edge=LFTri.ar(f,mul:m);
		plane=plane+edge;plane=plane*envelope;};
	Out.ar(29,plane);
}).add;
);
(
SynthDef(\solids7,{
	var octahedron;

	octahedron = PanAz.ar(24,Mix.new([InFeedback.ar(23),InFeedback.ar(24),InFeedback.ar(25),InFeedback.ar(26),InFeedback.ar(27),InFeedback.ar(28),InFeedback.ar(29)]),MouseX.kr(-0.5,0.5));
	Out.ar(0,octahedron);
}).add;
)
)


////////////////////////////////////////
/////////////////////88/////////////////////////////
//////////////////////////////
////////////////////////////////////
Tdef(\1).play;


(
Tdef(\1,
      {

				 1.do({(f= Pdef(\patte1, Pbind(\instrument, \solids,
	\dur,Prand([1],inf),
           \t, Prand([220,440,256,110],inf),
)).play(quant:1));

			(1).yield});
			})
)