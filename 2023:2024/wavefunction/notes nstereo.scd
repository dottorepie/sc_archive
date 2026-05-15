(
s.options.numWireBufs = 1024*32;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=240,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p,ang=(360-(360/1.6180339887499));
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	v1=q*v1*q.conjugate;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d);



m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=240,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p,ang=(360-(360/1.6180339887499));
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	v1=q*v1*q.conjugate;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d);



m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=240,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p,ang=(360-(360/1.6180339887499));
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	v1=q*v1*q.conjugate;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d);



m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=240,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1,ng1=1,ng2=1,ng3=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p,ang=(360-(360/1.6180339887499));
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt*ng1,p.[1].sqrt*ng2,p.[2].sqrt*ng3);

	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(ang.degrad/2)+(sin(ang.degrad/2)*(i+j+k)));

	v1=q*v1*q.conjugate;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d);



m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=4;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);


	~phase1 = 10000.collect{
		angle1=((360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(0.25);
	//ph1=2.pow(ph1/(2*6));
	};
~phase2 = 10000.collect{
		angle2=((360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(0.25);
	//ph2=2.pow(ph2/(2*6));
	};

~phase3 = 10000.collect{
		angle3=((360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(0.25);
	//ph3=2.pow(ph3/(2*6));
	};

~phase4 = 10000.collect{
		angle4=((360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(0.25);
	//ph4=2.pow(ph4/(2*6));
	};

)


(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=12;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),n1,n2,n3,n4;

r=[1/2,2/3,3/4].normalizeSum;

v1=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v2=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt.neg,r.[1].sqrt,r.[2].sqrt);


	~n1 = 10000.collect{
		angle1=((360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad/2)+(sin(angle1.degrad/2)*(i+j+k)));
	v1=q1*v1*q1.conjugate;
	ph1=(v1.a*m).round(1);
	};
~n2 = 10000.collect{
		angle2=((360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad/2)+(sin(angle2.degrad/2)*(i+j+k)));
	v2=q2*v2*q2.conjugate;
	ph2=(v2.b*m).round(1);
	};

~n3 = 10000.collect{
		angle3=((360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad/2)+(sin(angle3.degrad/2)*(i+j+k)));
	v3=q3*v3*q3.conjugate;
	ph3=(v3.c*m).round(1);
	//ph3=v3.c*BufFrames.kr(~scale);
	//n3=DegreeToKey.kr(~scale,ph3);
	};

~n4 = 10000.collect{
		angle4=((360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad/2)+(sin(angle4.degrad/2)*(i+j+k)));
	v4=q4*v4*q4.conjugate;
	ph4=(v4.d*m).round(1);
	//n4=DegreeToKey.kr(~scale,ph4);
	};

)


(
~n1=~n1*(2);
~n2=~n2*(2);
~n3=~n3*(2);
~n4=~n4*(2);
)
Scale.directory

(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,PdegreeToKey(Pseq(~n1,1),Scale.ionian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,4,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,PdegreeToKey(Pseq(~n2,1),Scale.ionian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,PdegreeToKey(Pseq(~n3,1),Scale.ionian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,PdegreeToKey(Pseq(~n4,1),Scale.ionian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\ng1,Prand([1.neg,1,1.neg,1],inf),
	\ng2,Prand([1.neg,1,1.neg,1],inf),
	\ng3,Prand([1.neg,1,1.neg,1],inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
a.play;
b.play;
c.play;
d.play;

)
