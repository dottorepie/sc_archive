TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=40;
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
s.options.memSize = 32768;
)
(
(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes0[nn] = ~f.set(\ton, nn.midicps);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes0[nn] = nil;
}));)



(
///////////////////////////////////////////////////////
(~f=SynthDef(\solids,{
	arg a=8,a1=4,filter=3,rq=1,sweep=11,sweep1=20,attack1=0.01,decay1=1,attack2=0.01,decay2=1;
	var x=0,y=1,freq,wave,partials=0,spat,scale=0,
	    x1=0,y1=1,freq1,wave1,spat1,scale1=0,partials1=0, vectorbus1=4,ton=256,ton1=220,envelope1,bend,
	vectorbus=15,
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

5.do{  scale=scale+1; spat=scale/(scale+a); vectorbus=vectorbus+5;
		4.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=SinOsc.ar(freq,20,1/y)*envelope1;
	partials=(partials+wave)*envelope1};
		Out.ar(vectorbus,PanAz.ar(5,partials*envelope1,LFSaw.ar(spat*(10/decay2))))};

	Out.ar(0,InFeedback.ar(20)*elevation_1*envelope);
	Out.ar(1,InFeedback.ar(21)*elevation_2*envelope);
	Out.ar(2,InFeedback.ar(22)*elevation_3*envelope);
	Out.ar(3,InFeedback.ar(23)*elevation_4*envelope);
	Out.ar(4,InFeedback.ar(24)*elevation_5*envelope);
	Out.ar(5,InFeedback.ar(25)*elevation_6*envelope);
	Out.ar(6,InFeedback.ar(26)*elevation_7*envelope);
	Out.ar(7,InFeedback.ar(27)*elevation_8*envelope);
	Out.ar(8,InFeedback.ar(28)*elevation_9*envelope);
	Out.ar(9,InFeedback.ar(29)*elevation_10*envelope);
	Out.ar(10,InFeedback.ar(30)*elevation_11*envelope);
	Out.ar(11,InFeedback.ar(31)*elevation_12*envelope);
	Out.ar(12,InFeedback.ar(32)*elevation_13*envelope);
	Out.ar(13,InFeedback.ar(33)*elevation_14*envelope);
	Out.ar(14,InFeedback.ar(34)*elevation_15*envelope);
	Out.ar(15,InFeedback.ar(35)*elevation_16*envelope);
	Out.ar(16,InFeedback.ar(36)*elevation_17*envelope);
	Out.ar(17,InFeedback.ar(37)*elevation_18*envelope);
	Out.ar(18,InFeedback.ar(38)*elevation_19*envelope);
	Out.ar(19,InFeedback.ar(39)*elevation_20*envelope);




}).add
);


((f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,Pseq([1/4,1/4,1/4],inf),
			\a,Pseq([2,5,6,3,2,6,3,5],inf),
			\elevation_1,Pexprand(1/20,1,inf),
			\elevation_2,Pexprand(1/20,1,inf),
			\elevation_3,Pexprand(1/20,1,inf),
			\elevation_4,Pexprand(1/20,1,inf),
			\elevation_5,Pexprand(1/20,1,inf),
			\elevation_6,Pexprand(1/20,1,inf),
		    \elevation_7,Pexprand(1/20,1,inf),
			\elevation_8,Pexprand(1/20,1,inf),
			\elevation_9,Pexprand(1/20,1,inf),
			\elevation_10,Pexprand(1/20,1,inf),
			\elevation_11,Pexprand(1/20,1,inf),
			\elevation_12,Pexprand(1/20,1,inf),
		   \elevation_13,Pexprand(1/20,1,inf),
			\elevation_14,Pexprand(1/20,1,inf),
			\elevation_15,Pexprand(1/20,1,inf),
			\elevation_16,Pexprand(1/20,1,inf),
			\elevation_17,Pexprand(1/20,1,inf),
			\elevation_18,Pexprand(1/20,1,inf),
		    \elevation_19,Pexprand(1/20,1,inf),
			\elevation_20,Pexprand(1/20,1,inf),
)).play(quant:1));

		)
)
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
