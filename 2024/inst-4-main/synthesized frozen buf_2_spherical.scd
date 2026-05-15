
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

//////////phase shift
~c1 = Buffer.readChannel(s,,channels:0 );
(
(
SynthDef("help-phaseShift", { arg out=0;
        var in, chain;
        in = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
        chain = FFT(LocalBuf(2048), in);
        chain = PV_PhaseShift(chain,90.degrad);
        Out.ar(out, 0.1 * IFFT(chain));
}).play(s);
);
)

s.record(numChannels:1)

/////////////freeze

~c1 = Buffer.readChannel(s,,channels:[0,1] );

(
~fftsize=8192;
~hop=0.25;
~win=0;
~f={Buffer.alloc(s,~c1.duration.calcPVRecSize(~fftsize,~hop))}!2;
)
(
{
	var sig,chain,localbuf;
	sig=PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0,doneAction:2);
	localbuf={LocalBuf.new(~fftsize)}!2;
	chain=FFT(localbuf,sig,~hop,~win);
	chain=PV_RecordBuf(chain,~f,run:1,hop:~hop,wintype:~win);
	0;
}.play;
)

(
x={
	var sig,chain,localbuf;
	localbuf={LocalBuf.new(~fftsize)}!2;
		chain=PV_PlayBuf(localbuf,~f,\rate.kr(1),loop:inf);
		sig=IFFT(chain,~win);
	}.play;
)

x.set(\rate,0);
x.set(\rate,1/1);
x.set(\rate,-2/3);
x.release(2);

/////////////////synth
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
);

(
(
SynthDef.new(\o1, {
	arg n=1,decay=2,buffer1=0,buffer2=0,az1,az2,el1,el2;
    var in1,in2, chainx,chainy,b=0;
	var chainxx,chainyy,pitch,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);
az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);
el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,az1,el1)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,az2,el2)*env);
	}
}).add;
);
(
SynthDef.new(\o2, {
	arg n=1,decay=2,buffer1=0,buffer2=0,az1,az2,el1,el2;
    var in1,in2, chainx,chainy,b=0;
	var chainxx,chainyy,pitch,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);
az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);
el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,az1,el1)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,az2,el2)*env);
	}
}).add;
);
(
SynthDef.new(\o3, {
	arg n=1,decay=2,buffer1=0,buffer2=0,az1,az2,el1,el2;
    var in1,in2, chainx,chainy,b=0;
	var chainxx,chainyy,pitch,env;
	var wrappedOut1 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};
	var wrappedOut2 = { |busArray, signalArray|
	[busArray, signalArray].flop.do { |pair|
		Out.ar(pair[0], pair[1])}};

	var out = NamedControl.kr(\out, [0, 1, 2, 3]);  // multiple buses!

	pitch=2.pow(n/12);

	env=EnvGen.ar(Env.perc(0.01,decay,pitch.reciprocal),doneAction:2);

	in1 = PitchShift.ar(PlayBuf.ar(1, buffer1, BufRateScale.kr(buffer1), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);
	in2 = PitchShift.ar(PlayBuf.ar(1, buffer2, BufRateScale.kr(buffer2), loop: 0, doneAction:2),pitchRatio:pitch,mul:env);

	chainx = FFT(LocalBuf(1024), in1);
	chainy = FFT(LocalBuf(1024), in2);

   250.do{

az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);
el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);
az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);
el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

   chainxx = chainx.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);
   chainyy = chainy.pvcollect(1024, {|mag, phase, index| [mag, phase]; }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
	wrappedOut1.value(out,VBAP.ar(4,IFFT(chainxx),~b.bufnum,az1,el1)*env);
	wrappedOut2.value(out,VBAP.ar(4,IFFT(chainyy),~b.bufnum,az2,el2)*env);
	}
}).add;
);
)




(
(
var  angle1=0,angle2=0,az,el;


	~az = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	};
~el = 100.collect{
	angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	};
)

(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=4;


~phase2 = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n1=Spherical(rad1,angle1,angle2).x;
	n1=(n1*m).round(1/16);

	};

~phase3 = 100.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle4=(angle4+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n2=Spherical(rad2,angle3,angle4).y;
	n2=(n2*m).round(1/16);

	};

~phase4 = 100.collect{
		angle5=(angle5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle6=(angle6+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n3=Spherical(rad3,angle5,angle6).z;
	n3=(n3*m).round(1/16);

	};

);
(
var  angle1=0,angle2=0,angle3=0,angle4=0,angle5=0,angle6=0;
var rad1=0,rad2=0,rad3=0;
var n1,n2,n3,m=12;


~n2 = 100.collect{
		angle1=(angle1+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle2=(angle2+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad1=(rad1+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n1=Spherical(rad1,angle1,angle2).x;
	n1=(n1*m).round(1);

	};

~n3 = 100.collect{
		angle3=(angle3+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle4=(angle4+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad2=(rad2+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n2=Spherical(rad2,angle3,angle4).y;
	n2=(n2*m).round(1);

	};

~n4 = 100.collect{
		angle5=(angle5+(360-(360/1.6180339887499))).wrap(180.neg,180);
	   angle6=(angle6+(360-(360/1.6180339887499))).wrap(90.neg,90);
	rad3=(rad3+(360-(360/1.6180339887499))).wrap(1.neg,1);
	n3=Spherical(rad3,angle5,angle6).z;
	n3=(n3*m).round(1);

	};

);
)


Scale.directory

//////////pattern for mobius strib of sequential or parallel play of directions
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az,inf),
	\el1,Pseq(~el,inf),
	\az2,Pseq(~az.reverse,inf),
	\el2,Pseq(~el.reverse,inf),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az,inf),
	\el1,Pseq(~el,inf),
	\az2,Pseq(~az.reverse,inf),
	\el2,Pseq(~el.reverse,inf),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az,inf),
	\el1,Pseq(~el,inf),
	\az2,Pseq(~az.reverse,inf),
	\el2,Pseq(~el.reverse,inf),
		\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
e=Pdef(\22, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n2.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az.reverse,inf),
	\el1,Pseq(~el.reverse,inf),
	\az2,Pseq(~az,inf),
	\el2,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n3.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az.reverse,inf),
	\el1,Pseq(~el.reverse,inf),
	\az2,Pseq(~az,inf),
	\el2,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase4.abs.reverse,1),
\n1,PdegreeToKey(Pseq(~n4.reverse,inf),Scale.mixolydian),
	\cutt,Pbrown(220*2,220*8,100,inf),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
\az1,Pseq(~az.reverse,inf),
	\el1,Pseq(~el.reverse,inf),
	\az2,Pseq(~az,inf),
	\el2,Pseq(~el,inf),
	\dist,Pgauss(0.2,0.1,inf),
	\decay,Pbrown(2,8,1,inf);
));
)

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
	(1).wait;
		bb.play;
cc.play;
dd.play;


	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;

////////////////pattern for web of directions
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Ppatlace([Pseq(~phase2.abs,1),Pseq(~phase2.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n2,inf),Pseq(~n2.reverse,inf)],inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Ppatlace([Pseq(~phase3.abs,1),Pseq(~phase3.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n3,inf),Pseq(~n3.reverse,inf)],inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,
	\dur,Ppatlace([Pseq(~phase4.abs,1),Pseq(~phase4.abs.reverse,1)],inf),
	\n1,PdegreeToKey(Ppatlace([Pseq(~n4,inf),Pseq(~n4.reverse,inf)],inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
)


(
b.play;
//s.record(numChannels:4)
//)
//(
c.play;
//s.record(numChannels:4)
//)
//(
d.play;
s.record(numChannels:4)
)


/////////////////////////////////in one pattern
(
~phase2=~phase2++~phase2.reverse;
~n2=~n2++~n2.reverse;
~phase3=~phase3++~phase3.reverse;
~n3=~n3++~n3.reverse;
~phase4=~phase4++~phase4.reverse;
~n4=~n4++~n4.reverse;



~phase22=~phase2.reverse++~phase2;
~n22=~n2.reverse++~n2;
~phase33=~phase3.reverse++~phase3;
~n33=~n3.reverse++~n3;
~phase44=~phase4.reverse++~phase4;
~n44=~n4++~n4.reverse;

~az1=~az++~az.reverse;
~el1=~el++~el.reverse;

~az2=~az.reverse++~az;
~el2=~el.reverse++~el;

)
(
b=Pdef(\2, Pbind(\instrument, \ob,
	\dur,Pseq(~phase2.abs,1),
\n1,PdegreeToKey(Pseq(~n2,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az1,inf),
	\el1,Pseq(~el1,inf),
	\az2,Pseq(~az2,inf),
	\el2,Pseq(~el2,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
c=Pdef(\3, Pbind(\instrument, \oc,
	\dur,Pseq(~phase3.abs,1),
\n1,PdegreeToKey(Pseq(~n3,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az1,inf),
	\el1,Pseq(~el1,inf),
	\az2,Pseq(~az2,inf),
	\el2,Pseq(~el2,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
d=Pdef(\4, Pbind(\instrument, \od,

	\dur,Pseq(~phase4.abs,1),
\n1,PdegreeToKey(Pseq(~n4,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az1,inf),
	\el1,Pseq(~el1,inf),
	\az2,Pseq(~az2,inf),
	\el2,Pseq(~el2,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
e=Pdef(\22, Pbind(\instrument, \ob,

	\dur,Pseq(~phase22.abs,1),
\n1,PdegreeToKey(Pseq(~n22,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az2,inf),
	\el1,Pseq(~el2,inf),
	\az2,Pseq(~az1,inf),
	\el2,Pseq(~el1,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
f=Pdef(\33, Pbind(\instrument, \oc,
	\dur,Pseq(~phase33.abs,1),
\n1,PdegreeToKey(Pseq(~n33,inf),Scale.mixolydian),
		\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
	\az1,Pseq(~az2,inf),
	\el1,Pseq(~el2,inf),
	\az2,Pseq(~az1,inf),
	\el2,Pseq(~el1,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
g=Pdef(\44, Pbind(\instrument, \od,
	\dur,Pseq(~phase44.abs,1),
\n1,PdegreeToKey(Pseq(~n44,inf),Scale.mixolydian),
	\out,Pn(Pshuf([0, 1, 2, 3], 1), inf).clump(4).collect([_]),
		\az1,Pseq(~az2,inf),
	\el1,Pseq(~el2,inf),
	\az2,Pseq(~az1,inf),
	\el2,Pseq(~el1,inf),
	\buffer1,Pseq([0,1,2,3],inf),
	\buffer2,Pseq([0,1,2,3],inf),
	\decay,Pbrown(2,8,1,inf);
));
)
(
b.play;
//s.record(numChannels:4)
//)
//(
c.play;
//s.record(numChannels:4)
//)
//(
d.play;
e.play;
//s.record(numChannels:4)
//)
//(
f.play;
//s.record(numChannels:4)
//)
//(
g.play;
s.record(numChannels:4)
)

(
Tdef.new(\h,{loop({

	b.play;
c.play;
d.play;
	(1).wait;
		bb.play;
cc.play;
dd.play;


	}
)})
)


Tdef(\h).stop;
Tdef(\h).play;
Tdef(\h).clear;
