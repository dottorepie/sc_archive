TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=12;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

(

s.options.numOutputBusChannels=12;
s.waitForBoot;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
s.options.memSize = 32768;
(

(
///////////////////////////////////////////////////////
(SynthDef(\solids,{
	arg ton=220,a=8,dur=1,filter=3,rq=1,sweep=2;
	var x=0,y=1,freq, envelope,wave,partials=0,bend,bus=1,dur1=0.01, spat,scale=0,phase=pi,vectorbus=4,
	elevation_1=1,elevation_2=1,elevation_3=1,elevation_4=1,elevation_5=1,elevation_6=1;
		bend=[2,-3];
	dur=MouseX.kr(0.5,5);
	dur1=MouseY.kr(0.1,6);
	 envelope=EnvGen.kr(Env.perc(dur1,dur,1,bend),doneAction:2);
	partials=0;
	ton=ton+1;
3.do{  scale=scale+1 ;spat=scale/(scale+a); vectorbus=vectorbus+2;
		2.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton); phase=phase+0.5pi;
		wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y,phase:phase),ton*filter,rq)*envelope;
		partials=(partials+wave)*envelope};
	Out.ar(vectorbus,PanAz.ar(2,partials*envelope,LFSaw.ar(sweep*spat)))};

	Out.ar(0,InFeedback.ar(6)*elevation_1*envelope);
	Out.ar(1,InFeedback.ar(7)*elevation_2*envelope);
	Out.ar(2,InFeedback.ar(8)*elevation_3*envelope);
	Out.ar(3,InFeedback.ar(9)*elevation_4*envelope);
	Out.ar(4,InFeedback.ar(10)*elevation_5*envelope);
	Out.ar(5,InFeedback.ar(11)*elevation_6*envelope);
}).add
);


((f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,Prand([1/4,1/8],inf),
           \ton, 110,
			\a,Pseq([2,5,3,4,5,3,4,5,6,8,6,7,5,6,4],inf),
			\elevation_1,Pexprand(1/6,1,inf),
			\elevation_2,Pexprand(1/6,1.2,inf),
			\elevation_3,Pexprand(1/6,1.2,inf),
			\elevation_4,Pexprand(1/6,1.2,inf),
			\elevation_5,Pexprand(1/6,1.2,inf),
			\elevation_6,Pexprand(1/6,1.2,inf),
)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
