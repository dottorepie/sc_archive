~c1 = Buffer.readChannel(s,"/Users/petrostatsiopoulos/Desktop/vh.wav",channels:0 );

(
		SynthDef.new(\obin, {

    var b=0;
    var chain1,chain2,chain3,chain4;
	var sig1,sig2,sig3,sig4;
	var in1, in2,in3,in4;
	var bank,frames=1024/2;
	var samplerate=44100;
	var env;

			in1 =PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);
			in2 = PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2);


	chain1 = FFT(LocalBuf(frames), in1);
	chain2 = FFT(LocalBuf(frames), in2);


sig1 =PV_PhaseShift(chain1, 0);
sig2 =PV_PhaseShift(chain2, 90.degrad);


		Out.ar(0,IFFT(sig1));
		Out.ar(1,IFFT(sig2));


}).add;
)

Synth(\obin)