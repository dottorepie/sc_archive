//////////////////////////////////////////////////////////////////////////////////fft in wavetable///
{PlayBuf.ar(1,0,BufRateScale.kr(0),loop:inf)}.play
~sb= Buffer.readChannel(s,channels:1,path:"C:/Users/petro/Desktop/SC_210105_020901.wav",bufnum:0,numFrames:1024);
~sb.numFrames;


///////
(
~tf = Signal.sineFill(1025,a,a);
 ~sb.loadToFloatArray(action: { arg array;
	var a;
		a = array; {a.plot}.defer; "done".postln;
});
~tf.asWavetableNoWrap;
)

~tf.plot;
~tf.size;
b = Buffer.alloc(s,2048);
~tfBuf = Buffer.loadCollection(s,~tf);~tc.numFrames;
{Shaper.ar(~tf, SinOsc.ar(220)*0.2!2)}.play;

/////////////////////////////////////////////////////

s.options.device_("ASIO : ASIO4ALL v2");

o=s.options

o.memSize;

o.memSize = 2.pow(16);

s.options.numOutputBusChannels=3
///////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////
