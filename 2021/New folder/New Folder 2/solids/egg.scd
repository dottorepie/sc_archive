TempoClock.default.tempo_(120/60);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=40;
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
MIDIClient.init;
MIDIIn.connectAll;
~notes0=Array.newClear(128);
s.record(numChannels:2) ;


///////////////////////////////////////////////////////
(
(SynthDef(\solids1,{
    arg ton=220,a=1,gate=0;
	var frequency0=1, x0=0, y0=0, duration0=6,  envelope0=1,mul0=1,monad=0,uno,bus0=22, attack=0.024,bend=[11,-11],
	      frequency1=1, x1=0, y1=0, duration1=6,  envelope1=1,mul1=1,q1=0,bus1=22,
	      frequency2=1, x2=0, y2=0, duration2=6,  envelope2=1,mul2=1,q2=0,bus2=26,
	      frequency3=1, x3=0, y3=0, duration3=6,  envelope3=1,mul3=1,q3=0,bus3=31,
	     mono,stereo=0,triangle=0,quad=0,tetrahedron=0,octahedron=0,cube=0,gain=1/110,pan,panLR;

	pan=MouseX.kr(-1/2,1/2);  panLR=MouseY.kr(-1/2,1/2) ; mono=SinOsc.ar(ton);

	2.do{
		x0=x0+1;      y0= ((x0+1)/x0);      frequency0=(y0*ton);      mul0=(1/y0);      duration0= (y0/mul0);
	//envelope0=EnvGen.kr(Env.sine(duration1),doneAction:2);
		envelope0=EnvGen.kr(Env.perc(duration0,duration0,curve:bend),doneAction:2);
		uno =PanAz.ar(18,SinOsc.ar(frequency0,mul: mul0)+mono,BLowPass.ar(LFSaw.ar(mul0/y0),frequency0))*envelope0;
	monad=(uno +monad)*envelope1};
	Out.ar(bus0,monad);

	2.do{
	 x1=x1+1;      y1= ((x1+2)/x1);      frequency1=(y1*ton);      mul1=(1/y1);      duration1= (y1/mul1);
	//envelope1=EnvGen.kr(Env.sine(duration1),doneAction:2);
		envelope1=EnvGen.kr(Env.perc(duration1,duration1,curve:bend),doneAction:2);
		stereo=PanAz.ar(2,SinOsc.ar(frequency1,mul: mul1)+mono,BLowPass.ar(LFSaw.ar(mul1/y1),frequency1))*envelope1;
	tetrahedron=(stereo +tetrahedron)*envelope1;
	Out.ar(bus1,tetrahedron);   bus1=bus1+2;};
	3.do{
	x2=x2+1;        y2 = ((x2+3)/x2);      frequency2=(y2*ton);      mul2=(1/y2);      duration2= (y2/mul2);
	//envelope2=EnvGen.kr(Env.sine(duration2),doneAction:2);
		envelope2=EnvGen.kr(Env.perc(duration2,duration2,curve:bend),doneAction:2);
		triangle = PanAz.ar(2,SinOsc.ar(frequency2,mul: mul2)+mono,BLowPass.ar(LFSaw.ar(mul2/y2),frequency2))*envelope2;
	octahedron=(triangle +octahedron)*envelope2;
    Out.ar(bus2,octahedron);    bus2=bus2+2;};
	4.do{
	x3=x3+1;        y3 = ((x3+4)/x3);       frequency3=(y3*ton);     mul3=(1/y3);     duration3= (y3/mul3);
	//envelope3=EnvGen.kr(Env.sine(duration3),doneAction:2);
		envelope3=EnvGen.kr(Env.perc(duration3,duration3,curve:bend),doneAction:2);
		quad = PanAz.ar(2,SinOsc.ar(frequency3,mul: mul3)+mono,BLowPass.ar(LFSaw.ar(mul3/y3),frequency3))*envelope3;
    cube=(quad +cube)*envelope1;
	Out.ar(bus3,cube);      bus3=bus3+2;};

	Out.ar(2,PanAz.ar(4,Mix.new([InFeedback.ar(22),InFeedback.ar(23),InFeedback.ar(24),InFeedback.ar(25)]),pos:pan));
	Out.ar(6,PanAz.ar(8,Mix.new([InFeedback.ar(26),InFeedback.ar(27),InFeedback.ar(28),InFeedback.ar(29),InFeedback.ar(30),InFeedback.ar(31)]),pos:pan));
    Out.ar(14,PanAz.ar(6,Mix.new([InFeedback.ar(32),InFeedback.ar(33),InFeedback.ar(34),InFeedback.ar(35),InFeedback.ar(36),InFeedback.ar(37),InFeedback.ar(38),InFeedback.ar(39)]),pos:pan));


	Out.ar(0,PanAz.ar(2,Mix.new([ InFeedback.ar(2), InFeedback.ar(3) , InFeedback.ar(4) , InFeedback.ar(5) , InFeedback.ar(6) , InFeedback.ar(7) , InFeedback.ar(8) , InFeedback.ar(9) ,InFeedback.ar(10) , InFeedback.ar(11) ,
		                                                InFeedback.ar(12) , InFeedback.ar(13) , InFeedback.ar(14) , InFeedback.ar(15) , InFeedback.ar(16) , InFeedback.ar(17) , InFeedback.ar(18) , InFeedback.ar(19),InFeedback.ar(20)]),panLR)*gain)
}).add
);
(
(MIDIdef.noteOn(\noteOnTest, { arg vel,nn,chan,src; [nn,vel].postln;
	~notes0[nn] = Synth.new(\solids1,[\ton, nn.midicps,\gate,1]);
}));
(
MIDIdef.noteOff(\noteOffTest, { arg vel,nn;
	~notes0[nn].set(\gate,0);
	~notes0[nn] = nil;
}));
)
)


Tdef(\1).play;
)


(
Tdef(\1,
      {

	//	 1.do({(g= Pdef(\voice_3, Pbind(\instrument, \v3,
//	\dur,Prand([1],inf),
  //      \ton, Prand([220,440,256,110],inf),
	//		\gate,1,
	//\a,Pseq([2,3,5,8,2,5,8,2],inf);
//)).play(quant:1));
//
	//(1/2).yield});

				 1.do({(f= Pdef(\voice_4, Pbind(\instrument, \v4,
	\dur,Prand([1],inf),
           \ton, Prand([220,440,256,110],inf),
			\gate,1,
	\a,Pseq([2,3,5,8,2,5,8,2],inf);
)).play(quant:1));

			(1).yield});


	})
)