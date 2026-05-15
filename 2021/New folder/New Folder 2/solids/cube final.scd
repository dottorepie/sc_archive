TempoClock.default.tempo_(120/180);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=18;
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
(SynthDef(\solidsl,{
	arg a=8,a1=4,filter=3,rq=1,sweep=11,sweep1=20,attack1=0.01,decay1=1,attack2=0.01,decay2=1;
	var x=0,y=1,freq,wave,partials=0,spat,scale=0,
	      x1=0,y1=1,freq1,wave1,spat1,scale1=0,partials1=0,
	      vectorbus1=7,ton=220,ton1=440,envelope1,bend,
	vectorbus=5,
	elevation_1=1,elevation_2=1,elevation_3=1,elevation_4=1,elevation_5=1,elevation_6=1,
	elevation_7=1,elevation_8=1,elevation_9=1,elevation_10=1,elevation_11=1,elevation_12=1,
	elevation_13=1,elevation_14=1,elevation_15=1,elevation_16=1,elevation_17=1,elevation_18=1,
	elevation_19=1,elevation_20=1,
	envelope,bus=1;

	bend=[2,-3];
	attack1=MouseX.kr(0.1,6);
	decay1=MouseY.kr(1,6);
	attack1=MouseX.kr(0.1,6);
	decay2=MouseY.kr(1,6);
	 envelope=EnvGen.kr(Env.perc(attack1,decay1,1/2,bend),doneAction:2);
	envelope1=EnvGen.kr(Env.perc(attack2,decay2,1/2,bend),doneAction:2);


4.do{  scale=scale+1; spat=scale/(scale+a); vectorbus=vectorbus+2;
		2.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
	partials=(partials+wave)*envelope1};
		Out.ar(vectorbus,PanAz.ar(2,partials*envelope1,LFSaw.ar(1/spat)))};


	Out.ar(0,InFeedback.ar(9)*elevation_1*envelope);
	Out.ar(1,InFeedback.ar(10)*elevation_2*envelope);
	Out.ar(2,InFeedback.ar(11)*elevation_3*envelope);
	Out.ar(3,InFeedback.ar(12)*elevation_4*envelope);
	Out.ar(4,InFeedback.ar(13)*elevation_5*envelope);
	Out.ar(5,InFeedback.ar(14)*elevation_6*envelope);
	Out.ar(6,InFeedback.ar(15)*elevation_7*envelope);
	Out.ar(7,InFeedback.ar(16)*elevation_8*envelope);
	Out.ar(8,InFeedback.ar(17)*elevation_9*envelope);




}).add
);


((f= Pdef(\pat1b, Pbind(\instrument, \solidsl,
	\dur,Pseq([1/4,1/4,1/4,1/8,1/8,1/8],inf),
			\a,Pseq([2,4,12,9,6,4,5,3,6,12,3,2,5,3,4,2,12,3],inf),
			\elevation_1,Pexprand(1/6,1,inf),
			\elevation_2,Pexprand(1/6,1,inf),
			\elevation_3,Pexprand(1/6,1,inf),
			\elevation_4,Pexprand(1/6,1,inf),
			\elevation_5,Pexprand(1/6,1,inf),
			\elevation_6,Pexprand(1/6,1,inf),
		    \elevation_7,Pexprand(1/6,1,inf),
			\elevation_8,Pexprand(1/6,1,inf),

)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
