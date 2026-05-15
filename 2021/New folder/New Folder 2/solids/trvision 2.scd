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
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
(
s.options.numOutputBusChannels=12;
s.waitForBoot;
s.options.memSize = 65536;
(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes0[nn] = Synth.new(\solids,[\ton, nn.midicps,\monospat, nn.midicps]);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes0[nn] = nil;
}));
);

///////////////////////////////////////////////////////
(~v=SynthDef(\solids,{
	arg ton=220,a=1,gain=0.6,dur=1,filter=2,rq=1,monospat;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0;

	bend=[-3,-6];
	dur=MouseX.kr(0.1,10);
	dur1=MouseY.kr(0.01,1);
	 envelope=EnvGen.kr(Env.perc(dur1,dur,gain,bend),doneAction:2);
	partials=0;
	4.do{ scale=scale+1 ;spat=scale/(scale+a); 2.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
		wave=SinOsc.ar(freq,mul:1/y);
		partials=(partials+wave)*envelope};
	Out.ar(0,PanAz.ar(2,partials*envelope,LFSaw.ar(monospat/880+spat)))};
Out.ar(0,PanAz.ar(6,BLowPass.ar(LFSaw.ar(ton),ton*filter,rq),LFSaw.ar(monospat/880+spat))*gain);

	//stereo = PanAz.ar(2,Mix.new([InFeedback.ar(2),InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7)]),MouseX.kr(-0.5,0.5))*gain;
	//Out.ar(0,stereo);

}).add;
);
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
