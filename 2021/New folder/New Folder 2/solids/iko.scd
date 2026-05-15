TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=12;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

(

s.options.numOutputBusChannels=14;
s.waitForBoot;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
~notes1=Array.newClear(128);
~notes2=Array.newClear(128);
s.options.memSize = 32768;
)
(
(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes0[nn] = Synth.new(\solids0,[\ton, nn.midicps,\monospat, nn.midicps]);
	~notes1[nn] = Synth.new(\solids1,[\ton, nn.midicps,\monospat, nn.midicps]);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes0[nn] = nil;
	~notes1[nn] = nil;
}));
s.record(numChannels:1) ;
);

///////////////////////////////////////////////////////
(SynthDef(\solids0,{
	arg ton=220,a=1,dur=1,filter=2,rq=1,monospat,sweep=40;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0,octahedron,phase=pi;
	bend=[4,-6];
	dur=MouseX.kr(0.5,5);
	dur1=MouseY.kr(0.1,5);
	 envelope=EnvGen.kr(Env.perc(dur1,dur,1/5,bend),doneAction:2);
	partials=0;
	ton=ton+1;
6.do{  scale=scale+1 ;spat=scale/(scale+a);4.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton); phase=phase=0.5;
		wave=BLowPass.ar(LFSaw.ar(freq,mul:1/y,iphase:phase),ton*filter,rq)*envelope;
		partials=(partials+wave)*envelope};
		Out.ar(0,PanAz.ar(1,partials*envelope,LFSaw.ar((1/(monospat/sweep)*spat))))};
	Out.ar(0,PanAz.ar(1,BLowPass.ar(LFSaw.ar(ton),ton*filter,rq)*envelope,LFSaw.ar((1/(monospat/440))*spat)));
	Out.ar(0,PanAz.ar(1,InFeedback.ar(8)*1/4,LFSaw.ar((1/(monospat/sweep)*spat)))); Out.ar(4,PanAz.ar(4,InFeedback.ar(9)*1/4,LFSaw.ar((1/(monospat/sweep))*spat)));
}).add;
);
)
(SynthDef(\solids1,{
	arg ton=220,a=3,dur=1,filter=2,rq=1,monospat,sweep=20;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0,octahedron,phase=pi;
	bend=[1,-5];
	dur=MouseX.kr(0.05,5);
	dur1=MouseY.kr(0.01,1);
	 envelope=EnvGen.kr(Env.perc(dur1,dur,1/5,bend),doneAction:2);
	partials=0;
12.do{  scale=scale+1 ;spat=scale/(scale+a);	4.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton); phase=phase=0.5;
		wave=BLowPass.ar(LFSaw.ar(freq,mul:1/y,iphase:phase),ton*filter,rq)*envelope;
		partials=(partials+wave)*envelope};
	Out.ar(8,PanAz.ar(2,partials*envelope,LFSaw.ar((1/(monospat/sweep)*spat))))};
	Out.ar(0,PanAz.ar(8,BLowPass.ar(LFSaw.ar(ton),ton*filter,rq)*envelope,LFSaw.ar((1/(monospat/sweep))*spat)));
	Out.ar(0,PanAz.ar(4,InFeedback.ar(8)*1/4,LFSaw.ar((1/(monospat/sweep)*spat)))); Out.ar(4,PanAz.ar(4,InFeedback.ar(9)*1/4,LFSaw.ar((1/(monospat/sweep))*spat)));
}).add);
)

//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

(
Tdef(\1,
      {

				 1.do({(f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,1,
           \ton, 440,
			\a,Prand([1,2,3,4],inf);
)).play(quant:1));

			(1).yield});
			})
);
//Tdef(\1).play;
)

/////////////////////////////
