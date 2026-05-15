
(
a= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/1.wav");
b= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/2.wav");
c= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/3.wav");
d= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/4.wav");
e= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/5.wav");
f= Buffer.readChannel(s,channels:0,path:"/Users/petrostatsiopoulos/Desktop/6.wav");
)
(
SynthDef(\play,{
var sig1,sig2,sig3,sig4,sig5,sig6;
	sig1=PlayBuf.ar(1,0,BufRateScale.kr(0),loop:inf);
	sig2=PlayBuf.ar(1,1,BufRateScale.kr(0),loop:inf);
	sig3=PlayBuf.ar(1,2,BufRateScale.kr(0),loop:inf);
	sig4=PlayBuf.ar(1,3,BufRateScale.kr(0),loop:inf);
	sig5=PlayBuf.ar(1,4,BufRateScale.kr(0),loop:inf);
	sig6=PlayBuf.ar(1,5,BufRateScale.kr(0),loop:inf);
	Out.ar(0,sig1*2);
	Out.ar(1,sig2*2);
	Out.ar(2,sig3*2);
	Out.ar(3,sig4*2);
	Out.ar(4,sig5*2);
	Out.ar(5,sig6*2);
}).add;
)
Synth.new(\play);

////////////////////////////////////////
(
a= Buffer.readChannel(s,channels:0,path:);
b= Buffer.readChannel(s,channels:1,path:);
c= Buffer.readChannel(s,channels:2,path:);
d= Buffer.readChannel(s,channels:3,path:);
e= Buffer.readChannel(s,channels:4,path:);
f= Buffer.readChannel(s,channels:5,path:);
)
(
SynthDef(\play,{
var sig1,sig2,sig3,sig4,sig5,sig6;
	sig1=PlayBuf.ar(1,0,BufRateScale.kr(0),loop:inf);
	sig2=PlayBuf.ar(1,1,BufRateScale.kr(0),loop:inf);
	sig3=PlayBuf.ar(1,2,BufRateScale.kr(0),loop:inf);
	sig4=PlayBuf.ar(1,3,BufRateScale.kr(0),loop:inf);
	sig5=PlayBuf.ar(1,4,BufRateScale.kr(0),loop:inf);
	sig6=PlayBuf.ar(1,5,BufRateScale.kr(0),loop:inf);
	Out.ar(0,sig1*2);
	Out.ar(1,sig2*2);
	Out.ar(2,sig3*2);
	Out.ar(3,sig4*2);
	Out.ar(4,sig5*2);
	Out.ar(5,sig6*2);
}).add;
)
Synth.new(\play);



(Synth.new(\voc))
s.options.memSize = 2097152
s.options.numOutputBusChannels=6;
TempoClock.default.tempo_(120/30);
ServerOptions.inDevices.postln;
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("Aggregate Device");
s.options.memSize = 524288
s.options.memSize
s.options.memSize
s.options.numInputBusChannels=0
s.record(numChannels:6) ;
