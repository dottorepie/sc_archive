(
SynthDef.new(\id1, {

		arg dur=1,detune=0,attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr;
	var sig,x=0,amp=0.1,audio=0,fund=1200;
	var env,freq=1,envd,envf,pan=1;
		var x1=0,x2=1,x3,y;
	   envd=EnvGen.ar(Env.perc(attack,10,1/1,[-4,-4]),doneAction:2);
		12.do{
		env=EnvGen.ar(Env.perc(attack,10,amp/freq,[-4,-4]));
		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand,0.999.rand],[-4]));
		sig=PanAz.ar(2,SinOsc.ar((fund*freq)+envf,mul:env),LFNoise1.ar(1/pan),width:1);
		audio = audio +sig;
		x=x+1;
		freq=interval/(x+interval);
			x3=x1+x2;
		x1=x2;
		x2=x3;
		y=1+(1/x3);
			pan=pan*y;
	};
	Out.ar(0,audio*envd*pr);
}).add;
)
( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(1,8,inf),
					\attack,Pexprand(0.01,1,inf),
	\interval,Pbrown(1,1,1,inf),
	\a,Pexprand(1,20,inf),
	\b,Pexprand(1,20,inf),
	\c,Pexprand(1,20,inf),
	\d,Pexprand(1,20,inf),
	\e,Pexprand(1,20,inf),
	\f,Pexprand(1,20,inf),
	\g,Pexprand(1,20,inf),
	\k,Pexprand(1,20,inf),
	\l,Pexprand(1,20,inf),
	\m,Pexprand(1,20,inf),
	\n,Pexprand(1,20,inf),
	\o,Pexprand(1,20,inf),
		\p,Pexprand(1,20,inf),
	\q,Pexprand(1,20,inf),
		\r,Pexprand(1,20,inf),
	\s,Pexprand(1,20,inf),
	\t,Pexprand(1,20,inf),
		\u,Pexprand(1,20,inf),
	\v,Pexprand(1,20,inf),
	\w,Pexprand(1,20,inf),
		\pr,Pexprand(0.1,1,inf),
	\detune,Pexprand(1,8,inf);
)).play(quant:1))
///////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////
////////////////////////////

( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(0.1,1,inf),
	\n,Prand([1,2,3,4],inf);
)).play(quant:1));

(
SynthDef.new(\id1, {

		arg n=1,m=1;
	var sig,x=0,amp=1;
	var env,freq=220;
		var y=1;

	24.do{
		env=EnvGen.ar(Env.perc(0.01,6,1/(amp*y),[-4,-4]),doneAction:2);
		sig=PanAz.ar(2,BLowPass.ar(SinOsc.ar(freq*y,mul:env),2400),LFSaw.ar(1/y));
		x=x+1;
		y=(x+n)/(n);
			Out.ar(0,sig);
	};
}).add;
)



(
{
	var n1=1,n2=2,n3=3;
	var x=0,y1=1, y2=1,y3=1;
	var freq=220,amp=1;
	var sig1,sig2,sig3;
	100.do{
		sig1=SinOsc.ar(freq*y1,mul:1/(amp*y1),phase:pi);
		sig2=SinOsc.ar(freq*y2,mul:1/(amp*y2),phase:pi);
		sig3=SinOsc.ar(freq*y3,mul:1/(amp*y3),phase:pi);
		x=x+1;
		y1=(x+n1)/(n1);
		y2=(x+n2)/(n2);
		y3=(x+n3)/(n3);
		Out.ar(0,sig1);
		Out.ar(1,sig2);
		Out.ar(2,sig3);
	};

}.play)


(
{
	var n=1;
	var freq=440,amp=10;
	var sig,sig1,x1=1,x2=2,x3;
	var 	y=1;
	13.do{
			sig=SinOsc.ar(freq*y,mul:1/(amp*y),phase:pi);
		sig1=SinOsc.ar(freq*y,mul:1/(amp*y),phase:pi/2);
			x3=x1+x2;
		x1=x2;
		x2=x3;
		y=x2/x1;
		y.postln;
		Out.ar(0,sig);
		Out.ar(1,sig1);
	};

}.play)
///////////////
(
{
	var n=1;
	var x=0,y=1;
	var freq=440,amp=10;
	var sig,x1=0,x2=1,x3;
	var an=137.5,pan=an.wrap(0,360);
	13.do{
		sig=PanAz.ar(2,SinOsc.ar(freq*y,mul:1/y),pan,width:2,orientation:0);
				x3=x1+x2;
		x1=x2;
		x2=x3;
		x2.postln;
		y=x1/x2;
		an=an+137.5;
		pan=an.wrap(0,360);
		Out.ar(0,sig);
	};

}.play)
////////////////////////////////////////////////////////////////////////////////////////////
(
{
	var n=1;
	var x=0,y1=1,y2=1;
	var freq=2400,amp=0.1;
	var sig1,sig2;
	var a=137.5,pan=360/a;
	3.do{
		sig1=PanAz.ar(6,SinOsc.ar(freq*y1,mul:amp/y1,phase:pi),LFSaw.ar(343/(freq*pan)),width:1);
		sig2=PanAz.ar(6,SinOsc.ar(freq*y2,mul:amp/y2,phase:pi),LFSaw.ar(343/(freq*pan)),width:1);
		x=x+1;
		y1=n/(x+n);
		y2=(x+n)/n;
		a=a+a;
		pan=360/a;
		Out.ar(0,sig1);
		Out.ar(0,sig2);
	};
}.play;
)
////////////////////////////////////////////////////
(
{
	var x=0,y=1;
	var freq=440,amp=1;
	var sig;
	30.do{
		sig=SinOsc.ar(freq*(y),mul:1/(y))!2;
	x=x+1;
		y=(x+1)/1;
		y=y*0.6180339887;
		//z=Complex.new(1/y,y).abs;
	//	z.postln;
		Out.ar(0,sig)
	};

}.play)
///////////////////////////////////////////////

(
{
	var freq=220;
	var sig,x=0,y=1;
	var an=137.5,pan=an.wrap(0,360);

	100.do{
		sig=PanAz.ar(2,SinOsc.ar(freq,mul:1/y),pan,width:2,orientation:0);
			x=x+1;
		    y=(2.pow(x/12));
			freq=220*y;
		an=an+137.5;
		pan=an.wrap(0,360);
		Out.ar(0,sig);
	};

}.play)

////////////
(360-(360/1.6180339887)).postln;
(
{
	var sig,amp=1,fund=1000,over=1/10,x=0;
	var an=180,pan=an.wrap(0,360);

	20.do{
		sig=Pan2.ar(SinOsc.ar(fund*over,mul:amp/over),pan.linlin(0,360,-1,1));

			x=x+1;
		over=(x+1)/10;

		an=an+137.5;
		pan=an.wrap(0,360);

		Out.ar(0,sig);≥
	};

}.play)


s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=3
TempoClock.default.tempo_(120/10);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:2) ;