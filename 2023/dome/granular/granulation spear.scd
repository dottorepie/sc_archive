s.boot;

e.play
e.numFrames;
e.numChannels;
e.duration;
numSamples = numFrames * numChannels
e.numFrames * e.numChannels
e.sampleRate
s.sampleRate
e.query

e = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/seql.wav");
k = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/seqr.wav");




TempoClock.default.tempo_(120/120);


(
{
var sig1,sig2, winenv,z;

winenv = Env.perc(0.01,10);

z = Buffer.sendCollection(s, winenv.discretize, 1);

sig1 = Out.ar(0,GrainBuf.ar(
	2,
	Dust.ar(72),
	4,
	k.bufnum,
	1,
		LFDNoise1.ar(72).range(0,1),
	2,
		-1,
	-1,
	512
	));
	sig2 = Out.ar(0,GrainBuf.ar(
	2,
	Dust.ar(72),
	4,
	e.bufnum,
	1,
		LFDNoise1.ar(72).range(0,1),
	2,
		1,
	-1,
	1000
	));

}.play
)

48000/72
 GrainBuf.ar(2, Impulse.kr(10), 0.1, sndbuf, LFNoise1.kr.range(0.5, 2),
            LFNoise2.kr(0.1).range(0, 1), 2, pan, envbuf) * env)

((4*32)-1)*((4*32)/2);
4*8


//////////////////////////////////////
(
SynthDef.new(\sword, { arg frame
	var e,k,sig1,sig2

	e = Buffer.read(s,);
k = Buffer.read(s,);

	sig1 = FreeVerb.ar(LPF.ar(GrainBuf.ar(
	2,
	Dust.ar(1),
	4,
	k.bufnum,
	1,
		LFDNoise1.ar(frame).range(0,1),
	2,
		-1,
	z,
	512
	),440*10),room:scale.linlin(0,k.numFrames,0,1));

	sig2 = FreeVerb.ar(LPF.ar(GrainBuf.ar(
	2,
	Dust.ar(1),
	4,
	e.bufnum,
	1,
		LFDNoise1.ar(frame).range(0,1),
	2,
		1,
	z,
	512
),440*10),room:scale.linlin(0,frame,0,1);

		Out.ar(0,sig1);
		Out.ar(0,sig2);

	};



}).add;
)


