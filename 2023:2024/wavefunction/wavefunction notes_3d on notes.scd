(
s.options.numWireBufs = 1024*32;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)



(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z,r,cc;

r=[0,0,1].normalizeSum;
10.do{
	angle=(angle+(360/4)).wrap(0,360);
	angle.postln;
 	q1=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
	v1=q1*v1;
 	v1.coordinates.round(0.0001).postln;
	//v1.b.postln;
	ph1x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph1y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph1z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	//ph1x.postln;
	//ph1y.postln;
	//ph1z.postln;
	//cc=Cartesian(v1.b,v1.c,v1.d);
	//cc.phi.postln;
 }

)
90.degrad
[1,0.5,0.8].normalizeSum
(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
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
	var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outx = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [2, 3]);
	var outz = NamedControl.kr(\out3, [4, 5]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;

osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)),v1.d);

osc2_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)),v2.b);

osc2_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)),v2.c);

osc2_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)),v2.d);


m=m+1;

	wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	wrappedOut4.value(outx,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	wrappedOut5.value(outy, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	wrappedOut6.value(outz, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
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
	var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outx = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [2, 3]);
	var outz = NamedControl.kr(\out3, [4, 5]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;

osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)),v1.d);

osc2_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)),v2.b);

osc2_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)),v2.c);

osc2_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)),v2.d);


m=m+1;

	wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	wrappedOut4.value(outx,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	wrappedOut5.value(outy, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	wrappedOut6.value(outz, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
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
	var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outx = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [2, 3]);
	var outz = NamedControl.kr(\out3, [4, 5]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;

osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)),v1.d);

osc2_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)),v2.b);

osc2_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)),v2.c);

osc2_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)),v2.d);


m=m+1;

	wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	wrappedOut4.value(outx,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	wrappedOut5.value(outy, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	wrappedOut6.value(outz, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
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
	var wrappedOut4 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut5 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut6 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outx = NamedControl.kr(\out1, [0, 1]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [2, 3]);
	var outz = NamedControl.kr(\out3, [4, 5]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;

osc1_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.b);

osc1_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.c);

osc1_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)),v1.d);

osc2_x=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)),v2.b);

osc2_y=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)),v2.c);

osc2_z=Pan2.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)),v2.d);


m=m+1;

	wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	wrappedOut4.value(outx,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	wrappedOut5.value(outy, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	wrappedOut6.value(outz, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));

	};
}).add;
);
)


(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=4;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[1,2,3].normalizeSum;

v1=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v2=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v3=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v4=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);


	~phase1 = 10000.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));
	v1=q1*v1;
	ph1=v1.a;
	//ph1=2.pow(ph1/(2*6));
	};
~phase2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b;
	//ph2=2.pow(ph2/(2*6));
	};

~phase3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c;
	//ph3=2.pow(ph3/(2*6));
	};

~phase4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d;
	//ph4=2.pow(ph4/(2*6));
	};

)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=24;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[5,7,12].normalizeSum;

v1=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v2=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v3=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v4=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);


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
	\dur,Pseq(~phase1.abs,inf),
\n1,Pseq(~n1,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\out2,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
		\out3,Pn(Pshuf([4, 5], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~n2,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\out2,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
		\out3,Pn(Pshuf([4, 5], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~n3,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\out2,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
		\out3,Pn(Pshuf([4, 5], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out1,Pn(Pshuf([0, 1], 1), inf).clump(2).collect([_]),
		\out2,Pn(Pshuf([2, 3], 1), inf).clump(2).collect([_]),
		\out3,Pn(Pshuf([4, 5], 1), inf).clump(2).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
a.play;
b.play;
c.play;
d.play;

)


////cube


(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out1 = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [4,5,6,7]);
	//var out2 = NamedControl.kr(\out2, [8,9,10,11]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;

		// ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
		// ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
		// ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
		//
		// ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
		// ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
		// ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;


osc1=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.d,v1.b);

osc2=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d,v1.c);

//osc3=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.b,v1.c);

m=m+1;

	wrappedOut1.value(out1,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out2, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out1 = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [4,5,6,7]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.d,v1.b);

osc2=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d,v1.c);


m=m+1;

	wrappedOut1.value(out1,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out2, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out1 = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [4,5,6,7]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.d,v1.b);

osc2=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d,v1.c);


m=m+1;

	wrappedOut1.value(out1,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out2, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z;
	var osc1,osc2,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out1 = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var out2 = NamedControl.kr(\out2, [4,5,6,7]);

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;
	v1=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	v2=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:2*0.1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));

	v1=q*v1;
	v2=q1*v2;

	ph_v1_x=exp(Complex(0,1)*(angle.degrad)).phase;
	ph_v1_y=exp(Complex(0,1)*(angle1.degrad)).phase;


osc1=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)),v1.d,v1.b);

osc2=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)),v1.d,v1.c);


m=m+1;

	wrappedOut1.value(out1,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out2, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;
);
)


(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=4;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[1,2,3].normalizeSum;

v1=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v2=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v3=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v4=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);


	~phase1 = 10000.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
		q1=(cos(angle1.degrad)+(sin(angle1.degrad)*(i+j+k)));
	v1=q1*v1;
	ph1=v1.a;
	//ph1=2.pow(ph1/(2*6));
	};
~phase2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b;
	//ph2=2.pow(ph2/(2*6));
	};

~phase3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c;
	//ph3=2.pow(ph3/(2*6));
	};

~phase4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d;
	//ph4=2.pow(ph4/(2*6));
	};

)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,q1,q2,q3,q4,v1,v2,v3,v4,ph1,ph2,ph3,ph4,r,m=12;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt);

r=[5,7,12].normalizeSum;

v1=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v2=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v3=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);
v4=Quaternion(0,r.[0].sqrt*m,r.[1].sqrt*m,r.[2].sqrt*m);


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
	\dur,Pseq(~phase1.abs,inf),
\n1,Pseq(~n1,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		\out2,Pn(Pshuf([4,5,6,7], 1), inf).clump(4).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
b=Pdef(\2, Pbind(\instrument, \ob,
	//\dur,1/2,
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~n2,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		\out2,Pn(Pshuf([4,5,6,7], 1), inf).clump(4).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	//\dur,1/2,
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~n3,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
			\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		\out2,Pn(Pshuf([4,5,6,7], 1), inf).clump(4).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),
	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	//\dur,1/2,
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
		\out2,Pn(Pshuf([4,5,6,7], 1), inf).clump(4).collect([_]),
	//\out,Pn(Pshuf([0, 1], 1), inf).clump(4).collect([_]),

	\x,Pbrown(0,1,0.1,inf),
	\y,Pbrown(0,1,0.1,inf),
	\z,Pbrown(0,1,0.1,inf),
	\rx,Pbrown(0,1,0.1,inf),
	\ry,Pbrown(0,1,0.1,inf),
	\rz,Pbrown(0,1,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
a.play;
b.play;
c.play;
d.play;

)
