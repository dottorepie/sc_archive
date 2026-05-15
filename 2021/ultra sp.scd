







s.options.numOutputBusChannels=8;

s.options.device_("ASIO : ASIO4ALL v2");





////////////////////////////////////////////////////shaper
//with shaper you need to use +1 in the buffer length and NoWrap in wavetable placement
b = Buffer.alloc(s,2048);
a= Buffer.readChannel(s,bufnum:1,channels:1,path:"C:/Users/petro/Music/untitledbach.wav");
{PlayBuf.ar(1,1,BufRateScale.kr(1))}.play;
(
~tf = Env([-1,0,1],[1,1],[64,-64]).asSignal(1024+1);
~tf = ~tf.asWavetableNoWrap;
)
~tf.plot;
~tf.size;
~tfBuf = Buffer.loadCollection(s,~tf);b.numFrames;







{Shaper.ar(~tfBuf, SinOsc.ar(20000+SinOsc.ar(20,mul:MouseX.kr(1,1000))))*0.2!2}.play


{Shaper.ar(~tfBuf, SinOsc.ar(40000+PlayBuf.ar(1,1,BufRateScale.kr(1))))}.play
//////////
