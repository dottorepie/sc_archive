//////////////////////////////////
TempoClock.default.tempo_(120/80);
(
SynthDef.new(\id, {
	arg a=1,fund=200,b=1,x=0,bus=0,attack=1,decay=1,fil=440,gain=1;
	var y,sum=0,wave;
	var envelope,p=0;
	var k,kpos,z,zpos,l,lpos,m,mpos,j,jpos,i,ipos,ay,apos;
//fund=fund*2;
	b=b*(-1);
	8.do{
		p=p+(1/8);
	    x=x+1;
		y=(((x**b))+a)/(x**(b));

		k=Complex(x,y).abs;
		kpos=Complex(x,y).angle;

		z=(((k**b)+a)*fund)/(k**b);
		zpos=((kpos**b)+a)/(kpos**b);

		l=Complex(k,z).abs;
		lpos=Complex(kpos,zpos).angle;


		envelope=EnvGen.ar(Env.perc(attack,decay,1/k,[-1,-8]),doneAction:2);
		wave=BLowPass.ar(SinOsc.ar(l,mul: envelope,phase:p),880);
		sum= sum+wave;
		Out.ar(0,PanAz.ar(2,sum*envelope,(kpos)*bus,width:1.5));
	};


}).add;
)

Synth.new(\id,[\fund,400,\attack,1,\decay,4,\bus,]);

Tdef(\sa).play
Tdef(\sa).stop;


(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
	\decay,8,
	\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\2, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
		\decay,8,
			\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
)).play(quant:1));  (0).yield});
		 1.do({( Pdef(\3, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
		\decay,8,
	\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\4, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
		\decay,8,
			\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
)).play(quant:1));  (0).yield});

		 1.do({( Pdef(\5, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
		\decay,8,
	\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\6, Pbind(\instrument, \id,
\dur,Pwrand([2,1,0.5],[1,2,1].normalizeSum,inf),
			\fund, Pxrand([1.1,1],inf),
\b,Pwrand([2,3,4],[1,2,1].normalizeSum,inf),
			\a,Prand([1,2],inf),
\attack,0.01,
	\decay,8,
			\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
)).play(quant:1));  (360).yield});

Pdef(\1).stop;
		Pdef(\2).stop;
		Pdef(\3).stop;
		Pdef(\4).stop;
		Pdef(\5).stop;
		Pdef(\6).stop;
			})
)
Tdef(\sa).play
Tdef(\sa).stop;



///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////with spat
(
SynthDef.new(\id, {
	arg a=1,fund=200,b=1,x=0,bus=0,attack=1,decay=1,fil=440,el,az1,az2,az3,az4;
	var y,sum=0,wave;
	var envelope,p=0;
	var k,kpos,z,zpos,l,lpos;
	//b=TWChoose.kr(1,[4/1,5/2,6/3,7/4,8/5,9/6],[0.1,0.2,0.5,0.6,0.4,0.1]);
	b=b*(-1);
	12.do{
		p=p+1/26;
	    x=x+1;
		y=((x**b)+a)/(x**(b));

		k=Complex(x,y).abs;
		kpos=Complex(x,y).angle;

		z=(((k**b)-a)*fund)/(k**b);
		zpos=((kpos**b)-a)/(kpos**b);

		l=Complex(k,z).abs;
		lpos=Complex(kpos,zpos).angle;

		envelope=EnvGen.ar(Env.perc(attack,decay,1/k,[-4,-4]),doneAction:2);
		wave=SinOsc.ar(l,mul:envelope,phase:p);
		sum= sum+wave;
		Out.ar(20,PanAz.ar(4,sum*envelope,lpos*el));
		Out.ar(0,PanAz.ar(20,InFeedback.ar(20)*envelope,lpos*az1));
		Out.ar(5,PanAz.ar(5,InFeedback.ar(21)*envelope,lpos*az2));
		Out.ar(10,PanAz.ar(5,InFeedback.ar(22)*envelope,lpos*az3));
		Out.ar(15,PanAz.ar(5,InFeedback.ar(23)*envelope,lpos*az4));
	};


}).add;
)


(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
       \fund, 5,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,0.1,
	\decay,6,
		\el,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az1,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az2,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az3,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az4,Prand([0.5,0.333,(-0.333),(-0.5)],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\2, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
			\fund, 5.1,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,0.1,
	\decay,6,
			\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
)).play(quant:1));  (0).yield});
			 1.do({( Pdef(\3, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
       \fund, 10,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[2,4,2,1,1].normalizeSum,inf),
\attack,0.01,
	\decay,6,
		\el,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az1,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az2,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az3,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az4,Prand([0.5,0.333,(-0.333),(-0.5)],inf);
		)).play(quant:1));  (0).yield});
		1.do({( Pdef(\4, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
			\fund, 10.1,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[2,4,2,1,1].normalizeSum,inf),
\attack,0.1,
	\decay,6,
			\bus,Prand([1,0.75,0.5,0.25,0,(-0.25),(-0.5),(-0.75),(-1)],inf);
)).play(quant:1));  (0).yield});
		 1.do({(g= Pdef(\5, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
       \fund, 20,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[4,2,1,1,2].normalizeSum,inf),
\attack,0.1,
	\decay,6,
	\el,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az1,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az2,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az3,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az4,Prand([0.5,0.333,(-0.333),(-0.5)],inf);
		)).play(quant:1));  (0).yield});
		1.do({(Pdef(\6, Pbind(\instrument, \id,
	\dur,Pwrand([2,1,0.5],[1,2,4].normalizeSum,inf),
			\fund, 20.1,
			\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[4,2,1,1,2].normalizeSum,inf),
\attack,0.01,
	\decay,6,
				\el,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az1,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az2,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az3,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az4,Prand([0.5,0.333,(-0.333),(-0.5)],inf);
)).play(quant:1));  (360).yield});
Pdef(\1).stop;
		Pdef(\2).stop;
		Pdef(\3).stop;
		Pdef(\4).stop;
		Pdef(\5).stop;
		Pdef(\6).stop;
			})
)


/////////////////////////////////////

(
//~pot1 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~a= vel.linlin(6,87,2,20).postln; "a".postln}, 71, 0);
//~pot2 = MIDIFunc.cc( { arg vel,nn,chan,src; [vel,nn,chan,src];  ~b= vel.linlin(14,124,0.01,1).round.postln;"b".postln}, 73, 0);
~pot2 = MIDIFunc.cc( , 73, 0);
)

MIDIClient.init;.
MIDIIn.connectAll;



s.options.numOutputBusChannels=20
TempoClock.default.tempo_(120/45);
);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;

