(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


(2.pow(m/12))
(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg;

100.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=1000.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=1000.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=1000.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
~mag1=1000.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360)};

		mg=mag;
~m=999.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};

		Out.ar(0,SinOsc.ar(55*m,EnvGen.ar(Env(~angle.scramble,~m.normalize)),EnvGen.ar(Env(~mag.normalize.scramble,~m.normalize),levelScale:m.reciprocal)));
		Out.ar(1,SinOsc.ar(55*m,EnvGen.ar(Env(~angle1.scramble,~m.normalize)),EnvGen.ar(Env(~mag1.normalize.scramble,~m.normalize),levelScale:m.reciprocal)));

	m=m+1

}
}.play
)


)

(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg,ampscale,ampscale1;

100.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=1000.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=1000.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=1000.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,1);ampscale=2.pow(amp/12)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
		~mag1=1000.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,1); ampscale1=2.pow(amp1/12)};

		mg=mag;
~m=999.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,1)};

		Out.ar(0,SinOsc.ar(55*m,EnvGen.ar(Env(~angle.scramble,~m)),EnvGen.ar(Env(~mag.scramble,~m),levelScale:m.reciprocal)));
		Out.ar(1,SinOsc.ar(55*m,EnvGen.ar(Env(~angle1.scramble,~m)),EnvGen.ar(Env(~mag1.scramble,~m),levelScale:m.reciprocal)));

	m=m+1

}
}.play
)


(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg,ph2,ph3;

100.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=1000.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=1000.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=1000.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360);ph2=exp(Complex(0,1)*(ang1.degrad)).real.abs;};

~mag1=1000.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360);ph3=exp(Complex(0,1)*(ang1.degrad)).imag.abs;};

		mg=mag;
~m=999.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,1)};

		Out.ar(0,SinOsc.ar(55*m,EnvGen.ar(Env(~angle.scramble,~m)),EnvGen.ar(Env(~mag.scramble,~m),levelScale:m.reciprocal)));
		Out.ar(1,SinOsc.ar(55*m,EnvGen.ar(Env(~angle1.scramble,~m)),EnvGen.ar(Env(~mag1.scramble,~m),levelScale:m.reciprocal)));

	m=m+1

}
}.play
)

//////////////////////////////////////////////////////////////////

(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg;

1000.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=1000.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=1000.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=1000.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
~mag1=1000.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360)};

		mg=mag;
~m=999.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};

		Out.ar(0,HPF.ar(
SinOsc.ar(10*m,EnvGen.ar(Env(~angle,~m.normalize)),EnvGen.ar(Env(~mag.normalize.scramble,~m.normalize),levelScale:m.reciprocal)),
1000));
		Out.ar(1,HPF.ar(
SinOsc.ar(10*m,EnvGen.ar(Env(~angle1,~m.normalize)),EnvGen.ar(Env(~mag1.normalize.scramble,~m.normalize),levelScale:m.reciprocal)),
1000));

	m=m+1

}
}.play
)



	/////



	(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg;

3000.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=10.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=10.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=10.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
~mag1=10.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360)};

		mg=mag;
~m=9.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};

Out.ar(0,SinOsc.ar((200+m),EnvGen.ar(Env.circle(~angle,~m.normalize)),EnvGen.ar(Env.circle(~mag.normalize.scramble,~m.normalize),levelScale:(200+m).reciprocal)));
Out.ar(1,SinOsc.ar((200+m),EnvGen.ar(Env.circle(~angle1,~m.normalize)),EnvGen.ar(Env.circle(~mag1.normalize.scramble,~m.normalize),levelScale:(200+m).reciprocal)));

	m=m+1

}
}.play
)

	(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg,mg1;

800.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=10.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=10.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=10.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
~mag1=10.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360)};

		mg=mag;
				mg1=mag1;
~m1=9.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};
~m2=9.collect{mg1=(mg1+(360-(360/1.6180339887499))).wrap(0,360)};

Out.ar(0,SinOsc.ar(110*m,EnvGen.ar(Env.circle(~angle,~m.normalize)),EnvGen.ar(Env.circle(~mag.normalize.scramble,~m.normalize),levelScale:(m).reciprocal)));
Out.ar(1,SinOsc.ar(110*m,EnvGen.ar(Env.circle(~angle1,~m.normalize)),EnvGen.ar(Env.circle(~mag1.normalize.scramble,~m.normalize),levelScale:(m).reciprocal)));

	m=m+1

}
}.play
)

	(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=90,amp1,mg,mg1;

400.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
~angle=100.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

		angle1=(angle1+(360-(360/1.6180339887499))).wrap(0,360);
	ang1=angle1;
~angle1=100.collect{ang1=(ang1+(360-(360/1.6180339887499))).wrap(0,360);ph1=exp(Complex(0,1)*(ang1.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
~mag=100.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360)};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
~mag1=100.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360)};

		mg=mag;
				mg1=mag1;
~m1=99.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};
~m2=99.collect{mg1=(mg1+(360-(360/1.6180339887499))).wrap(0,360)};

Out.ar(0,SinOsc.ar(55*m,EnvGen.ar(Env.circle(~angle,[0.1])),EnvGen.ar(Env.circle(~mag.normalize.scramble,[0.1]),levelScale:(m).reciprocal)));
Out.ar(1,SinOsc.ar(55*m,EnvGen.ar(Env.circle(~angle1,[0.1])),EnvGen.ar(Env.circle(~mag1.normalize.scramble,[0.1]),levelScale:(m).reciprocal)));

	m=m+1

}
}.play
)

///////////////////////////////////////



(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 2000.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 2000.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

);
(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,v4,r,m=1,sph1,sph2,rot1,rot2;
var az3=0,el3=0,sph3,rot3,q3,i3,j3,k3,x1,y1,z1,x2,y2,z2,x3,y3,z3;
var sph11,sph22,sph33,rot11,rot22,rot33,i11,j11,k11,i22,j22,k22,i33,j33,k33,q11,q22,q33,v22,v33,v44;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0,aza,azb,azc,pl1=0,pl2=0,pl3=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v22=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v33=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v44=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~freq = 2000.collect{

	az1=~az.[pl1];
	el1=~el.[pl1];
	pl1=pl1+1;

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	x1=v2.b.round(0.00001).linlin(1.neg,1,180.neg,180);
	x2=v2.b.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph11=Spherical(1,x1,x2).asCartesian;

	rot11=[sph11.x,sph11.y,sph11.z];

	i11=Quaternion(0, rot11.[0], 0, 0);
	j11=Quaternion(0, 0, rot11.[1], 0);
	k11=Quaternion(0, 0, 0, rot11.[2]);

		q11=(cos(angle.degrad)+(sin(angle.degrad)*(i11+j11+k11)));
	    v22=q11*v22*q11.conjugate;

	aza=v22.b.round(0.00001).abs;

	};

~phase = 2000.collect{

		az2=~az.[pl2];
	el2=~el.[pl2];
	pl2=pl2+1;

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	y1=v3.c.round(0.00001).linlin(1.neg,1,180.neg,180);
	y2=v3.c.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph22=Spherical(1,y1,y2).asCartesian;

	rot22=[sph22.x,sph22.y,sph22.z];

	i22=Quaternion(0, rot22.[0], 0, 0);
	j22=Quaternion(0, 0, rot22.[1], 0);
	k22=Quaternion(0, 0, 0, rot22.[2]);

		q22=(cos(angle.degrad)+(sin(angle.degrad)*(i22+j22+k22)));
	    v33=q22*v33*q22.conjugate;

	azb=v33.c.round(0.00001).linlin(1.neg,1,360.neg,360);


	};

~mag = 2000.collect{

		az3=~az.[pl3];
	el3=~el.[pl3];
	pl3=pl3+1;

	sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

		q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
	    v4=q3*v4*q3.conjugate;

	z1=v4.d.round(0.00001).linlin(1.neg,1,180.neg,180);
	z2=v4.d.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph33=Spherical(1,z1,z2).asCartesian;

	rot33=[sph33.x,sph33.y,sph33.z];

	i33=Quaternion(0, rot33.[0], 0, 0);
	j33=Quaternion(0, 0, rot33.[1], 0);
	k33=Quaternion(0, 0, 0, rot33.[2]);

		q33=(cos(angle.degrad)+(sin(angle.degrad)*(i33+j33+k33)));
	    v44=q33*v44*q33.conjugate;

	azc=v44.d.round(0.00001).linlin(1.neg,1,360.neg,360);

	};

);



(
{
var pl=0,freq,amp,phase,phase1,fund=220,frequency,freqq,ampp,ph,ph1,angle=0,ang,amp1,ampp1;

2000.do{
		freq=~freq.[pl];
		phase=~phase.[pl];
		phase1=~phase.reverse.[pl];
		amp=~mag.[pl];
		amp1=~mag.reverse.[pl];

		frequency=fund*freq.reciprocal;
//~frequency=100.collect{freq=(freq+(360-(360/1.6180339887499))).wrap(360.neg,360);
	//		freqq=freq.linlin(360.neg,360,1.neg,1).abs};

~angle=10.collect{phase=(phase+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph=exp(Complex(0,1)*(phase.degrad)).phase};

~angle1=10.collect{phase1=(phase1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph1=exp(Complex(0,1)*(phase1.degrad)).phase};


~magn=10.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp=amp.linlin(360.neg,360,1.neg,1).abs};

	~magn1=10.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp1=amp1.linlin(360.neg,360,1.neg,1).abs};


	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;

~m1=9.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360)};

Out.ar(0,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle.mirror,~m1.mirror)),EnvGen.ar(Env.circle(~magn.mirror,~m1.mirror),levelScale:(freq))));
Out.ar(1,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle1.mirror,~m1.reverse.mirror)),EnvGen.ar(Env.circle(~magn1.mirror,~m1.reverse.mirror),levelScale:(freq))));

		pl=pl+1

}
}.play
)


var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 2000.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 2000.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

);
(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,v4,r,m=1,sph1,sph2,rot1,rot2;
var az3=0,el3=0,sph3,rot3,q3,i3,j3,k3,x1,y1,z1,x2,y2,z2,x3,y3,z3;
var sph11,sph22,sph33,rot11,rot22,rot33,i11,j11,k11,i22,j22,k22,i33,j33,k33,q11,q22,q33,v22,v33,v44;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0,aza,azb,azc,pl1=0,pl2=0,pl3=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v22=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v33=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v44=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~freq = 2000.collect{

	az1=~az.[pl1];
	el1=~el.[pl1];
	pl1=pl1+1;

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	x1=v2.b.round(0.00001).linlin(1.neg,1,180.neg,180);
	x2=v2.b.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph11=Spherical(1,x1,x2).asCartesian;

	rot11=[sph11.x,sph11.y,sph11.z];

	i11=Quaternion(0, rot11.[0], 0, 0);
	j11=Quaternion(0, 0, rot11.[1], 0);
	k11=Quaternion(0, 0, 0, rot11.[2]);

		q11=(cos(angle.degrad)+(sin(angle.degrad)*(i11+j11+k11)));
	    v22=q11*v22*q11.conjugate;

	aza=v22.b.round(0.00001).abs;

	};

~phase = 2000.collect{

		az2=~az.[pl2];
	el2=~el.[pl2];
	pl2=pl2+1;

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	y1=v3.c.round(0.00001).linlin(1.neg,1,180.neg,180);
	y2=v3.c.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph22=Spherical(1,y1,y2).asCartesian;

	rot22=[sph22.x,sph22.y,sph22.z];

	i22=Quaternion(0, rot22.[0], 0, 0);
	j22=Quaternion(0, 0, rot22.[1], 0);
	k22=Quaternion(0, 0, 0, rot22.[2]);

		q22=(cos(angle.degrad)+(sin(angle.degrad)*(i22+j22+k22)));
	    v33=q22*v33*q22.conjugate;

	azb=v33.c.round(0.00001).linlin(1.neg,1,360.neg,360);


	};

~mag = 2000.collect{

		az3=~az.[pl3];
	el3=~el.[pl3];
	pl3=pl3+1;

	sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

		q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
	    v4=q3*v4*q3.conjugate;

	z1=v4.d.round(0.00001).linlin(1.neg,1,180.neg,180);
	z2=v4.d.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph33=Spherical(1,z1,z2).asCartesian;

	rot33=[sph33.x,sph33.y,sph33.z];

	i33=Quaternion(0, rot33.[0], 0, 0);
	j33=Quaternion(0, 0, rot33.[1], 0);
	k33=Quaternion(0, 0, 0, rot33.[2]);

		q33=(cos(angle.degrad)+(sin(angle.degrad)*(i33+j33+k33)));
	    v44=q33*v44*q33.conjugate;

	azc=v44.d.round(0.00001).linlin(1.neg,1,360.neg,360);

	};

);



(
{
var pl=0,freq,amp,phase,phase1,fund=220,frequency,freqq,ampp,ph,ph1,angle=0,ang,amp1,ampp1;

2000.do{
		freq=~freq.[pl];
		phase=~phase.[pl];
		phase1=~phase.reverse.[pl];
		amp=~mag.[pl];
		amp1=~mag.reverse.[pl];

		frequency=fund*freq.reciprocal;
//~frequency=100.collect{freq=(freq+(360-(360/1.6180339887499))).wrap(360.neg,360);
	//		freqq=freq.linlin(360.neg,360,1.neg,1).abs};

~angle=10.collect{phase=(phase+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph=exp(Complex(0,1)*(phase.degrad)).phase};

~angle1=10.collect{phase1=(phase1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph1=exp(Complex(0,1)*(phase1.degrad)).phase};


~magn=10.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp=amp.linlin(360.neg,360,1.neg,1).abs};

	~magn1=10.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp1=amp1.linlin(360.neg,360,1.neg,1).abs};


	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;

~m1=9.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360)};

Out.ar(0,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle.mirror,~m1.mirror)),EnvGen.ar(Env.circle(~magn.mirror,~m1.mirror),levelScale:(freq))));
Out.ar(1,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle1.mirror,~m1.reverse.mirror)),EnvGen.ar(Env.circle(~magn1.mirror,~m1.reverse.mirror),levelScale:(freq))));

		pl=pl+1

}
}.play
)

(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 2000.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 2000.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

);
(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,v4,r,m=1,sph1,sph2,rot1,rot2;
var az3=0,el3=0,sph3,rot3,q3,i3,j3,k3,x1,y1,z1,x2,y2,z2,x3,y3,z3;
var sph11,sph22,sph33,rot11,rot22,rot33,i11,j11,k11,i22,j22,k22,i33,j33,k33,q11,q22,q33,v22,v33,v44;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0,aza,azb,azc,pl1=0,pl2=0,pl3=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v4=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v22=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v33=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v44=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~t= 2000.collect{

	az1=~az.[pl1];
	el1=~el.[pl1];
	pl1=pl1+1;

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	x1=v2.b.round(0.00001).linlin(1.neg,1,180.neg,180);
	x2=v2.b.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph11=Spherical(1,x1,x2).asCartesian;

	rot11=[sph11.x,sph11.y,sph11.z];

	i11=Quaternion(0, rot11.[0], 0, 0);
	j11=Quaternion(0, 0, rot11.[1], 0);
	k11=Quaternion(0, 0, 0, rot11.[2]);

		q11=(cos(angle.degrad)+(sin(angle.degrad)*(i11+j11+k11)));
	    v22=q11*v22*q11.conjugate;

	aza=v22.b.round(0.00001).linlin(1.neg,1,360.neg,360);

	};

~phase = 2000.collect{

		az2=~az.[pl2];
	el2=~el.[pl2];
	pl2=pl2+1;

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	y1=v3.c.round(0.00001).linlin(1.neg,1,180.neg,180);
	y2=v3.c.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph22=Spherical(1,y1,y2).asCartesian;

	rot22=[sph22.x,sph22.y,sph22.z];

	i22=Quaternion(0, rot22.[0], 0, 0);
	j22=Quaternion(0, 0, rot22.[1], 0);
	k22=Quaternion(0, 0, 0, rot22.[2]);

		q22=(cos(angle.degrad)+(sin(angle.degrad)*(i22+j22+k22)));
	    v33=q22*v33*q22.conjugate;

	azb=v33.c.round(0.00001).linlin(1.neg,1,360.neg,360);


	};

~mag = 2000.collect{

		az3=~az.[pl3];
	el3=~el.[pl3];
	pl3=pl3+1;

	sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

		q3=(cos(angle.degrad)+(sin(angle.degrad)*(i3+j3+k3)));
	    v4=q3*v4*q3.conjugate;

	z1=v4.d.round(0.00001).linlin(1.neg,1,180.neg,180);
	z2=v4.d.round(0.00001).linlin(1.neg,1,90.neg,90);

	sph33=Spherical(1,z1,z2).asCartesian;

	rot33=[sph33.x,sph33.y,sph33.z];

	i33=Quaternion(0, rot33.[0], 0, 0);
	j33=Quaternion(0, 0, rot33.[1], 0);
	k33=Quaternion(0, 0, 0, rot33.[2]);

		q33=(cos(angle.degrad)+(sin(angle.degrad)*(i33+j33+k33)));
	    v44=q33*v44*q33.conjugate;

	azc=v44.d.round(0.00001).linlin(1.neg,1,360.neg,360);

	};

);



(
{
var pl=0,freq,amp,phase,phase1,fund=55,frequency,freqq,ampp,ph,ph1,angle=0,ang,amp1,ampp1,time,timee,time1,timee1,m=1;

400.do{
		time=~t.[pl];
		time1=~t.reverse.[pl];
		phase=~phase.[pl];
		phase1=~phase.reverse.[pl];
		amp=~mag.[pl];
		amp1=~mag.reverse.[pl];


~time=99.collect{time=(time+(360-(360/1.6180339887499))).wrap(360.neg,360);
			timee=time.linlin(360.neg,360,1.neg,1).abs};

~time1=99.collect{time1=(time1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			timee1=time1.linlin(360.neg,360,1.neg,1).abs};

~angle=100.collect{phase=(phase+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph=exp(Complex(0,1)*(phase.degrad)).phase};

~angle1=100.collect{phase1=(phase1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ph1=exp(Complex(0,1)*(phase1.degrad)).phase};


~magn=100.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp=amp.linlin(360.neg,360,1.neg,1).abs};

	~magn1=100.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(360.neg,360);
			ampp1=amp1.linlin(360.neg,360,1.neg,1).abs};


	//angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	//ang=angle;


		//freq=ang.linlin(0,360,0,1);
//frequency=fund*freq.reciprocal;
		frequency=fund*m;

Out.ar(0,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle.mirror,~time.mirror)),EnvGen.ar(Env.circle(~magn.mirror,~time.mirror),levelScale:(m.reciprocal))));
Out.ar(1,SinOsc.ar(frequency,EnvGen.ar(Env.circle(~angle1.mirror,~time1.mirror)),EnvGen.ar(Env.circle(~magn1.mirror,~time1.mirror),levelScale:(m.reciprocal))));

		pl=pl+1;
		m=m+1;

}
}.play
)



////////////

(
{
var angle=0,m=1,ph,mag=0,ang,amp,angle1=90,ang1,ph1,mag1=0,amp1,mg,magnitude,magnitude1,phasee,power,power1,t;

100.do{

	angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
	ang=angle;
phasee=100.collect{ang=(ang+(360-(360/1.6180339887499))).wrap(0,360);ph=exp(Complex(0,1)*(ang.degrad)).phase;};

	mag=(mag+(360-(360/1.6180339887499))).wrap(0,360);
	amp=mag;
power=100.collect{amp=(amp+(360-(360/1.6180339887499))).wrap(0,360);magnitude=exp(Complex(0,1)*(amp.degrad)).real.abs;};

	mag1=(mag1+(360-(360/1.6180339887499))).wrap(0,360);
	amp1=mag1;
power1=100.collect{amp1=(amp1+(360-(360/1.6180339887499))).wrap(0,360);magnitude=exp(Complex(0,1)*(amp1.degrad)).imag.abs;};

		mg=mag;
t=99.collect{mg=(mg+(360-(360/1.6180339887499))).wrap(0,360)};

		Out.ar(0,SinOsc.ar(55*m,EnvGen.ar(Env.circle(phasee,[0.1])),EnvGen.ar(Env.circle(power,[0.1]),levelScale:m.reciprocal)));
	Out.ar(1,SinOsc.ar(55*m,EnvGen.ar(Env.circle(phasee,[0.1])),EnvGen.ar(Env.circle(power1,[0.1]),levelScale:m.reciprocal)));

	m=m+1

}
}.play
)










