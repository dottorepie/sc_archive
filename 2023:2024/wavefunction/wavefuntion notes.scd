(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/240);
s.options.memSize = 8192*64;
s.options.blockSize = 16;
s.options.maxLogins = 32;
s.waitForBoot
)
Server.killAll


exp(Complex(0,1)*(180.degrad)).real;


(cos(67.degrad)+(sin(67.degrad)*Complex(0,1))).round(0.0001)

(cos(67.degrad)+(sin(67.degrad)*Quaternion(0,0,1,0))).coordinates.round(0.0001)


(
var i = Quaternion(0, 0, 0, 0),j = Quaternion(0, 0, 0, 0),k = Quaternion(0, 0, 0, 1),q1,q2,v,angle=0,n;


10.do{
	angle=(angle+(137.5)).wrap(0,360);
 	q1=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
 	q2=q1.conjugate;
	v=Quaternion(0,1,2,3);
	v=q1*v;
	//v=v*q2 opposite direction rotation
	//v=v*q2;
 	n=v.coordinates.round(0.0001).postln;
	n.normalize(1.neg,1).postln;
 }

)


(
{
var x,y,z,ijk,r;
x=SinOsc.ar(0.1,phase:0.degrad);
y=SinOsc.ar(0.1,phase:90.degrad);
z=SinOsc.ar(0.1);
ijk=[x.pow(2),y.pow(2),z.pow(2)].normalizeSum;
	ijk.[2].poll;
	r=Quaternion(0,ijk.[0],0,0);
	r.b.poll;
}.play
)
(
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt, 0),k = Quaternion(0, 0, 0, (1/3).sqrt),q1,q2,v1,v2,v3,angle=0,ph1x,ph1y,ph1z,ph2x,ph2y,ph2z,ph3x,ph3y,ph3z,ra;

	ra=[1,2,3].normalizeSum;
	v1=Quaternion(0,ra.[0].sqrt,ra.[1].sqrt,ra.[2].sqrt.neg);
	v2=Quaternion(0,0,(1/3).sqrt,0);
	v3=Quaternion(0,0,0,1);

angle=(360-(360/1.6180339887499));

10.do{
	//angle=(angle+(360/4)).wrap(0,360);
 	q1=(cos(angle.degrad/2)+(sin(angle.degrad/2)*(i+j+k)));
 	q2=q1.conjugate;
	v1=q1*v1;
	v2=q1*v2;
	v3=q1*v3;
	//v=v*q2 opposite direction rotation
	v1=v1*q2;
 	v1.coordinates.round(0.0001).postln;
	//v2.coordinates.round(0.0001).postln;
	//v3.coordinates.round(0.0001).postln;
	//v1.b.postln;
	//v1.c.postln;
	//v1.d.postln;
	ph1x=Complex(0,v1.b.round(0.0001)).phase;
	ph1y=Complex(0,v1.c.round(0.0001)).phase;
	ph1z=Complex(0,v1.d.round(0.0001)).phase;
	ph2x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph2y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph2z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;
	ph3x=Complex(v3.a.round(0.0001),v3.b.round(0.0001)).phase;
	ph3y=Complex(v3.a.round(0.0001),v3.c.round(0.0001)).phase;
	ph3z=Complex(v3.a.round(0.0001),v3.d.round(0.0001)).phase;
//	ph1x.postln;
//	ph1y.postln;
//	ph1z.postln;
 }

)
Complex(1,2).phase
(
var i = (1/3).sqrt,j = (1/3).sqrt,k = (1/3).sqrt;

(i*i)+(j*j)+(k*k);

)

0.5.pow(2)*4

Quaternion(1,0,0,0).norm
Quaternion(0,0.5774,0.5774,0.5774).norm



(
{
var x,y,z,ijk,r,rx,ry,rz;
	x=0.1;
y=0.2;
z=0.3;
	ijk=[x,y,z].normalizeSum;
	ijk.postln;
	//r=Quaternion(0,ijk.[0],0,0);
	//r.b.poll;
}.play
)

({
	Out.kr(0,SinOsc.kr(0.1,phase:0.degrad));
	Out.kr(1,SinOsc.kr(0.1,phase:137.5.degrad));
	Out.kr(2,SinOsc.kr(0.1,phase:275.degrad));
}.play)
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

	var out = NamedControl.kr(\out, [0, 1]);  // multiple buses!

	r=[rx.pow(2),ry.pow(2),rz.pow(2)].normalizeSum;

	i = Quaternion(0, r.[0], 0, 0);
	j = Quaternion(0, 0,r.[1], 0);
	k = Quaternion(0, 0, 0, r.[2]);
	v1=Quaternion(0,x,y,z);
	v2=Quaternion(0,0,1,0);
	v3=Quaternion(0,0,0,1);
	bank=16;
	pitch=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq = (fund*6)*pitch;

	bank.do{

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;
	v2=q*v2;
	v3=q*v3;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;
	ph_v2_x=Complex(v2.a.round(0.0001),v2.b.round(0.0001)).phase;
	ph_v2_y=Complex(v2.a.round(0.0001),v2.c.round(0.0001)).phase;
	ph_v2_z=Complex(v2.a.round(0.0001),v2.d.round(0.0001)).phase;
	ph_v3_x=Complex(v3.a.round(0.0001),v3.b.round(0.0001)).phase;
	ph_v3_y=Complex(v3.a.round(0.0001),v3.c.round(0.0001)).phase;
	ph_v3_z=Complex(v3.a.round(0.0001),v3.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(0.1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(0.1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(0.1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

/*osc2_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_x,2pi)), LFSaw.ar(1,ph_v2_x.linlin(2pi.neg,2pi,1.neg,1)));

osc2_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_y,2pi)), LFSaw.ar(1,ph_v2_y.linlin(2pi.neg,2pi,1.neg,1)));

osc2_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v2_z,2pi)), LFSaw.ar(1,ph_v2_z.linlin(2pi.neg,2pi,1.neg,1)));

osc3_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_x,2pi)), LFSaw.ar(1,ph_v3_x.linlin(2pi.neg,2pi,1.neg,1)));

osc3_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_y,2pi)), LFSaw.ar(1,ph_v3_y.linlin(2pi.neg,2pi,1.neg,1)));

osc3_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v3_z,2pi)), LFSaw.ar(1,ph_v3_z.linlin(2pi.neg,2pi,1.neg,1)));*/

//osc1=osc1_x+osc1_y+osc1_z;
//osc2=osc2_x+osc2_y+osc2_z;
//osc3=osc3_x+osc3_y+osc3_z;

m=m+1;

	wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1_x)),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc1_y)),cutt));
	wrappedOut3.value(out, LPF.ar(LeakDC.ar((osc1_z)),cutt));

	};
}).add;
)

Synth.new(\oa,[\out,[0,1]]);



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

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));


m=m+1;
angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);

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

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

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

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;
	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

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

	q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	v1=q*v1;

	ph_v1_x=Complex(v1.a.round(0.0001),v1.b.round(0.0001)).phase;
	ph_v1_y=Complex(v1.a.round(0.0001),v1.c.round(0.0001)).phase;
	ph_v1_z=Complex(v1.a.round(0.0001),v1.d.round(0.0001)).phase;

osc1_x=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_x,2pi)), LFSaw.ar(1,ph_v1_x.linlin(2pi.neg,2pi,1.neg,1)));

osc1_y=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_y,2pi)), LFSaw.ar(1,ph_v1_y.linlin(2pi.neg,2pi,1.neg,1)));

osc1_z=PanAz.ar(2,SinOsc.ar((freq*m),mul:m.reciprocal,phase:SinOsc.ar(0.1,ph_v1_z,2pi)), LFSaw.ar(1,ph_v1_z.linlin(2pi.neg,2pi,1.neg,1)));

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
var  anglex=0,angley=0,x=0,y=0;


	~phasex = 10000.collect{
		anglex=(anglex+(360-(360/1.6180339887499))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.theta
	};


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
	\dur,Pseq(~phase2.abs,inf),
\n1,Pseq(~n2.abs,inf),
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
	\dur,Pseq(~phase3.abs,inf),
\n1,Pseq(~n3.abs,inf),
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
	\dur,Pseq(~phase4.abs,inf),
\n1,Pseq(~n4.abs,inf),
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







///////////////////////////








(
var  anglex=0,angley=0,x=0,y=0;


	~x = 10000.collect{
		anglex=(anglex+(360-(360/1.6180339887499))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.real
	};

~y = 10000.collect{
		angley=(angley+(360-(360/1.6180339887499))).wrap(0,360);
		y=exp(Complex(0,1)*(angley.degrad));
	y=y.imag
	};


)



Env.new(~x,[1],\sine).plot

{SinOsc.ar(440,phase:0.degrad)}.play;
{SinOsc.ar(440*2,phase:0.degrad)}.play;
{SinOsc.ar(440*3,phase:0.degrad)}.play;
{SinOsc.ar(440*4,phase:0.degrad)}.play;

{SinOsc.ar(440,phase:0.degrad)+
SinOsc.ar(440*2,phase:0.degrad)+
SinOsc.ar(440*3,phase:0.degrad)+
SinOsc.ar(440*4,phase:0.degrad)}.play;

(
{
var m=1,sig,part,anglex=0,x;

		x=exp(Complex(0,1)*(anglex.degrad));
	part=Pan2.ar(SinOsc.ar(220*m,mul:m.reciprocal),x.imag);

100.do{
	m=m+1;
	anglex=(anglex+(360-(360/1.6180339887499))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
		part=part+Pan2.ar(SinOsc.ar(220*m,mul:m.reciprocal),x.imag);
};
Out.ar(0,part);
}.play

)

(
{
var m=1,sig,part;


100.do{
	part=SinOsc.ar(220*m,mul:m.reciprocal);
		m=m+1;
		Out.ar(0,part);
};
}.play

)


(
var freq = 440;
//{Out.ar(1,SinOsc.ar(freq,90.degrad,EnvGen.ar(Env.new(~y,[freq.reciprocal/4],\sine),doneAction:2)))}.play;
{Out.ar(0,SinOsc.ar(freq,0.degrad,add:EnvGen.ar(Env.new(~x,[freq.reciprocal],\sine),doneAction:2)))}.play;
)

(
var freq = 440;
{Out.ar(1,Pan2.ar(SinOsc.ar(freq,0.degrad),EnvGen.ar(Env.new(~y,[freq.reciprocal],\sine),doneAction:2)))}.play;
{Out.ar(0,Pan2.ar(SinOsc.ar(freq,0.degrad),EnvGen.ar(Env.new(~x,[freq.reciprocal],\sine),doneAction:2)))}.play;
)





(
SynthDef.new(\oa, {
	arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2,w1,w2;
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
	bank=6;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
	freq1 = (fund*6)*pitch1;

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:2);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

w1=EnvGen.ar(Env.new(~x,[(freq1*m).reciprocal/2],\sine));
w2=EnvGen.ar(Env.new(~y,[(freq1*m).reciprocal/2],\sine));

		///phase1=Complex(detune1.real,detune1.r

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w1,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w2,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;

SynthDef.new(\ob, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2,w1,w2;
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
	bank=6;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
		freq1 = (fund*8)*pitch1;

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:3/4);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:3/4);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

w1=EnvGen.ar(Env.new(~x,[(freq1*m).reciprocal/2],\sine));
w2=EnvGen.ar(Env.new(~y,[(freq1*m).reciprocal/2],\sine));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w1,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w2,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));
m=m+1;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;

SynthDef.new(\oc, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2,w1,w2;
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
	bank=6;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
		freq1 = (fund*9)*pitch1;

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:2/3);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:2/3);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

w1=EnvGen.ar(Env.new(~x,[(freq1*m).reciprocal/2],\sine));
w2=EnvGen.ar(Env.new(~y,[(freq1*m).reciprocal/2],\sine));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w1,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w2,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;

SynthDef.new(\od, {
arg  n1=1, cutt=1200,decay=6,t=2,attack=0.05,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2,w1,w2;
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
	bank=6;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
		freq1 = (fund*12)*pitch1;

env=EnvGen.ar(Env.perc(attack,decay,pitch1.reciprocal),doneAction:2,levelScale:1);
//env=EnvGen.ar(Env.sine(decay,pitch1.reciprocal),doneAction:2,levelScale:1);

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi)));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi)));

w1=EnvGen.ar(Env.new(~x,[(freq1*m).reciprocal/2],\sine));
w2=EnvGen.ar(Env.new(~y,[(freq1*m).reciprocal/2],\sine));

osc1=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w1,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m),mul:m.reciprocal,add:w2,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)*env),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)*env),cutt));

	};
}).add;

)

(
var  anglex=0,angley=0,x=0,y=0;


	~phasex = 10000.collect{
		anglex=(anglex+(360-(360/1.6180339887499))).wrap(0,360);
		x=exp(Complex(0,1)*(anglex.degrad));
	x=x.theta
	};


)



(
a=Pdef(\1, Pbind(\instrument, \oa,
	//\dur,1/2,
	\dur,Pseq(~phasex.abs,inf),
\n1,Pseq([0,5,7,12,17,19,24],inf),
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
\n1,Prand([0,5,7,12,17,19,24],inf),
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
\n1,Prand([0,5,7,12,17,19,24],inf),
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
\n1,Prand([0,5,7,12,17,19,24],inf),
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

(
SynthDef.new(\oe, {
arg  n1=0, cutt=1200,decay=6,t=2,attack=0.05,angle1=0,angle2=90;
	var tf, detune1,detune2, osc1,osc2,w1,w2;
	var freq1,m=1,bank, pitch1, fund;
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
	bank=24;
	//n1=WhiteNoise.ar(12);
	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
		freq1 = (fund*6)*pitch1;

	bank.do{

detune1=exp(Complex(0,1)*(SinOsc.ar(0.01,angle1.degrad,2pi).abs));
detune2=exp(Complex(0,1)*(SinOsc.ar(0.01,angle2.degrad,2pi).abs));

w1=EnvGen.ar(Env.new(~x,[(freq1*m).reciprocal/2],\sine),levelScale:m.reciprocal);
w2=EnvGen.ar(Env.new(~y,[(freq1*m).reciprocal/2],\sine),levelScale:m.reciprocal);

osc1=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:w1,phase:SinOsc.ar(0.1,detune1.theta,2pi)), LFSaw.ar(1,detune1.theta.linlin(2pi.neg,2pi,1.neg,1)));

osc2=PanAz.ar(2,SinOsc.ar((freq1*m)*pitch1,mul:w2,phase:SinOsc.ar(0.1,detune2.theta,2pi)), LFSaw.ar(1,detune2.theta.linlin(2pi.neg,2pi,1.neg,1)));

m=m+1;
angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
angle2=(angle2+(360-(360/1.6180339887499))).wrap(0,360);

		wrappedOut1.value(out,LPF.ar(LeakDC.ar((osc1)),cutt));
	wrappedOut2.value(out, LPF.ar(LeakDC.ar((osc2)),cutt));

	};
}).add;

)
Synth(\oe);


(
SynthDef.new(\oe, {
arg  n1=0,t=2;
	var detune1,detune2, osc1,osc2,w1,w2;
	var freq1, pitch1, fund;

	pitch1=2.pow(n1/(2*6));
	fund=(((4*t)-1)*((4*t)/2));
		freq1 = (fund*12)*pitch1;

w1=EnvGen.ar(Env.new(~x,[freq1.reciprocal/2],\sine));
w2=EnvGen.ar(Env.new(~y,[freq1.reciprocal/2],\sine));

	osc1=SinOsc.ar((freq1)*pitch1,phase:0.degrad,add:w1);

	osc2=SinOsc.ar((freq1)*pitch1,phase:90.degrad,add:w2);


			Out.ar(0,LeakDC.ar(osc1));
		Out.ar(1,LeakDC.ar(osc2));

}).add;

)
Synth(\oe);


