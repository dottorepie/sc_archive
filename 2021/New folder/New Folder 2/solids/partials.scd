//////////////////////////////////a wave  fundamental as notes
(
(SynthDef.new(\iter_d, {
	arg a=1,pos=1,el1=0,el2=0,az1=0,az2=0,az3=0,b=1,el;
	var freq=1,sum1=0,sum2=0;
	var x=1,wave1,wave2,envelope;
	var decay=1,ton1=110,ton2=220,y;

	el1=LFSaw.ar(0.1); el2=LFSaw.ar();

	1.do{ 2.do{  x=x+1; y=((x**a)+a)/x;
		envelope=EnvGen.ar(Env.new([0,0.7,0.5,0.5,0],[0.1,0.6,0.4,0.8],[-4]),doneAction:2);
		wave1=SinOsc.ar(y*ton1,mul: (1/y))*envelope;  sum1 = sum1+wave1;
		wave2=SinOsc.ar(y*ton1,mul: (1/y))*envelope;  sum2= sum2+wave2};
	Out.ar(4,PanAz.ar(2,sum1*envelope,el2));
    Out.ar(4,PanAz.ar(2,sum2*envelope,el1))};
	  Out.ar(0,PanAz.ar(2,InFeedback.ar(4)*envelope,az1));
      Out.ar(2,PanAz.ar(2,InFeedback.ar(5)*envelope,az2));
}).add;
);

((a= Pdef(\pat3, Pbind(\instrument, \iter_d,
	\dur,1/4,
	\a,Pseq([2,3,1,4,2,4,2,3],inf),
	//\el,Pfunc({~el}),
	\az1,Pfunc({~az2}),
	\az2,Pfunc({~az1});
	//\b,Prand([1,2,3,4],inf),
)).play(quant:1));
))

(
~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az2 = vel.linlin(19,103,-0.5,0.5)}, 70, 0);
~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az1= vel.linlin(4,84,-0.5,0.5)}, 71, 0);
~pot3= MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~az3 = vel.linlin(21,101,-0.5,0.5)}, 72, 0);
~pot4= MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src].postln;  ~el = vel.linlin(16,127,-0.5,0.5)}, 73, 0);
)


s.options.numOutputBusChannels=9;

(
//s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=6;
//TempoClock.default.tempo_(120/60);
MIDIClient.init;
MIDIIn.connectAll;
)
TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

