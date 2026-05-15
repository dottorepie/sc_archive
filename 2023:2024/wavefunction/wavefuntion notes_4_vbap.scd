(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=16;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/200);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)

(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
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

	var out = NamedControl.kr(\out, [0, 1,2,3,4,5,6,7]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
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

	var out = NamedControl.kr(\out, [0, 1,2,3,4,5,6,7]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*8)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:3/2);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
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

	var out = NamedControl.kr(\out, [0, 1,2,3,4,5,6,7]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*9)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:4/3);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;
	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	};

}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
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

	var out = NamedControl.kr(\out, [0, 1,2,3,4,5,6,7]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*12)*pitch;

env=EnvGen.ar(Env.perc(attack,decay,pitch.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

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
	};
~phase2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b;
	};

~phase3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c;
	};

~phase4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d;
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
~n1=~n1*(3/2);
~n2=~n2*(3/2);
~n3=~n3*(3/2);
~n4=~n4*(3/2);
)

(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,Pseq(~n1.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~n2.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~n3.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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


/////////////////////////////////////


////_(0,1),(4,5)-(

(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var freq, env,m=1,bank, pitch, fund, angle=0,r,oscz,oscy1,oscy2,oscx1,oscx2,oscx3,oscx4;
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
	var wrappedOut7 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outz = NamedControl.kr(\out1, [12,13]);  // multiple buses!
	var outy1 = NamedControl.kr(\out2, [8,9]);
	var outy2 = NamedControl.kr(\out3, [10,11]);
	var outx1 = NamedControl.kr(\out4, [0, 1]);
	var outx2 = NamedControl.kr(\out5, [2,3]);
	var outx3 = NamedControl.kr(\out6, [4,5]);
	var outx4 = NamedControl.kr(\out7, [6,7]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

oscz=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

wrappedOut1.value(outz,LPF.ar(LeakDC.ar((oscz)*env),cutt));

		oscy1=PanAz.ar(2,InFeedback.ar(12,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));
		oscy2=PanAz.ar(2,InFeedback.ar(13,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut2.value(outy1,(oscy1)*env*0.1);
wrappedOut3.value(outy2,(oscy2)*env*0.1);

		oscx1=PanAz.ar(2,InFeedback.ar(8,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx2=PanAz.ar(2,InFeedback.ar(9,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx3=PanAz.ar(2,InFeedback.ar(10,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx4=PanAz.ar(2,InFeedback.ar(11,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut4.value(outx1,(oscx1)*env*0.01);
wrappedOut5.value(outx2,(oscx2)*env*0.01);
wrappedOut6.value(outx3,(oscx3)*env*0.01);
wrappedOut7.value(outx4,(oscx4)*env*0.01);

	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var freq, env,m=1,bank, pitch, fund, angle=0,r,oscz,oscy1,oscy2,oscx1,oscx2,oscx3,oscx4;
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
	var wrappedOut7 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outz = NamedControl.kr(\out1, [12,13]);  // multiple buses!
	var outy1 = NamedControl.kr(\out2, [8,9]);
	var outy2 = NamedControl.kr(\out3, [10,11]);
	var outx1 = NamedControl.kr(\out4, [0, 1]);
	var outx2 = NamedControl.kr(\out5, [2,3]);
	var outx3 = NamedControl.kr(\out6, [4,5]);
	var outx4 = NamedControl.kr(\out7, [6,7]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

oscz=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

wrappedOut1.value(outz,LPF.ar(LeakDC.ar((oscz)*env),cutt));

		oscy1=PanAz.ar(2,InFeedback.ar(12,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));
		oscy2=PanAz.ar(2,InFeedback.ar(13,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut2.value(outy1,(oscy1)*env*0.1);
wrappedOut3.value(outy2,(oscy2)*env*0.1);

		oscx1=PanAz.ar(2,InFeedback.ar(8,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx2=PanAz.ar(2,InFeedback.ar(9,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx3=PanAz.ar(2,InFeedback.ar(10,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx4=PanAz.ar(2,InFeedback.ar(11,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut4.value(outx1,(oscx1)*env*0.01);
wrappedOut5.value(outx2,(oscx2)*env*0.01);
wrappedOut6.value(outx3,(oscx3)*env*0.01);
wrappedOut7.value(outx4,(oscx4)*env*0.01);

	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var freq, env,m=1,bank, pitch, fund, angle=0,r,oscz,oscy1,oscy2,oscx1,oscx2,oscx3,oscx4;
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
	var wrappedOut7 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outz = NamedControl.kr(\out1, [12,13]);  // multiple buses!
	var outy1 = NamedControl.kr(\out2, [8,9]);
	var outy2 = NamedControl.kr(\out3, [10,11]);
	var outx1 = NamedControl.kr(\out4, [0, 1]);
	var outx2 = NamedControl.kr(\out5, [2,3]);
	var outx3 = NamedControl.kr(\out6, [4,5]);
	var outx4 = NamedControl.kr(\out7, [6,7]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

oscz=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

wrappedOut1.value(outz,LPF.ar(LeakDC.ar((oscz)*env),cutt));

		oscy1=PanAz.ar(2,InFeedback.ar(12,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));
		oscy2=PanAz.ar(2,InFeedback.ar(13,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut2.value(outy1,(oscy1)*env*0.1);
wrappedOut3.value(outy2,(oscy2)*env*0.1);

		oscx1=PanAz.ar(2,InFeedback.ar(8,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx2=PanAz.ar(2,InFeedback.ar(9,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx3=PanAz.ar(2,InFeedback.ar(10,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx4=PanAz.ar(2,InFeedback.ar(11,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut4.value(outx1,(oscx1)*env*0.01);
wrappedOut5.value(outx2,(oscx2)*env*0.01);
wrappedOut6.value(outx3,(oscx3)*env*0.01);
wrappedOut7.value(outx4,(oscx4)*env*0.01);

	};

}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var freq, env,m=1,bank, pitch, fund, angle=0,r,oscz,oscy1,oscy2,oscx1,oscx2,oscx3,oscx4;
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
	var wrappedOut7 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var outz = NamedControl.kr(\out1, [12,13]);  // multiple buses!
	var outy1 = NamedControl.kr(\out2, [8,9]);
	var outy2 = NamedControl.kr(\out3, [10,11]);
	var outx1 = NamedControl.kr(\out4, [0, 1]);
	var outx2 = NamedControl.kr(\out5, [2,3]);
	var outx3 = NamedControl.kr(\out6, [4,5]);
	var outx4 = NamedControl.kr(\out7, [6,7]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

oscz=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;

wrappedOut1.value(outz,LPF.ar(LeakDC.ar((oscz)*env),cutt));

		oscy1=PanAz.ar(2,InFeedback.ar(12,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));
		oscy2=PanAz.ar(2,InFeedback.ar(13,1), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut2.value(outy1,(oscy1)*env*0.1);
wrappedOut3.value(outy2,(oscy2)*env*0.1);

		oscx1=PanAz.ar(2,InFeedback.ar(8,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx2=PanAz.ar(2,InFeedback.ar(9,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx3=PanAz.ar(2,InFeedback.ar(10,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));
		oscx4=PanAz.ar(2,InFeedback.ar(11,1), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

wrappedOut4.value(outx1,(oscx1)*env*0.01);
wrappedOut5.value(outx2,(oscx2)*env*0.01);
wrappedOut6.value(outx3,(oscx3)*env*0.01);
wrappedOut7.value(outx4,(oscx4)*env*0.01);

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
	};
~phase2 = 10000.collect{
		angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);
		q2=(cos(angle2.degrad)+(sin(angle2.degrad)*(i+j+k)));
	v2=q2*v2;
	ph2=v2.b;
	};

~phase3 = 10000.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(0,360);
		q3=(cos(angle3.degrad)+(sin(angle3.degrad)*(i+j+k)));
	v3=q3*v3;
	ph3=v3.c;
	};

~phase4 = 10000.collect{
		angle4=(angle4+(360-(360/1.6180339887499))).wrap(0,360);
		q4=(cos(angle4.degrad)+(sin(angle4.degrad)*(i+j+k)));
	v4=q4*v4;
	ph4=v4.d;
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
~n1=~n1*(3/2);
~n2=~n2*(3/2);
~n3=~n3*(3/2);
~n4=~n4*(3/2);
)

(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phase1.abs,inf),
\n1,Pseq(~n1.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~n2.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~n3.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4.abs,inf),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1,2,3,4,5,6,7], 1), inf).clump(8).collect([_]),
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

	var outx = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [4, 0,5,2]);
	var outz = NamedControl.kr(\out3, [4, 1,5,3]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),spacex,timex);

osc1_y=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),spacey,timey);

osc1_z=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),spacez,timey);


m=m+1;

		wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\ob, {
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

	var outx = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [4, 0,5,2]);
	var outz = NamedControl.kr(\out3, [4, 1,5,3]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),spacex,timex);

osc1_y=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),spacey,timey);

osc1_z=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),spacez,timey);


m=m+1;

		wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};
}).add;
);
(
SynthDef.new(\oc, {
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

	var outx = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [4, 0,5,2]);
	var outz = NamedControl.kr(\out3, [4, 1,5,3]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),spacex,timex);

osc1_y=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),spacey,timey);

osc1_z=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),spacez,timey);


m=m+1;

		wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	};

}).add;
);
(
SynthDef.new(\od, {
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

	var outx = NamedControl.kr(\out1, [0, 1,2,3]);  // multiple buses!
	var outy = NamedControl.kr(\out2, [4, 0,5,2]);
	var outz = NamedControl.kr(\out3, [4, 1,5,3]);

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),spacex,timex);

osc1_y=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),spacey,timey);

osc1_z=Pan4.ar(SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),spacez,timey);


m=m+1;

		wrappedOut1.value(outx,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(outy, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(outz, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

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
		\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
	\out2,Pn(Pshuf([4,0,2,5], 1), inf).clump(4).collect([_]),
	\out3,Pn(Pshuf([4,1,3,5], 1), inf).clump(4).collect([_]),
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
			\cutt,Pbrown(220*2,220*8,100,inf),
		\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
	\out2,Pn(Pshuf([4,0,2,5], 1), inf).clump(4).collect([_]),
	\out3,Pn(Pshuf([4,1,3,5], 1), inf).clump(4).collect([_]),
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
			\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
	\out2,Pn(Pshuf([4,0,2,5], 1), inf).clump(4).collect([_]),
	\out3,Pn(Pshuf([4,1,3,5], 1), inf).clump(4).collect([_]),
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
			\out1,Pn(Pshuf([0, 1,2,3], 1), inf).clump(4).collect([_]),
	\out2,Pn(Pshuf([4,0,2,5], 1), inf).clump(4).collect([_]),
	\out3,Pn(Pshuf([4,1,3,5], 1), inf).clump(4).collect([_]),
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

/////////////////////////////////




Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [-90, 45],[0, -45], [90, -45], [180, -45], [-90, -45],[0, 0], [45, 0], [90, 0], [135, 0],[180, 0], [-135, 0], [-90, 0], [-45,0]]); // torus geo dome
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)



(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=4,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,i,j,k,v1,v2,v3,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_v3_x,ph_v3_y,ph_v3_z;
	var freq, env,m=1,bank, pitch, fund, angle=0,r;
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

	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),~b.bufnum,spacex.linlin(1.neg,1,180.neg,180),timex.linlin(1.neg,1,90.neg,90));

osc1_y=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),~b.bufnum,spacey.linlin(1.neg,1,180.neg,180),timey.linlin(1.neg,1,90.neg,90));

osc1_z=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),~b.bufnum,spacez.linlin(1.neg,1,180.neg,180),timez.linlin(1.neg,1,90.neg,90));


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
	var freq, env,m=1,bank, pitch, fund, angle=0,r;
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

	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);  // multiple buses!


	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),~b.bufnum,spacex.linlin(1.neg,1,180.neg,180),timex.linlin(1.neg,1,90.neg,90));

osc1_y=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),~b.bufnum,spacey.linlin(1.neg,1,180.neg,180),timey.linlin(1.neg,1,90.neg,90));

osc1_z=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),~b.bufnum,spacez.linlin(1.neg,1,180.neg,180),timez.linlin(1.neg,1,90.neg,90));


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
	var freq, env,m=1,bank, pitch, fund, angle=0,r;
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

	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),~b.bufnum,spacex.linlin(1.neg,1,180.neg,180),timex.linlin(1.neg,1,90.neg,90));

osc1_y=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),~b.bufnum,spacey.linlin(1.neg,1,180.neg,180),timey.linlin(1.neg,1,90.neg,90));

osc1_z=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),~b.bufnum,spacez.linlin(1.neg,1,180.neg,180),timez.linlin(1.neg,1,90.neg,90));


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
	var freq, env,m=1,bank, pitch, fund, angle=0,r;
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

	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]);  // multiple buses!


	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);

	v1=Quaternion(0,x,y,z);
	bank=8;
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

osc1_x=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_x,2pi)),~b.bufnum,spacex.linlin(1.neg,1,180.neg,180),timex.linlin(1.neg,1,90.neg,90));

osc1_y=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_y,2pi)),~b.bufnum,spacey.linlin(1.neg,1,180.neg,180),timey.linlin(1.neg,1,90.neg,90));

osc1_z=VBAP.ar(16,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_v1_z,2pi)),~b.bufnum,spacez.linlin(1.neg,1,180.neg,180),timez.linlin(1.neg,1,90.neg,90));


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
		\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 1), inf).clump(16).collect([_]),
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
			\cutt,Pbrown(220*2,220*8,100,inf),
\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 1), inf).clump(16).collect([_]),
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
\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 1), inf).clump(16).collect([_]),
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
\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15], 1), inf).clump(16).collect([_]),
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
/////////correct//cube with vbap

Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [90, 45], [180, 45], [90.neg, 45],[0, 45.neg], [90, 45.neg], [180, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)


(
(
SynthDef.new(\oa, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz;
	var spacex,timex,spacey,timey,spacez,timez;
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


	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt,0,0);
	v2=Quaternion(0,0,p.[1].sqrt,0);
	v3=Quaternion(0,0,0,p.[2].sqrt);
	v4=Quaternion(0,p.[0].sqrt,0,0);
	v5=Quaternion(0,0,p.[1].sqrt,0);
	v6=Quaternion(0,0,0,p.[2].sqrt);
	va=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	vb=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);

	bank=8;
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

	va=q*va;
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;

	vb=q1*vb;
	v4=q1*v4;
	v5=q1*v5;
	v6=q1*v6;

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);


	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;


osc1_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
osc1_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
osc1_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\ob, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz;
	var spacex,timex,spacey,timey,spacez,timez;
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


	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt,0,0);
	v2=Quaternion(0,0,p.[1].sqrt,0);
	v3=Quaternion(0,0,0,p.[2].sqrt);
	v4=Quaternion(0,p.[0].sqrt,0,0);
	v5=Quaternion(0,0,p.[1].sqrt,0);
	v6=Quaternion(0,0,0,p.[2].sqrt);
	va=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	vb=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);

	bank=8;
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

	va=q*va;
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;

	vb=q1*vb;
	v4=q1*v4;
	v5=q1*v5;
	v6=q1*v6;

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);


	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;


osc1_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
osc1_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
osc1_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\oc, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz;
	var spacex,timex,spacey,timey,spacez,timez;
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


	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt,0,0);
	v2=Quaternion(0,0,p.[1].sqrt,0);
	v3=Quaternion(0,0,0,p.[2].sqrt);
	v4=Quaternion(0,p.[0].sqrt,0,0);
	v5=Quaternion(0,0,p.[1].sqrt,0);
	v6=Quaternion(0,0,0,p.[2].sqrt);
	va=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	vb=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);

	bank=8;
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

	va=q*va;
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;

	vb=q1*vb;
	v4=q1*v4;
	v5=q1*v5;
	v6=q1*v6;

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);


	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;


osc1_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
osc1_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
osc1_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	};
}).add;
);
(
SynthDef.new(\od, {
	arg  n1=1, cutt=440,decay=6,t=2,attack=0.05,x=1,y=0.5,z=0.25,rx=1, ry=1,rz=1;
	var q,q1,i,j,k,va,vb,v1,v2,v3,v4,v5,v6,ph_v1_x,ph_v1_y,ph_v1_z,ph_v2_x,ph_v2_y,ph_v2_z,ph_va_x,ph_va_y,ph_va_z,ph_vb_x,ph_vb_y,ph_vb_z;
	var osc1,osc2,osc3,freq, env,m=1,bank, pitch, fund, angle=0,angle1=90,r,p;
	var osc1_x,osc1_y,osc1_z,osc2_x,osc2_y,osc2_z,cvax,cvay,cvaz,cvbx,cvby,cvbz;
	var spacex,timex,spacey,timey,spacez,timez;
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


	var out = NamedControl.kr(\out, [0, 1, 2, 3, 4, 5, 6, 7]);  // multiple buses!

	r=[rx,ry,rz].normalizeSum;

	i = Quaternion(0, r.[0].sqrt, 0, 0);
	j = Quaternion(0, 0,r.[1].sqrt, 0);
	k = Quaternion(0, 0, 0, r.[2].sqrt);

	p=[x,y,z].normalizeSum;

	v1=Quaternion(0,p.[0].sqrt,0,0);
	v2=Quaternion(0,0,p.[1].sqrt,0);
	v3=Quaternion(0,0,0,p.[2].sqrt);
	v4=Quaternion(0,p.[0].sqrt,0,0);
	v5=Quaternion(0,0,p.[1].sqrt,0);
	v6=Quaternion(0,0,0,p.[2].sqrt);
	va=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);
	vb=Quaternion(0,p.[0].sqrt,p.[1].sqrt,p.[2].sqrt);

	bank=8;
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

	va=q*va;
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;

	vb=q1*vb;
	v4=q1*v4;
	v5=q1*v5;
	v6=q1*v6;

	cvax=Cartesian(v1.b,v1.c,v1.d);
	cvay=Cartesian(v2.b,v2.c,v2.d);
	cvaz=Cartesian(v3.b,v3.c,v3.d);

	cvbx=Cartesian(v4.b,v4.c,v4.d);
	cvby=Cartesian(v5.b,v5.c,v5.d);
	cvbz=Cartesian(v6.b,v6.c,v6.d);


	ph_va_x=Complex(va.a.round(0.0001),va.b.round(0.0001)).phase;
	ph_va_y=Complex(va.a.round(0.0001),va.c.round(0.0001)).phase;
	ph_va_z=Complex(va.a.round(0.0001),va.d.round(0.0001)).phase;

	ph_vb_x=Complex(vb.a.round(0.0001),vb.b.round(0.0001)).phase;
	ph_vb_y=Complex(vb.a.round(0.0001),vb.c.round(0.0001)).phase;
	ph_vb_z=Complex(vb.a.round(0.0001),vb.d.round(0.0001)).phase;


osc1_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_x,2pi)),~b.bufnum,cvax.theta,cvax.phi);
osc1_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_y,2pi)),~b.bufnum,cvay.theta,cvay.phi);
osc1_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_va_z,2pi)),~b.bufnum,cvaz.theta,cvaz.phi);

//osc2_x=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_x,2pi)),~b.bufnum,cvbx.theta,cvbx.phi);
//osc2_y=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_y,2pi)),~b.bufnum,cvby.theta,cvby.phi);
//osc2_z=VBAP.ar(8,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(1,ph_vb_z,2pi)),~b.bufnum,cvbz.theta,cvbz.phi);

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));

	//wrappedOut4.value(out,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//wrappedOut5.value(out, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//wrappedOut6.value(out, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


	//Out.ar(0,LPF.ar(LeakDC.ar((osc1_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc1_z)*env),cutt));
	//Out.ar(0,LPF.ar(LeakDC.ar((osc2_x)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_y)*env),cutt));
	//Out.ar(0, LPF.ar(LeakDC.ar((osc2_z)*env),cutt));


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
		\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7], 1), inf).clump(8).collect([_]),
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
		\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7], 1), inf).clump(8).collect([_]),
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
		\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7], 1), inf).clump(8).collect([_]),
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
	\out,Pn(Pshuf([0, 1, 2, 3, 4, 5, 6, 7], 1), inf).clump(8).collect([_]),
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