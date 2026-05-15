//////////////////////////////////no pattern + vokoder
s.options.memSize = 2097152
TempoClock.default.tempo_(120/60);

(
SynthDef.new(\idvoc, {
	arg a=1,fund=200,b=1,x=0,bus=1,attack=1,decay=1;
	var y,sum=0,wave;
	var envelope,p=0;
	var k,kpos,z,zpos,l,lpos,m,mpos,j,jpos,i,ipos,ay,apos;
	b=b*(-1);
	//fund=fund/2;
	12.do{
		p=p+(1/26);
		x=x+1;
		y=((x**b)+a)/(x**(b));
		k=Complex(x,y).abs;
		kpos=Complex(x,y).angle;

			z=(((k**b)-a)*fund)/(k**b);
		zpos=((kpos**b)-a)/(kpos**b);

		l=Complex(k,z).abs;
		lpos=Complex(kpos,zpos).angle;

		envelope=EnvGen.ar(Env.perc(attack,decay,6/k,[-4,-4]),doneAction:2);
		wave=PitchShift.ar(SoundIn.ar(0,mul:10),4,pitchRatio:l.linlin(0,4000,0,4),mul:envelope,timeDispersion:p);
		sum= sum+wave;
		Out.ar(0,PanAz.ar(2,LeakDC.ar(sum*envelope),lpos*bus,width:1));
	};
}).add;
)

(
Tdef(\sa,{
				 1.do({(e= Pdef(\1, Pbind(\instrument, \idvoc,
	\dur,Pwrand([4,2,1,0.5,0.25],[1,2,4,2,1].normalizeSum,inf),
           \fund, 10,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,0.01,
	\decay,8,
		\bus,Prand([0.5,0.25,0.2,0,(-0.2),(-0.25),(-0.5)],inf);
		)).play(quant:1));  (pi/2).yield});
			 1.do({(e= Pdef(\2, Pbind(\instrument, \idvoc,
	\dur,Pwrand([4,2,1,0.5,0.25],[1,2,4,2,1].normalizeSum,inf),
      	\fund, 10.1,
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,0.01,
	\decay,8,
	\bus,Prand([0.5,0.25,0.2,0,(-0.2),(-0.25),(-0.5)],inf);
)).play(quant:1));  (3600).yield});


Pdef(\2).stop; 0.yield;
Pdef(\1).stop; 6.yield;

			})
)
Tdef(\sa).play;
Tdef(\sa).stop;



/////////////////////////////////////
/////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////with spat


(
SynthDef.new(\idvoc, {
	arg a=1,fund=200,b=1,x=0,bus=1,attack=1,decay=1;
	var y,sum=0,wave;
	var envelope,p=0;
	var k,kpos,z,zpos,l,lpos,m,mpos;
	b=b*(-1);
	fund=fund/2;
	6.do{
		p=p+(1/26);
		x=x+1;
		y=((x**b)+a)/(x**(b));
		k=Complex(x,y).abs;
		kpos=Complex(x,y).angle;
		z=((k**b)+a)/(k**b);
		zpos=((kpos**b)+a)/(kpos**b);
		l=Complex(k,z).abs;
		lpos=Complex(kpos,zpos).angle;
		m=((l**b)+a)/(l**b);
		mpos=((lpos**b)+a)/(lpos**b);
		envelope=EnvGen.ar(Env.perc(attack,decay,1/y,[-4,-4]),doneAction:2);
		wave=PitchShift.ar(SoundIn.ar(0),4,pitchRatio:(fund*m).linlin(0,400,0,4),mul:envelope,timeDispersion:p);
		sum= sum+wave;
		Out.ar(20,PanAz.ar(4,sum*envelope,s*el));
		Out.ar(0,PanAz.ar(20,InFeedback.ar(20)*envelope,s*az1));
		Out.ar(5,PanAz.ar(5,InFeedback.ar(21)*envelope,s*az2));
		Out.ar(10,PanAz.ar(5,InFeedback.ar(22)*envelope,s*az3));
		Out.ar(15,PanAz.ar(5,InFeedback.ar(23)*envelope,s*az4));
	};


}).add;
)
Synth.new(\id,[\fund,400,\attack,1,\decay,4,\bus,]);


(
(e= Pdef(\pat1, Pbind(\instrument, \vokoda,
	\dur,Pwrand([4,2,1,0.5,0.25,0.125],[0.1,0.2,0.3,0.3,0.2,0.1],inf),
       \fund, Pwrand([10,20],[0.1,0.2],inf),
\b,Pwrand([3/1,4/2,5/3,6/4,7/5,8/6],[0.1,0.2,0.5,0.3],inf),
	\attack,2,
	\decay,3,
		\el,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az1,Prand([0],inf),
	\az2,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
		\az3,Prand([0.5,0.333,(-0.333),(-0.5)],inf),
	\az4,Prand([0.5,0.333,(-0.333),(-0.5)],inf);
)).play(quant:1));
)


s.options.numOutputBusChannels=6;
TempoClock.default.tempo_(120/30);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Aggregate Device");
s.options.memSize = 524288
s.options.memSize
s.options.memSize
s.options.numInputBusChannels=2;
s.record(numChannels:6) ;

