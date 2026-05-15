Env([-1,0,1],[(1*((3/2)-(4/3))),(1*((3/2)-(4/3)))],[-5,5]).plot;//.asSignal(1024+1).plot
Env.sine.plot;


~b0 = Buffer.alloc(s,2048);
~tf = Env([-1,0,1],[0.1,0.1],[-10,10]).asSignal(1025);
~tf.plot;
~tf = ~tf.asWavetableNoWrap;
~tfBuf = Buffer.loadCollection(s,~tf);~b0.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(220)*Line.kr(0,1,10),mul:1)}.play;



////////////wavetable for position oscillations



wavetable synthesis
b = Buffer.alloc(s,2048);
(
var env, sig, wt;
env = Env([0,0.6,-0.9,0.3,0],[4,3,2,1],\lin);
sig = env.asSignal(length:1024);
wt = sig.asWavetable;
b.loadCollection(wt);
)
b.plot;
{Osc.ar(b,MouseX.kr(10,10000,1)*[1,2.01],mul:0.2!2)}.play;
