(
s.options.numWireBufs = 1024*16;
s.options.numOutputBusChannels=2;
s.options.numInputBusChannels=0;
TempoClock.default.tempo_(120/120);
s.options.memSize = 8192*8;
s.waitForBoot
)


c.free; c = Buffer.read(s, Platform.resourceDir +/+ "sounds/a11wlk01.wav");

c = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/584948__dibko__birds-and-nature-4-channel-recording.wav",channels:1 );


~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/BLEND3.wav",channels:0 );
~c2 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/BLEND tracks and samples/BLEND3.wav",channels:1 );



(
{
    var in1,in2, chainL,chainR, v,b=0,detune1,angle1=0;
    in1 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1), loop: 0);
	 in2 = PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2), loop: 0);
   250.do{  chainL = FFT(LocalBuf(1024), in1);
		chainR = FFT(LocalBuf(1024), in2);

		detune1=exp(Complex(0,1)*(angle1.degrad));

   chainL = chainL.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

		   chainR = chainR.pvcollect(1024, {|mag, phase, index|

        [mag, phase];


    }, frombin: b, tobin: b, zeroothers: 1);

	b=b+1;
		angle1=(angle1+(360-(360/1.61803398874989484820458683436563811772030917980576))).wrap(0,360);

		Out.ar(0,PanAz.ar(2,IFFT(chainL),(detune1.real.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1)));
		Out.ar(0,PanAz.ar(2,IFFT(chainR),(detune1.imag.round(0.0001)+TExpRand.kr(1,10,Dust.kr(5))).wrap(1.neg,1)));
	}
}.play
)

