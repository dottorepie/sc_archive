TempoClock.default.tempo_(120/60);
s.options.numOutputBusChannels=8;
TempoClock.default.tempo_(120/12);
);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000

s.options.device_("USB Sound Device");
s.options.memSize = 65536;
s.options.memSize
s.options.numInputBusChannels=0;
s.record(numChannels:6) ;
s.options.memSize = 2097152
(
/////////////////////



(
SynthDef.new(\id, {
	arg dur=1;
	var b=1,x=1,bus=1; var y=1,t,phi; var k,z,pos; var sig,env,s;

	x=dur.cos; y=pow.sin;
	k=Complex(x,y).abs; t=Complex(x,y).angle;
	z=(t+k)/(t);
	s= Complex(k,z).abs; phi= Complex(z,k).angle;
	r=(phi+s)/phi;
	dur=dur.sin;
	o=Complex(dur,r).angle;
	a=Complex(dur,r).abs;
	//env=EnvGen.ar(Env.perc(0.01,dur/dur,1/s,[-4,-4]),doneAction:2);
		//sig=PitchShift.ar(SoundIn.ar(0),0.2,pitchRatio:s.linlin(0,4,0,4),mul:1/s);
	//sig=FSinOsc.ar(phi*880,mul:1/s,iphase:t*pi);
	Out.ar(0,PanAz.ar(8,sig*0.2,o,width:a));
	//Out.ar(0,PanAz.ar(2,LeakDC.ar(sig),SinOsc.ar(phi),width:2));
	//	Out.ar(8,PanAz.ar(4,LeakDC.ar(sig*env*3),theta.linlin(1,2,-1,1),width:2));
	//Out.ar(0,PanAz.ar(4,InFeedback.ar(8)*env,phi.linlin(0.3,0.5,-1,1),width:2));
//	Out.ar(4,PanAz.ar(4,InFeedback.ar(9)*env,phi.linlin(0.3,0.5,-1,1),width:2));

}).add;
)



(
(Synth.new(\id,[\dur,6,\pow,9]));
(Synth.new(\id,[\dur,8]));
(Synth.new(\id,[\dur,9]));
(Synth.new(\id,[\dur,12]));
(Synth.new(\id,[\dur,16]));
(Synth.new(\id,[\dur,18]));
(Synth.new(\id,[\dur,24]));
(Synth.new(\id,[\dur,32]));
(Synth.new(\id,[\dur,36]));

)
/////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////on pattern


(
SynthDef.new(\id, {
	arg dur,pow=0;
	var x=1,y=1,t,phi; var k,z,pos; var sig,env,s;
	var r,o,a,sum;

dur=dur*pow;
	x=dur.cos; y=dur.sin;
	k=Complex(x,y).abs; t=Complex(x,y).angle;
	z=(t+k)/(t);
	s= Complex(k,z).abs;phi= Complex(k,z).angle;
	r=(phi+s)/phi;
	dur=dur.sin;
	o=Complex(dur,r).angle;
	a=Complex(dur,r).abs;
	env=EnvGen.ar(Env.perc(0.01,2,1/a,[-4,-2]),doneAction:2);
//sig=PitchShift.ar(SoundIn.ar(0),1,pitchRatio:phi,mul:env);
	//sig=PitchShift.ar(InFeedback.ar(2),0.5,pitchRatio:s,mul:env);
	sig=FSinOsc.ar(a*220,mul:env,iphase:a*pi);
	//sig=Blip.ar((o*220),mul:env,numharm:o);
	//Out.ar(0,sig*env);
	Out.ar(0,PanAz.ar(8,sig*env,a,width:2));

}).add;
)


( Pdef(\1, Pbind(\instrument, \id,
			\dur,1,
			//\pow,Pseries(1,9/8,30);
		\pow,Pbrown(1,100,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
			)).play(quant:1))



Tdef(\sa).play;
Tdef(\sa).stop;

(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \id,
		\dur,Pbrown(1,24,9/8,inf),
			//\dur,Pseries(1,2,30);
		\pow,Pbrown(1,24,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
		)).play(quant:1))})

						 1.do({( Pdef(\2, Pbind(\instrument, \id,
			\dur,Pbrown(1,24,9/8,inf),
			//\dur,Pseries(1,2,30);
		\pow,Pbrown(1,24,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
		)).play(quant:1))})

								 1.do({( Pdef(\3, Pbind(\instrument, \id,
		\dur,Pbrown(1,24,9/8,inf),
			//\dur,Pseries(1,2,30);
		\pow,Pbrown(1,24,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
		)).play(quant:1))})


			})
)
////////////////////////////////////////////////////////////////////////////////////////////////////////spat
///////////////////////////////////////////////////////////////////////////////////////////////

	(	(
SynthDef.new(\a, {
	arg dur,pow=0;var x=1,y=1,t,phi; var k,z,pos; var sig,env,s;var r,o,a,sum;
   dur=dur*pow; x=dur.cos; y=dur.sin;k=Complex(x,y).abs; t=Complex(x,y).angle;z=(t+k)/(t);
	s= Complex(k,z).abs;phi= Complex(k,z).angle;r=(phi+s)/phi;dur=dur.sin;
	o=Complex(dur,r).angle;a=Complex(dur,r).abs;
	env=EnvGen.ar(Env.perc(0.01,2,1/a,[-4,-2]),doneAction:2);
	//sig=FSinOsc.ar(o*220,mul:env,iphase:o*pi);
	//sig=Blip.ar((o*220),mul:env,numharm:o);
	sig=BLowPass.ar(VarSaw.ar(o*220,width:a,mul:env),440);
	//Out.ar(0,sig*env);
	Out.ar(0,PanAz.ar(2,sig*env,a,width:o));
}).add;
);
		(
SynthDef.new(\b, {
	arg dur,pow=0;var x=1,y=1,t,phi; var k,z,pos; var sig,env,s;var r,o,a,sum;
   dur=dur*pow; x=dur.cos; y=dur.sin;k=Complex(x,y).abs; t=Complex(x,y).angle;z=(t+k)/(t);
	s= Complex(k,z).abs;phi= Complex(k,z).angle;r=(phi+s)/phi;dur=dur.sin;
	o=Complex(dur,r).angle;a=Complex(dur,r).abs;
	env=EnvGen.ar(Env.perc(0.01,2,1/a,[-4,-2]),doneAction:2);
	//sig=FSinOsc.ar(o*220,mul:env,iphase:o*pi);
	//sig=Blip.ar((o*220),mul:env,numharm:o);
	sig=BLowPass.ar(VarSaw.ar(o*440,width:a,mul:env),440);
	//Out.ar(0,sig*env);
	Out.ar(0,PanAz.ar(2,sig*env*1/2,a,width:o));
}).add;
		))

Tdef(\sa).play;
Tdef(\sa).stop;

(
Tdef(\sa,
      {
				 1.do({( Pdef(\1, Pbind(\instrument, \a,
		\dur,Pbrown(1,24,9/8,inf),
			//\dur,Pseries(1,2,30);
		\pow,Pbrown(1,24,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
		)).play(quant:1))});

						 1.do({( Pdef(\2, Pbind(\instrument, \b,
			\dur,Pbrown(1,24,9/8,inf),
			//\dur,Pseries(1,2,30);
		\pow,Pbrown(1,24,9/8,inf),
			//\pow,Pgauss(15,15,inf),
			//\pow,Pcauchy(15,5,inf),
			//\pow,Pwhite(1,30,inf);
		)).play(quant:1))})



			})
)