a= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/untitled.wav");
s.options.memSize = 2097152
(
SynthDef.new(\idvoc, {
	arg a=1,fund=200,b=1,x=0,bus=1,attack=1,decay=1;
	var y,sum=0,wave;
	var envelope,p=0;
	var k,kpos,z,zpos,l,lpos,m,mpos,j,jpos,i,ipos,ay,apos;
	b=b*(-1);
	//fund=fund/2;
	24.do{
		p=p+(1/26);
		x=x+1;
		y=((x**b)+a)/(x**(b));
		k=Complex(x,y).abs;
		kpos=Complex(x,y).angle;

			z=(((k**b)-a)*fund)/(k**b);
		zpos=((kpos**b)-a)/(kpos**b);

		l=Complex(k,z).abs;
		lpos=Complex(kpos,zpos).angle;

		envelope=EnvGen.ar(Env.perc(attack,decay,1/k,[-4,-4]),doneAction:2);
		wave=PitchShift.ar(PlayBuf.ar(1,0,BufRateScale.kr(0),loop:inf),2,pitchRatio:l.linlin(2,400,0,4),mul:envelope,timeDispersion:p);
		sum= sum+wave;
		Out.ar(0,PanAz.ar(2,LeakDC.ar(sum*envelope),lpos*bus,width:2));
	};
}).add;
)

(
Tdef(\sa,{
				 1.do({(e= Pdef(\1, Pbind(\instrument, \idvoc,
	\dur,10,
           \fund, Prand([10,20],inf),
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,2,
	\decay,20,
		\bus,Prand([0.5,0.25,0.2,0,(-0.2),(-0.25),(-0.5)],inf);
		)).play(quant:1));  (pi/2).yield});
			 1.do({(e= Pdef(\2, Pbind(\instrument, \idvoc,
	\dur,10,
      	\fund, Prand([10.1,20.1],inf),
\b,Pwrand([5/1,6/2,7/3,8/4,9/5],[1,2,4,2,1].normalizeSum,inf),
\attack,2,
	\decay,20,
	\bus,Prand([0.5,0.25,0.2,0,(-0.2),(-0.25),(-0.5)],inf);
)).play(quant:1));  (3600).yield});


Pdef(\2).stop; 0.yield;
Pdef(\1).stop; 6.yield;

			})
)
Tdef(\sa).play;
Tdef(\sa).stop;



s.options.numOutputBusChannels=6;
TempoClock.default.tempo_(120/120);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Aggregate Device");
s.options.memSize = 524288
s.options.memSize
s.options.memSize
s.options.numInputBusChannels=2;
s.record(numChannels:6) ;

