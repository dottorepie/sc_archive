
(
SynthDef.new(\id1, {

	arg dur=1, attack=4,a,b,c,d,e,f,g,k,l,m,n,o,p,q,r,s,t,u,v,w,interval=1,pr,y=1;
	var sig1,sig2,x=0,amp=1,fund=256;  var env1,env2,envd,envf;
	var under=1,over=1;  var an1=180,an2=180,pan1=an1.wrap(0,360),pan2=an2.wrap(0,360);
	var msig1,msig2,audio1,audio2,	i=(y+interval)/interval,ii=interval/(y+interval);

	envd=EnvGen.ar(Env.sine((1200*dur)/(fund),amp),doneAction:2);

		8.do{
		env1=EnvGen.ar(Env.perc(attack,(1200*dur)/((fund*i)*under),amp/under,[-4,-4]));
		env2=EnvGen.ar(Env.perc(attack,(1200*dur)/((fund*ii)*over),amp/over,[-4,-4]));

		envf=EnvGen.ar(Env.new([a.rand2,b.rand2,c.rand2,d.rand2,e.rand2,f.rand2,g.rand2,k.rand2,l.rand2,m.rand2,n.rand2,o.rand2,p.rand2,q.rand2,r.rand2,s.rand2,t.rand2,u.rand2,v.rand2,w.rand2],[((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand,((dur*12000)/((fund))).rand],[-4]));

		sig1=Pan2.ar(FreeVerb.ar(SinOsc.ar((((fund*i)*4)*under)+envf,mul:env1,phase:pi),mix:under.wrap(0,1),room:0.1),pos:pan1.linlin(0,360,-1,1));
		sig2=Pan2.ar(FreeVerb.ar(SinOsc.ar((((fund*ii)*1)*over)+envf,mul:env2,phase:pi),mix:over.wrap(0,1),room:0.1),pos:pan2.linlin(0,360,-1,1));

		x=x+1;
		over=(x+1)/1;
		 under=1/(x+1);

		an1=an1-137.5;
		an2=an2+137.5;
		pan1=an1.wrap(0,360);
		pan2=an2.wrap(0,360);

			Out.ar(0,sig1*envd*pr);
		Out.ar(0,sig2*envd*pr);

	/*	Out.ar(0,PanAz.ar(2,sig1*envd*pr,LFSaw.ar(383/(fund*i)),width:1));
		Out.ar(0,PanAz.ar(2,sig2*envd*pr,LFSaw.ar(383/(fund*ii)),width:1));*/
	};
/*	Out.ar(2,PanAz.ar(2,InFeedback.ar(14),LFSaw.ar(383/(fund)),width:2)*envd);
	Out.ar(4,PanAz.ar(2,InFeedback.ar(15),LFSaw.ar(383/(fund)),width:2)*envd);
	Out.ar(6,PanAz.ar(2,InFeedback.ar(16),LFSaw.ar(383/(fund)),width:2)*envd);
	Out.ar(8,PanAz.ar(2,InFeedback.ar(17),LFSaw.ar(383/(fund)),width:2)*envd);
	Out.ar(10,PanAz.ar(2,InFeedback.ar(18),LFSaw.ar(383/(fund)),width:2)*envd);
	Out.ar(12,PanAz.ar(2,InFeedback.ar(19),LFSaw.ar(383/(fund)),width:2)*envd);

	audio1= InFeedback.ar(2)+InFeedback.ar(5)+InFeedback.ar(6)+InFeedback.ar(9)+InFeedback.ar(11)+InFeedback.ar(12);
	audio2= InFeedback.ar(3)+InFeedback.ar(4)+InFeedback.ar(7)+InFeedback.ar(8)+InFeedback.ar(10)+InFeedback.ar(13);

		Out.ar(0,audio1*envd);
		Out.ar(1,audio2*envd);*/
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
	\y,Pbrown(0,1,1,inf),
	\pr,Pexprand(0.01,0.06,inf);
)).play(quant:1));

)




s.options.device_("USB Sound Device");
s.options.numOutputBusChannels=4
TempoClock.default.tempo_(120/120);
s.options.memSize = 65536;
s.options.numInputBusChannels=0;
s.record(numChannels:12) ;