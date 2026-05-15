TempoClock.default.tempo_(120/160);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=12;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;


s.options.numOutputBusChannels=12;
s.waitForBoot;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
s.options.memSize = 32768;


(
///////////////////////////////////////////////////////
(SynthDef(\solidsc,{
	arg a=8,attack1=0.01,decay1=1;
	var x=0,y=1,freq,wave,partials=0, ton=440,bend,envelope;
	var spat,partialss=0;

	bend=[2,-3];
	decay1=MouseX.kr(1,6);
	attack1=MouseY.kr(0.01,1);
	 envelope=EnvGen.kr(Env.perc(attack1,decay1,1/2,bend),doneAction:2);

//3.do{  scale=scale+1; spat=scale/(scale+a); vectorbus=vectorbus+2; bus=bus+1;
		3.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=SinOsc.ar(freq,mul:1/y)*envelope;
spat=LFSaw.ar(freq);
	partials=(partials+wave)*envelope; partialss=(partialss+spat)};
		Out.ar(0,PanAz.ar(4,partials*envelope,spat));

}).add
);


((f= Pdef(\pat2, Pbind(\instrument, \solidsc,
	\dur,Pseq([1],inf),
			\a,Pseq([2,4,1,5,6,4,5,3,6,1,3,2,5,3,4,2,1,3],inf),
)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
