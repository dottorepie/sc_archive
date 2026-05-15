{SinOsc.ar(1,mul:360).poll}.play
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*16;
s.options.blockSize = 64/4;
s.waitForBoot
)

(
{
	var detune2,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576)),osc1,osc2,freq1=100;

1000.do{

		detune2=exp(Complex(0,1)*(angle1.degrad));

		osc1=SinOsc.ar((freq1*1.reciprocal),mul:1,phase:detune2.real.linlin(1.neg,1,2pi.neg,2pi));
		osc2=SinOsc.ar((freq1*1.reciprocal),mul:1,phase:detune2.imag.linlin(1.neg,1,2pi.neg,2pi));


angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

			Out.ar(0,osc1);
		Out.ar(1,osc2);
	};
}.play
)



(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(220,SinOsc.ar(0.0220,0.degrad,360).degrad),SinOsc.ar(0.220,0.degrad)))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(220,SinOsc.ar(0.0220,90.degrad,360).degrad),SinOsc.ar(0.220,90.degrad)))}.play;
)
(
//var detune;

//detune=exp(Complex(0,1)*(SinOsc.kr(0.1,mul:pi)));

{Out.ar(0,PanAz.ar(2,
SinOsc.ar(220,exp(Complex(0,1)*(SinOsc.ar(0.1,mul:pi))).real.linlin(1.neg,1,2pi.neg,2pi)),LFSaw.ar(0.1,exp(Complex(0,1)*(SinOsc.ar(0.1,mul:1))).real)))}.play;
{Out.ar(0,PanAz.ar(2,
SinOsc.ar(220,exp(Complex(0,1)*(SinOsc.ar(0.1,mul:pi))).imag.linlin(1.neg,1,2pi.neg,2pi)),LFSaw.ar(0.1,exp(Complex(0,1)*(SinOsc.ar(0.1,mul:1))).imag)))}.play;
)

(
{Out.ar(0,SinOsc.ar(100,LFSaw.ar(0.022,0,2pi)))}.play;
{Out.ar(1,SinOsc.ar(100,LFSaw.ar(0.022,0.5,2pi)))}.play;
)

//
(
{Out.ar(0,SinOsc.ar(220,SinOsc.kr(0.022,SinOsc.kr(0.022,0.degrad,360).abs.degrad,360).abs.degrad))}.play;
{Out.ar(1,SinOsc.ar(220,SinOsc.kr(0.022,SinOsc.kr(0.022,90.degrad,360).abs.degrad,360).abs.degrad))}.play;
)

{WhiteNoise.ar(1).abs.poll}.play

{Out.ar(0,Pan2.ar(SinOsc.ar(220),SinOsc.ar(1,180.degrad)))}.play;


exp(Complex(0,1)*0.degrad).real.linlin(1.neg,1,360.neg,360)



(
{
var freqs, audiox,audioy,audioj,audiok, amp, m=0, fund=100, phasex,phasey,phasej,phasek,anglex=0,angley=0,anglej=90,anglek=90,x=0,y=0,j=0,k=0;

	freqs = 100.collect{m=m+1};
    amp  = freqs.reciprocal;
	phasex = 100.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
		x=x.real.round(0.00001);
	};
	phasey = 100.collect{
		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
		y=y.imag.round(0.00001);
	};
	phasej = 100.collect{
		anglej=(anglej+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		j=exp(Complex(0,1)*(anglej.degrad));
		j=j.theta;
	};
	phasek = 50.collect{
		anglek=(anglek+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		k=exp(Complex(0,1)*(anglek.degrad));
		k=k.theta;
	};



	audiox = PanAz.ar(2,SinOsc.ar(fund*freqs,SinOsc.ar(0.1,phasex.linlin(1.neg,1,2pi.neg,2pi),360).degrad,mul:amp),LFSaw.ar(0.1,phasex));
	audioy = PanAz.ar(2,SinOsc.ar(fund*freqs,SinOsc.ar(0.1,phasey.linlin(1.neg,1,2pi.neg,2pi),360).degrad,mul:amp),LFSaw.ar(0.1,phasey));

	//audioj = PanAz.ar(2,SinOsc.ar( fund*freqs,90.degrad,mul:amp),LFSaw.ar(1,phasej));
	//audiok = PanAz.ar(2,SinOsc.ar( fund*freqs,90.degrad,mul:amp),LFSaw.ar(1,phasek));

	audiox = Out.ar(0,Mix(LPF.ar(audiox),440));
	audioy = Out.ar(0,Mix(LPF.ar(audioy),440));
	//audioj = Out.ar(0,Mix(LPF.ar(audioj),440));
	//audiok = Out.ar(0,Mix(LPF.ar(audiok),440));


}.play
)




(
{
var freqs, audiox,audioy,audioj,audiok, amp, m=0, fund=20, phasex,phasey,phasej,phasek,anglex=0,angley=0,anglej=90,anglek=90,x=0,y=0,j=0,k=0;

	freqs = 100.collect{m=m+1};
    amp  = freqs.reciprocal;
	phasex = 100.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
		x=x.real.round(0.00001);
	};
	phasey = 100.collect{
		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
		y=y.imag.round(0.00001);
	};


	audiox = PanAz.ar(2,SinOsc.ar(fund*phasex.abs.reciprocal,phasex.linlin(1.neg,1,2pi.neg,2pi),mul:phasex),LFSaw.ar(phasex,phasex));
	audioy = PanAz.ar(2,SinOsc.ar(fund*phasey.abs.reciprocal,phasey.linlin(1.neg,1,2pi.neg,2pi),mul:phasey),LFSaw.ar(phasey,phasey));


	audiox = Out.ar(0,Mix(audiox));
	audioy = Out.ar(0,Mix(audioy));


}.play
)






{ LFSaw.ar(20, [0, 0.5]) }.plot(0.1);
{ SinOsc.ar(20, [0.degrad,-90.degrad]) }.plot(0.1)



// (
// (SynthDef.new(\oa, {
// 	var  n1=1,cutt=240,freqs, audiox,audioy, amp, m=0, fund=220, phasex,phasey,anglex=0,angley=0,x=0,y=0,mfreq;
// 	var osc1,osc2,freq1, bank, pitch1, t=2;
// 	var wrappedOut1 = { |busArray, signalArray|
// 		// magic trick to expand to the larger of the two arrays
// 		[busArray, signalArray].flop.do { |pair|
// 	Out.ar(pair[0], pair[1])}};
// 	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
// 	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
//
// 	bank=100;
// 	mfreq=WhiteNoise.ar(1);
// 	n1=0;
// 	pitch1=2.pow(n1/(2*6));
// 	fund=(((4*t)-1)*((4*t)/2));
// 	freq1 = (fund*6);
// 	freqs = bank.collect{m=m+1};
// 	amp  = freqs.reciprocal;
// 	phasex = bank.collect{
// 		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
// 		x=exp(Complex(0,1)*(anglex.degrad));
// 		x=x.real.round(0.0001);
// 	};
// 	phasey = bank.collect{
// 		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
// 		y=exp(Complex(0,1)*(angley.degrad));
// 		y=y.imag.round(0.0001);
// 	};
//
// 	osc1 = PanAz.ar(2,SinOsc.ar(freq1*freqs*pitch1,0.degrad,mul:amp),LFSaw.ar(1,phasex));
// 	osc2 = PanAz.ar(2,SinOsc.ar(freq1*freqs*pitch1,90.degrad,mul:amp),LFSaw.ar(1,phasey));
//
// 	osc1 = wrappedOut1.value(out, Mix(LPF.ar(LeakDC.ar(osc1),cutt)));
// 	osc2 = wrappedOut1.value(out, Mix(LPF.ar(LeakDC.ar(osc2),cutt)));
//
// }).add;);
//
// )

2.sqrt
(
SynthDef.new(\oe, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m1=1,m2=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=200;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*2);

	bank.do{

		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

		osc1=PanAz.ar(2,SinOsc.ar((freq1*m1)*pitch1,mul:m1.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m2)*pitch1,mul:m2.reciprocal,phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m1=m1+1;
		m2=m2+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

		Out.ar(0,(osc1*MouseX.kr(0.01,1)));
			Out.ar(0,(osc2*MouseX.kr(0.01,1)));
	};
}).add;
(
SynthDef.new(\oe, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=0, angle2=90;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m1=1,m2=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=200;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*2);

	bank.do{

		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi).abs));

		osc1=PanAz.ar(2,SinOsc.ar((freq1*m1)*pitch1,mul:m1.reciprocal,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(0.1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));


			osc2=PanAz.ar(2,SinOsc.ar((freq1*m2)*pitch1,mul:m2.reciprocal,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(0.1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));


m1=m1+1;
		m2=m2+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

		Out.ar(0,(osc1*MouseX.kr(0.01,1)));
			Out.ar(0,(osc2*MouseX.kr(0.01,1)));
	};
}).add;

)

Synth.new(\oe);
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=137.5;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6);

	bank.do{

		detune1=exp(Complex(0,1)*(SinOsc.ar(1,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

		osc1=SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune2.real.linlin(1.neg,1,2pi.neg,2pi));

osc2=SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune2.imag.linlin(1.neg,1,2pi.neg,2pi));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)),cutt));
			Out.ar(1,LPF.ar(LeakDC.ar((osc2)),cutt));
	};
}).add;

)
Synth.new(\oa)
//////////////////////////////

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

	osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)




(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env1,env2,env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:2);
//env=EnvGen.ar(Env.sine(8,pitch1.reciprocal),doneAction:2);

	bank.do{

	detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	//env1=EnvGen.ar(Env.perc(attack,detune2.real.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);
	//env2=EnvGen.ar(Env.perc(attack,detune2.imag.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);

osc1=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune2.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune2.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LeakDC.ar((osc1)*env));
	wrappedOut2.value(out, LeakDC.ar((osc2)*env));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;
)

(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

a.play;


(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=137.5;
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6);

	bank.do{

		detune1=exp(Complex(0,1)*(SinOsc.ar(1,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

		osc1=SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune2.real.linlin(1.neg,1,2pi.neg,2pi));

osc2=SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune2.imag.linlin(1.neg,1,2pi.neg,2pi));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc1*2),cutt));
	//wrappedOut1.value(out, LPF.ar(LeakDC.ar(osc2*2),cutt));

			Out.ar(0,LPF.ar(LeakDC.ar((osc1)),cutt));
			Out.ar(1,LPF.ar(LeakDC.ar((osc2)),cutt));
	};
}).add;

)
Synth.new(\oa)
//////////////////////////////

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env1,env2,env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:2);
//env=EnvGen.ar(Env.sine(8,pitch1.reciprocal),doneAction:2);

	bank.do{

	detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	//env1=EnvGen.ar(Env.perc(attack,detune2.real.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);
	//env2=EnvGen.ar(Env.perc(attack,detune2.imag.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);

osc1=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LeakDC.ar((osc1)*env));
	wrappedOut2.value(out, LeakDC.ar((osc2)*env));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env1,env2,env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:3/4);
//env=EnvGen.ar(Env.sine(8,pitch1.reciprocal),doneAction:2);

	bank.do{

	detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	//env1=EnvGen.ar(Env.perc(attack,detune2.real.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);
	//env2=EnvGen.ar(Env.perc(attack,detune2.imag.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);

osc1=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LeakDC.ar((osc1)*env));
	wrappedOut2.value(out, LeakDC.ar((osc2)*env));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env1,env2,env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:2/3);
//env=EnvGen.ar(Env.sine(8,pitch1.reciprocal),doneAction:2);

	bank.do{

	detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	//env1=EnvGen.ar(Env.perc(attack,detune2.real.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);
	//env2=EnvGen.ar(Env.perc(attack,detune2.imag.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);

osc1=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LeakDC.ar((osc1)*env));
	wrappedOut2.value(out, LeakDC.ar((osc2)*env));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env1,env2,env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(8,pitch1.reciprocal),doneAction:2);

	bank.do{

	detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	//env1=EnvGen.ar(Env.perc(attack,detune2.real.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);
	//env2=EnvGen.ar(Env.perc(attack,detune2.imag.linlin(1.neg,1,8.neg,8).abs,1),doneAction:0,levelScale:1);

osc1=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*1.reciprocal)*pitch1,mul:1,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LeakDC.ar((osc1)*env));
	wrappedOut2.value(out, LeakDC.ar((osc2)*env));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;
)




(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pbrown(1/2,1,1/8,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)
//////////////////////////////////////////////////////




(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

		osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

		osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.imag.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)


(
var  anglex=0,angley=0,x=0,y=0;


	~phasex = 10000.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.theta
	};

~phasey = 10000.collect{
		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
	y=y.imag
	};


)





Server.killAll
(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)

















(
SynthDef.new(\oa, {
	arg  n1=1, cutt=20000,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,env1,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2)*pitch1;

env=EnvGen.ar(Env.perc(attack,2pi,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(2pi,pitch1.reciprocal),doneAction:2,levelScale:1);

	bank.do{

//env1=EnvGen.ar(Env.perc(attack,2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);
env1=EnvGen.ar(Env.sine(2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

		osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

		osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=20000,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,env1,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2)*pitch1;

env=EnvGen.ar(Env.perc(attack,2pi,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(2pi,pitch1.reciprocal),doneAction:2,levelScale:1);

	bank.do{

env1=EnvGen.ar(Env.perc(attack,2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);
//env1=EnvGen.ar(Env.sine(2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=20000,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,env1,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2)*pitch1;


env=EnvGen.ar(Env.perc(attack,2pi,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(2pi,pitch1.reciprocal),doneAction:2,levelScale:1);

	bank.do{

env1=EnvGen.ar(Env.perc(attack,2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);
//env1=EnvGen.ar(Env.sine(2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);

		detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=20000,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,env1,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2)*pitch1;

env=EnvGen.ar(Env.perc(attack,2pi,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(2pi,pitch1.reciprocal),doneAction:2,levelScale:1);

	bank.do{

env1=EnvGen.ar(Env.perc(attack,2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);
//env1=EnvGen.ar(Env.sine(2pi*m.reciprocal,pitch1.reciprocal),levelScale:1);

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,detune1.real.linlin(1.neg,1,2pi.neg,2pi),2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*env1*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)


(
var  anglex=0,angley=0,x=0,y=0;


	~phasex = 10000.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.theta
	};


)

Server.killAll
(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	//\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)






















/////////////////////////////////////////////////////

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));
	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));
	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));

	osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.real.round(0.0001)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(0.1,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));

			//Out.ar(0,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
			//Out.ar(0,LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

)

Server.killAll
(
var  anglex=0,angley=0,x=0,y=0;
var angle1=90,x1=0,angle2=90,x2=0,angle3=180,x3=0,angle4=270,x4=0;


	~phasex = 1000.collect{
		anglex=(anglex+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
		x=x.real.round(0.00001);
	};
	~phasey = 1000.collect{
		angley=(angley+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
		y=y.imag.round(0.00001);
	};

	~phase1 = 1000.collect{
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x1=exp(Complex(0,1)*(angle1.degrad));
	   //  x1=x1.theta
	x1=x1.real.round(0.00001);
	};
	~phase2 = 1000.collect{
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x2=exp(Complex(0,1)*(angle2.degrad));
	     //x2=x2.theta
	x2=x2.imag.round(0.00001);
	};

	~phase3 = 1000.collect{
		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x3=exp(Complex(0,1)*(angle3.degrad));
	     x3=x3.theta
	};
	~phase4 = 1000.collect{
		angle4=(angle4+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x4=exp(Complex(0,1)*(angle4.degrad));
	     x4=x4.theta
	};

)

Server.killAll
(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phasey.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,Prand([
0,5,7,12,17,19,24],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
)
//////////////////////////////////////////////
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
		//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{


detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));

m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));

	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1, detune2,osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));



m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
		//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));

m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

SynthDef.new(\oaa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
		//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));

	};
}).add;

SynthDef.new(\obb, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
		//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

	};
}).add;

SynthDef.new(\occ, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
		//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));


	};
}).add;
SynthDef.new(\odd, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	//fund=(((4*t)-1)*((4*t)/2));
	fund=55;
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:m.reciprocal,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));


	};
}).add;

)

Server.killAll
(
var  anglex=0,angley=0,x=0,y=0;
var angle1=0,x1=0,angle2=90,x2=0,angle3=180,x3=0,angle4=270,x4=0;


	~phase1 = 1000.collect{
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x1=exp(Complex(0,1)*(angle1.degrad));
	   //  x1=x1.theta
	x1=x1.real.round(0.00001);
	};

    ~phase1y = 1000.collect{
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x1=exp(Complex(0,1)*(angle1.degrad));
	   //  x1=x1.theta
	x1=x1.imag.round(0.00001);
	};
	~phase2 = 1000.collect{
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x2=exp(Complex(0,1)*(angle2.degrad));
	     //x2=x2.theta
	x2=x2.real.round(0.00001);
	};

	~phase2y = 1000.collect{
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x2=exp(Complex(0,1)*(angle2.degrad));
	     //x2=x2.theta
	x2=x2.imag.round(0.00001);
	};
	~phase3 = 1000.collect{
		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x3=exp(Complex(0,1)*(angle3.degrad));
	     x3=x3.real.round(0.00001);
};

	~phase3y = 1000.collect{
		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x3=exp(Complex(0,1)*(angle3.degrad));
	     x3=x3.real.round(0.00001);
	};
	~phase4 = 1000.collect{
		angle4=(angle4+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x4=exp(Complex(0,1)*(angle4.degrad));
	     x4=x4.real.round(0.00001);
	};

	~phase4y = 1000.collect{
		angle4=(angle4+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x4=exp(Complex(0,1)*(angle4.degrad));
	     x4=x4.imag.round(0.00001);
	};

)
~phase1.linlin(1.neg,1,12.neg,12).round(1).postln

Server.killAll
(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
	\n1,Pseq(~phase1.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase1.linlin(1.neg,1,6.neg,6).abs,inf);
));
b=Pdef(\2, Pbind(\instrument, \oaa,
	//\dur,1/2,
	\dur,Pseq(~phase1y.abs,inf),
\n1,Pseq(~phase1y.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase1y.linlin(1.neg,1,6.neg,6).abs,inf);
));
c=Pdef(\3, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~phase2.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase2.linlin(1.neg,1,6.neg,6).abs,inf);
));
d=Pdef(\4, Pbind(\instrument, \obb,
	//\dur,1/2,
	\dur,Pseq(~phase2y.abs,inf),
\n1,Pseq(~phase2y.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase2y.linlin(1.neg,1,6.neg,6).round(1).abs,inf);
));
e=Pdef(\5, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~phase3.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase3.linlin(1.neg,1,6.neg,6).abs,inf);
));
f=Pdef(\6, Pbind(\instrument, \occ,
	//\dur,1/2,
	\dur,Pseq(~phase3y.abs,inf),
\n1,Pseq(~phase3y.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase3y.linlin(1.neg,1,6.neg,6).abs,inf);
));
g=Pdef(\7, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~phase4.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase4.linlin(1.neg,1,6.neg,6).abs,inf);
));
k=Pdef(\8, Pbind(\instrument, \odd,
	//\dur,1/2,
	\dur,Pseq(~phase4y.abs,inf),
\n1,Pseq(~phase4y.linlin(1.neg,1,12.neg,12).round(1),inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pseq(~phase4y.linlin(1.neg,1,6.neg,6).abs,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
e.play;
f.play;
g.play;
k.play;
)

//////////////////////////////////////////////

(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc1=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));

m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));

	};
}).add;

SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc1=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));
	};
}).add;

SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc1=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));



m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));

	};
}).add;

SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
	var wrappedOut1 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

	osc1=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.real.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.real,detune1.real.round(0.0001)));

m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));
	};
}).add;

SynthDef.new(\oaa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc2=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2).abs),cutt));

	};
}).add;

SynthDef.new(\obb, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*8)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc2=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,3/4).abs),cutt));

	};
}).add;

SynthDef.new(\occ, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*9)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));


osc2=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,2/3).abs),cutt));


	};
}).add;

SynthDef.new(\odd, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.01,angle1=(360-(360/1.61803398874989484820458683436563811772030917980576));
	var tf, detune1,detune2, osc1,osc2;
	var freq1, env,m=1,bank, pitch1, fund;
		var wrappedOut2 = { |busArray, signalArray|
	// magic trick to expand to the larger of the two arrays
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])
	}
};
	var out2 = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	//var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!
	bank=13;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*12)+WhiteNoise.ar(2);

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(m.reciprocal,angle1.degrad,2pi).abs));
		detune2=exp(Complex(0,1)*(angle1.degrad));

osc2=PanAz.ar(2,SinOsc.ar((freq1*detune2.abs.reciprocal)*pitch1,mul:detune2.abs,phase:detune1.imag.linlin(1.neg,1,2pi.neg,2pi)), LFSaw.ar(detune2.imag,detune1.imag.round(0.0001)));


m=m+1;
angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env*LFNoise2.ar(WhiteNoise.ar(2).abs,1).abs),cutt));


	};
}).add;

)

Server.killAll
(
var  anglex=0,angley=0,x=0,y=0;
var angle1=(360-(360/1.61803398874989484820458683436563811772030917980576)),x1=0,angle2=90,x2=0,angle3=180,x3=0,angle4=270,x4=0;


	~phase1 = 1000.collect{
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x1=exp(Complex(0,1)*(angle1.degrad));
	   //  x1=x1.theta
	x1=x1.real.round(0.00001);
	};

    ~phase1y = 1000.collect{
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x1=exp(Complex(0,1)*(angle1.degrad));
	   //  x1=x1.theta
	x1=x1.imag.round(0.00001);
	};
	~phase2 = 1000.collect{
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x2=exp(Complex(0,1)*(angle2.degrad));
	     //x2=x2.theta
	x2=x2.real.round(0.00001);
	};

	~phase2y = 1000.collect{
		angle2=(angle2+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x2=exp(Complex(0,1)*(angle2.degrad));
	     //x2=x2.theta
	x2=x2.imag.round(0.00001);
	};
	~phase3 = 1000.collect{
		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x3=exp(Complex(0,1)*(angle3.degrad));
	     x3=x3.real.round(0.00001);
};

	~phase3y = 1000.collect{
		angle3=(angle3+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x3=exp(Complex(0,1)*(angle3.degrad));
	     x3=x3.real.round(0.00001);
	};
	~phase4 = 1000.collect{
		angle4=(angle4+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x4=exp(Complex(0,1)*(angle4.degrad));
	     x4=x4.real.round(0.00001);
	};

	~phase4y = 1000.collect{
		angle4=(angle4+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
		x4=exp(Complex(0,1)*(angle4.degrad));
	     x4=x4.imag.round(0.00001);
	};

)

Server.killAll
(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \oaa,
	//\dur,1/2,
	\dur,Pseq(~phase1y.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \obb,
	//\dur,1/2,
	\dur,Pseq(~phase2y.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
e=Pdef(\5, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\6, Pbind(\instrument, \occ,
	//\dur,1/2,
	\dur,Pseq(~phase3y.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\7, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
k=Pdef(\8, Pbind(\instrument, \odd,
	//\dur,1/2,
	\dur,Pseq(~phase4y.abs,inf),
\n1,Prand([
0,5,7,12],inf),

	\cutt,Pbrown(220*2,220*8,100,inf),
	\out2,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
		//\attack,Pbrown(0.01,0.5,0.1,inf),
	//\angle1,Pexprand(0.0001,360,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
a.play;
b.play;
c.play;
d.play;
e.play;
f.play;
g.play;
k.play;
)