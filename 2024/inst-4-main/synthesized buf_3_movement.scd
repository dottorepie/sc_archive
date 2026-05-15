(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=4;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*64;
//s.options.blockSize = 64/4;
s.options.maxNodes = 1024 * 64;
s.waitForBoot
)


Buffer.freeAll
(
// 3D
~a = VBAPSpeakerArray.new(3, [[0, 45], [180, 45], [90, 45.neg], [90.neg, 45.neg]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
// 3D random
~a = VBAPSpeakerArray.new(3, [[180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2], [180.rand2, 90.rand2]]);
~b = Buffer.loadCollection(s, ~a.getSetsAndMatrices);
)

(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:0 );
~c4 = Buffer.readChannel(s,,channels:1 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
~c7 = Buffer.readChannel(s,,channels:0 );
~c8 = Buffer.readChannel(s,,channels:1 );
~c9 = Buffer.readChannel(s,,channels:0 );
~c10 = Buffer.readChannel(s,,channels:1 );
~c11 = Buffer.readChannel(s,,channels:0 );
~c12 = Buffer.readChannel(s,,channels:1 );
~c13 = Buffer.readChannel(s,,channels:0 );
~c14 = Buffer.readChannel(s,,channels:1 );
~c15 = Buffer.readChannel(s,,channels:0 );
~c16 = Buffer.readChannel(s,,channels:1 );
)

(
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 250.collect{

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

~el = 250.collect{

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
(
SynthDef.new(\o1, {
    var in1,in2, chainx,chainy,b=0,az1=0,az2=0,el1=0,el2=0;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o2, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o3, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o4, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c7.bufnum, BufRateScale.kr(~c7), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c8.bufnum, BufRateScale.kr(~c8), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o5, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c9.bufnum, BufRateScale.kr(~c9), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c10.bufnum, BufRateScale.kr(~c10), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o6, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c11.bufnum, BufRateScale.kr(~c11), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c12.bufnum, BufRateScale.kr(~c12), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o7, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0;

    in1 = PlayBuf.ar(1, ~c13.bufnum, BufRateScale.kr(~c13), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c14.bufnum, BufRateScale.kr(~c14), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
(
SynthDef.new(\o8, {
    var in1,in2, chainx,chainy,b=0,az1,az2,el1,el2;
	var chainxx,chainyy,pl=0,;

    in1 = PlayBuf.ar(1, ~c15.bufnum, BufRateScale.kr(~c15), loop: 0, doneAction:2);
	 in2 = PlayBuf.ar(1, ~c16.bufnum, BufRateScale.kr(~c16), loop: 0, doneAction:2);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

		az1=~az.[pl];
		el1=~el.[pl];
		az2=~az.reverse.[pl];
		el2=~el.reverse.[pl];

		~az1=250.collect{az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el1=250.collect{el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90)};
		~az2=250.collect{az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180)};
		~el2=250.collect{el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90)};

pl=pl+1;

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;

		Out.ar(0,VBAP.ar(4,IFFT(chainxx),~b.bufnum,EnvGen.ar(Env.circle(~az1,[1])),EnvGen.ar(Env.circle(~el1,[1]))));
		Out.ar(0,VBAP.ar(4,IFFT(chainyy),~b.bufnum,EnvGen.ar(Env.circle(~az2,[1])),EnvGen.ar(Env.circle(~el2,[1]))));


	}
}).add;
);
)

(
Synth(\o1);
s.record(numChannels:4)
Synth(\o2);
s.record(numChannels:4)
Synth(\o3);
s.record(numChannels:4)
Synth(\o4);
s.record(numChannels:4)
Synth(\o5);
s.record(numChannels:4)
Synth(\o6);
s.record(numChannels:4)
Synth(\o7);
s.record(numChannels:4)
Synth(\o8);
s.record(numChannels:4)
)