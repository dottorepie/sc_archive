TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=8;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
s.record(numChannels:2) ;

///////////////////////////////////////////////////////
(
(SynthDef(\solids,{
	arg ton=220,a=1,gain=1,offset1=0.1,offset2=0.1,offset3=0.1,offset4=0.1,offset5=0.1,offset6=0.1;
	var x=0,y=1,freq, envelope,p1,sidea,side1,
	      x2=0,y2=0,freq2,envelope2,p2,sideb,side2,
         	x3=0,y3=0,freq3,envelope3,p3,sidec,side3,
        	x4=0,y4=0,freq4,envelope4,p4,sided,side4,
	          x5=0,y5=1,freq5, envelope5,p5,sidef,side5,
	           x6=0,y6=0,freq6,envelope6,p6,sideg,side6,
	         dur,bend=[5,-3];

	sidea=0;//Out.ar(2,LFTri.ar(ton+offset1));
	sideb=0;//Out.ar(3,LFTri.ar(ton+offset2));
	sidec=0;//Out.ar(4,LFTri.ar(ton+offset3));
	sided=0;//Out.ar(5,LFTri.ar(ton+offset4));
	sidef=0;//Out.ar(6,LFTri.ar(ton+offset5));
	sideg=0;//Out.ar(7,LFTri.ar(ton+offset6));
	dur=1;
	 envelope=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	 envelope2=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	 envelope3=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	 envelope4=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	 envelope5=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	 envelope6=EnvGen.kr(Env.perc(dur,dur,gain,bend),doneAction:2);
	    4.do{
		x=x+1;      y= ((x+a)/x);      freq=(y*ton);
		side1=SinOsc.ar(freq,mul:1/y,iphase:0pi);
		sidea=(sidea+side1); p1=sidea*envelope};
	    4.do{
		x2=x2+1;      y2= ((x2+a)/x2);      freq2=(y2*ton);
		side2=SinOsc.ar(freq2,mul:1/y2,iphase:pi/2);
		sideb=(sideb+side2); p2=sideb*envelope2};
		4.do{
		x3=x3+1;      y3= ((x3+a)/x3);      freq3=(y3*ton);
		side3=SinOsc.ar(freq3,mul:1/y3,iphase:pi);
		sidec=(sidec+side3); p3=sidec*envelope3};
		4.do{
		x4=x4+1;      y4= ((x4+a)/x4);      freq4=(y4*ton);
  	   side4=SinOsc.ar(freq4,mul:1/y4,iphase:(3pi)/2);
		sided=(sided+side4); p4=sided*envelope4};
	    4.do{
		x5=x5+1;      y5= ((x5+a)/x5);      freq5=(y5*ton);
		side5=SinOsc.ar(freq5,mul:1/y5,iphase:pi);
		sidef=(sidef+side5); p5=sidef*envelope5};
		4.do{
		x6=x6+1;      y6= ((x6+a)/x6);      freq6=(y6*ton);
	side6=SinOsc.ar(freq6,mul:1/y6,iphase:(3pi)/2);
		sideg=(sideg+side6); p6=sideg*envelope6};
Out.ar(2,p1);
Out.ar(3,p2);
Out.ar(4,p3);
Out.ar(5,p4);
Out.ar(6,p5);
Out.ar(7,p6);
	Out.ar(0,PanAz.ar(2,Mix.new([InFeedback.ar(2),InFeedback.ar(3),InFeedback.ar(4),InFeedback.ar(5),InFeedback.ar(6),InFeedback.ar(7)])*0.1,MouseX.kr(-0.5,0.5)));
}).add;
);
//////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

(
Tdef(\1,
      {

				 1.do({(f= Pdef(\pat1, Pbind(\instrument, \solids,
	\dur,Pexprand(0.1,1,inf),
           \ton, Pexprand(110,880,inf),
			\a,Prand([2,3,5],inf);
)).play(quant:1));

			(1).yield});
			})
);
Tdef(\1).play;
)

/////////////////////////////
