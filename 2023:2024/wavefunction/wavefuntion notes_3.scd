
(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
s.options.blockSize = 16;
s.options.maxLogins = 32;
s.waitForBoot
)

(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,r;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
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

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,r;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
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

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*8)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:3/2);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,r;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
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

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*9)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:4/3);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;
	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	};

}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,r;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
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

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));


	};
}).add;
);
)





(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

v1=Quaternion(0,1,2,3);
v2=Quaternion(0,1,2,3);
v3=Quaternion(0,1,2,3);
v4=Quaternion(0,1,2,3);


	~phase1 = 10000.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));
	v1=q1*v1;
	ph1=v1.a;
	ph1=2.pow(ph1/(2*6));
	};
~phase2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b;
	ph2=2.pow(ph2/(2*6));
	};

~phase3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c;
	ph3=2.pow(ph3/(2*6));
	};

~phase4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d;
	ph4=2.pow(ph4/(2*6));
	};

)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

v1=Quaternion(0,5,7,12);
v2=Quaternion(0,5,7,12);
v3=Quaternion(0,5,7,12);
v4=Quaternion(0,5,7,12);


	~n1 = 10000.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));
	v1=q1*v1;
	ph1=v1.a.round(1);
	};
~n2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b.round(1);
	};

~n3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c.round(1);
	};

~n4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d.round(1);
	};

)
(
~n1=~n1*(2);
~n2=~n2*(2);
~n3=~n3*(2);
~n4=~n4*(2);
)

(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1,inf),
\n1,Pseq(~n1,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(1.neg,1,0.1,inf),
	\y,Pbrown(1.neg,1,0.1,inf),
	\z,Pbrown(1.neg,1,0.1,inf),
	\rx,Pbrown(1.neg,1,0.1,inf),
	\ry,Pbrown(1.neg,1,0.1,inf),
	\rz,Pbrown(1.neg,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2,inf),
\n1,Pseq(~n2,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

\x,Pbrown(1.neg,1,0.1,inf),
	\y,Pbrown(1.neg,1,0.1,inf),
	\z,Pbrown(1.neg,1,0.1,inf),
	\rx,Pbrown(1.neg,1,0.1,inf),
	\ry,Pbrown(1.neg,1,0.1,inf),
	\rz,Pbrown(1.neg,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3,inf),
\n1,Pseq(~n3,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
\x,Pbrown(1.neg,1,0.1,inf),
	\y,Pbrown(1.neg,1,0.1,inf),
	\z,Pbrown(1.neg,1,0.1,inf),
	\rx,Pbrown(1.neg,1,0.1,inf),
	\ry,Pbrown(1.neg,1,0.1,inf),
	\rz,Pbrown(1.neg,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4,inf),
\n1,Pseq(~n4,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

	\x,Pbrown(1.neg,1,0.1,inf),
	\y,Pbrown(1.neg,1,0.1,inf),
	\z,Pbrown(1.neg,1,0.1,inf),
	\rx,Pbrown(1.neg,1,0.1,inf),
	\ry,Pbrown(1.neg,1,0.1,inf),
	\rz,Pbrown(1.neg,1,0.1,inf),
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
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,r;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,osc3_x,osc3_y,osc3_z;
	var spacex,timex,spacey,timey,spacez,timez,nx,ny,nz,nix,niy,niz;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut3 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1,2,3]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=32;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

//env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

		spacex=exp(Complex(0,1)*ph_v1_x).real;
		timex=exp(Complex(0,1)*ph_v1_x).imag;
		spacey=exp(Complex(0,1)*ph_v1_y).real;
		timey=exp(Complex(0,1)*ph_v1_y).imag;
		spacez=exp(Complex(0,1)*ph_v1_z).real;
		timez=exp(Complex(0,1)*ph_v1_z).imag;

		nx=2.pow(timex/(2*6));
		ny=2.pow(timey/(2*6));
		nz=2.pow(timez/(2*6));

		nix=2.pow(spacex/(2*6));
		niy=2.pow(spacey/(2*6));
		niz=2.pow(spacez/(2*6));

osc1_x=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),spacex,spacey);

osc1_y=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),spacex,spacey);

osc1_z=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),spacex,spacey);


m=m+1;

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)),cutt));

	};
}).add;
)

Synth.new(\oa)

a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,Pseq(~n1,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(1.neg,1,0.1,inf),
	\y,Pbrown(1.neg,1,0.1,inf),
	\z,Pbrown(1.neg,1,0.1,inf),
	\rx,Pbrown(1.neg,1,0.1,inf),
	\ry,Pbrown(1.neg,1,0.1,inf),
	\rz,Pbrown(1.neg,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));

a.play;