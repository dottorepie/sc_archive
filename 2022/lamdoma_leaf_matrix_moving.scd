
(
SynthDef.new(\id1, {

	arg dur=1, attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,y=1;
	var sig1,sig2,x=0,amp=1,fund=256*4;  var env1,env2,envd,envf;
	var under=1,over=1;  var an1=180,an2=180,pan1=an1.wrap(0,360),pan2=an2.wrap(0,360);
	var msig1,msig2,audio1,audio2,	i=(y+interval)/interval,ii=interval/(y+interval);

	envd=EnvGen.ar(Env.sine((12000*dur)/(fund),amp),doneAction:2);

		4.do{
		env1=EnvGen.ar(Env.perc(attack,(12000*dur)/((fund*i)*under),amp/under,[-4,-4]));
		env2=EnvGen.ar(Env.perc(attack,(12000*dur)/((fund*ii)*over),amp/over,[-4,-4]));

		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand],[-4]));

			sig1=Pan2.ar(SinOsc.ar(((fund*i)*under)+envf,mul:env1,phase:pi),pos:pan1.linlin(0,360,-1,1));
		    sig2=Pan2.ar(SinOsc.ar(((fund*ii)*over)+envf,mul:env2,phase:pi),pos:pan2.linlin(0,360,-1,1));

		x=x+1;
		over=(x+1)/1;
		 under=1/(x+1);

		an1=an1-137.5;
		an2=an2+137.5;
		pan1=an1.wrap(0,360);
		pan2=an2.wrap(0,360);

			Out.ar(2,sig1*envd*pr);
		   Out.ar(2,sig2*envd*pr);

	};
	Out.ar(0,PanAz.ar(2,InFeedback.ar(2),LFSaw.ar(0.15),width:1,orientation:0));
	Out.ar(0,PanAz.ar(2,InFeedback.ar(3),LFSaw.ar(0.15),width:1,orientation:1));
}).add;
);

/////////////////////////////	i=2.pow(interval/12);

(
( Pdef(\1, Pbind(\instrument, \id1,
			\dur,Pexprand(1,2,inf),
					\attack,Pexprand(0.01,1,inf),
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
	\interval,Pbrown(1,3,1,inf),
	\y,Pbrown(0,2,1,inf),
	\pr,Pexprand(0.01,0.06,inf);
)).play(quant:1));

)




s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=8
TempoClock.default.tempo_(120/120);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;