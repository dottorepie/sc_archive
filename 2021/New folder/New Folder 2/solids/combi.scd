TempoClock.default.tempo_(120/40);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Blutetooth");
s.options.numOutputBusChannels=8;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;

(
///////////////////////////////////////////////////////
(
(SynthDef(\solidsc,{
	arg a=8,a1=4,filter=3,rq=1,sweep=11,sweep1=11,attack1=0.01,decay1=1,attack2=0.01,decay2=1;
	var x=0,y=1,freq,wave,partials=0,spat,scale=0, x1=0,y1=1,freq1,wave1,spat1,scale1=0,partials1=0, vectorbus1=4,ton=220,ton1=440,envelope1,bend,vectorbus=2, envelope,bus=1;
	bend=[2,-3]; attack1=MouseX.kr(0.1,1); decay1=MouseY.kr(1,6); attack1=MouseX.kr(0.1,1); decay2=MouseY.kr(1,6);
	 envelope=EnvGen.kr(Env.perc(attack1,decay1,1/2,bend),doneAction:2); envelope1=EnvGen.kr(Env.perc(attack2,decay2,1/2,bend),doneAction:2);
3.do{	2.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
	partials=(partials+wave)*envelope1};
		Out.ar(2,partials*envelope);}

}).add
);
(SynthDef(\solidsl,{
	arg a=8,a1=4,filter=3,rq=1,sweep=11,sweep1=20,attack1=0.01,decay1=1,attack2=0.01,decay2=1;
	var x=0,y=1,freq,wave,partials=0,spat,scale=0,x1=0,y1=1,freq1,wave1,spat1,scale1=0,partials1=0,  vectorbus1=7,ton=220,ton1=440,envelope1,bend,
	vectorbus=3, envelope,bus=1;
	bend=[2,-3]; attack1=MouseX.kr(0.1,6); decay1=MouseY.kr(1,6); attack1=MouseX.kr(0.1,6); decay2=MouseY.kr(1,6);
	 envelope=EnvGen.kr(Env.perc(attack1,decay1,1/2,bend),doneAction:2);  envelope1=EnvGen.kr(Env.perc(attack2,decay2,1/2,bend),doneAction:2);

4.do{ 2.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
	partials=(partials+wave)*envelope1};
		Out.ar(3,partials*envelope1)};
}).add
);
(SynthDef(\solidsk,{
	arg a=8,a1=4,filter=3,rq=1,sweep=11,sweep1=20,attack1=0.01,decay1=1,attack2=0.01,decay2=1;
	var x=0,y=1,freq,wave,partials=0,spat,scale=0, x1=0,y1=1,freq1,wave1,spat1,scale1=0,partials1=0, vectorbus1=10,ton=220,ton1=440,envelope1,bend,
	vectorbus=4,envelope,bus=1;

	bend=[2,-3];attack1=MouseX.kr(0.1,6);decay1=MouseY.kr(1,6);attack1=MouseX.kr(0.1,6);decay2=MouseY.kr(1,6);
	 envelope=EnvGen.kr(Env.perc(attack1,decay1,1/2,bend),doneAction:2);envelope1=EnvGen.kr(Env.perc(attack2,decay2,1/2,bend),doneAction:2);

4.do{  3.do{	x=x+1;      y= ((x+a)/x);      freq=(y*ton);
wave=BLowPass.ar(SinOsc.ar(freq,mul:1/y),ton*filter,rq)*envelope1;
	partials=(partials+wave)*envelope1};
		Out.ar(4,partials*envelope1)};
	Out.ar(0,Mix.ar([InFeedback.ar(2)*1/6,InFeedback.ar(3)*1/8,InFeedback.ar(4)*1/12])!2);

}).add
);
);

(
((f= Pdef(\pat2, Pbind(\instrument, \solidsc,
	\dur,3/2,
			\a,Pseq([2,4,6,5,3,4,2,5],inf);
)).play(quant:6));
		);
((f= Pdef(\pat1b, Pbind(\instrument, \solidsl,
	\dur,4/2,
			\a,Pseq([2,4,6,5,3,4,2,5],inf);
)).play(quant:8));
		);
((f= Pdef(\pat1h, Pbind(\instrument, \solidsk,
	\dur,4/3,
			\a,Pseq([2,4,6,5,3,4,2,5],inf);
)).play(quant:12));
		);
)

)
