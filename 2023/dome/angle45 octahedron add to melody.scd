s.options.sampleRate = 44100;
s.options.numBuffers = 1024*4;
s.options.numRGens=64*1;
s.options.numWireBufs=64*1;
s.options.numInputBusChannels=0;
s.options.outputStreamsEnabled.postln
s.options.device_("USB Sound Device");
s.record(numChannels:4) ;

({Out.ar(2,SoundIn.ar(0))}.play;
s.record(numChannels:4)

s.options.numWireBufs = 1024*32;

s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
s.reboot;
~a= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/l.wav");
~b= Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/r.wav");
b=Buffer.read(s,path:"/Users/petrostatsiopoulos/Desktop/m.mp3");
b.play
(
SynthDef.new(\o, {
	arg n1=1, n2=1, n3=1,speed1=0.01, speed2=0.01, speed3=0.01, cf=8;
	var frequency, note1, note2, note3, detune;
	var envelope, envelopex, envelopey, envelopez;
	var osc_1, osc_2, osc_3;
	var over1, over2, over3, over4, m;
	var bank, angle, scale;
    var fundamental;
	var v=343;
	var freq;
	var freq1;
	var l1;
	var l11;
	var l2;
	var l22;
	var f2;
	var f22;
	var modamp1,modamp2;

	over1=1;
	over2=2;
	over3=3;
	over4=4;
	m=0;
	frequency=1;
	bank=100;
	angle=0;
	detune=1;

	freq =BufRateScale.kr(0);
	freq1 =BufRateScale.kr(1);
	l1=(v/freq);
	l11=(v/freq1);
	l2=l1/28;
	l22=l11/28;
	f2=(v/l2);
	f22=(v/l22);
	modamp1=1;
	modamp2=1;
scale=modamp1.reciprocal;
	bank.do {
		angle=(angle+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);
	detune=exp(Complex(0,1)*angle);

		osc_1 = FreqShift.ar(PlayBuf.ar(1,0,freq),PlayBuf.ar(1,0,f2)*modamp1,phase:0.degrad);

		osc_2 =FreqShift.ar(PlayBuf.ar(1,1,freq1),freq:PlayBuf.ar(1,1,f22)*modamp2,phase:45.degrad);
	};
        Out.ar(0,osc_1*scale);
		Out.ar(1,osc_2*scale);
}).add;
)


Synth.new(\o);

///

((4*128)-1)*((4*128)/2);
////////////////////////////////////////\\\\\\\\\\\\\\\\\\\\\\\/////////////////\\\\\\\\\\\\\\\/////////////////
