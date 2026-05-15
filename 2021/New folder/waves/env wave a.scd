b = Buffer.alloc(s,2048);
a = Buffer.alloc(s,2048);
(
(
~tf = Env([-1,0,1],[(1*((3/2)-(4/3))),(1*((3/2)-(4/3)))],[-128,128]).asSignal(1024+1);
//~tfa = Env([-1,0,1],[(2*((3/2)-(4/3))),(2*((3/2)-(4/3)))],[6,-6]).asSignal(1024+1);
~tf = ~tf.asWavetableNoWrap;
//~tfa = ~tfa.asWavetableNoWrap;
);
(
//~tf.plot;
//~tf.size;
~tfBuf = Buffer.loadCollection(s,~tf);b.numFrames;
//~tfBufa = Buffer.loadCollection(s,~tfa);a.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(MouseX.kr(1,1000)))*0.2!2}.play;
//{Shaper.ar(~tfBufa, SinOsc.ar(220))*0.2!2}.play;
)
)

///////////////////////////////////////////
(
(
~tf =Env([0,1,0,-1,0],[(1*((3/2)-(4/3)))],[16,-16,16,-16]).asSignal(1024+1);
//~tfa = Env([-1,0,1],[(2*((3/2)-(4/3))),(2*((3/2)-(4/3)))],[6,-6]).asSignal(1024+1);
~tf = ~tf.asWavetableNoWrap;
//~tfa = ~tfa.asWavetableNoWrap;
);
(
//~tf.plot;
//~tf.size;
~tfBuf = Buffer.loadCollection(s,~tf);b.numFrames;
//~tfBufa = Buffer.loadCollection(s,~tfa);a.numFrames;
{Shaper.ar(~tfBuf, SinOsc.ar(MouseX.kr(20,2000)))*0.2!2}.play;
//{Shaper.ar(~tfBufa, SinOsc.ar(220))*0.2!2}.play;
)
)

/////////////////////////////////////////////////////////////////////////////////////
Env([-1,0,1],[(1*((3/2)-(4/3))),(1*((3/2)-(4/3)))],[-5,5]).plot;//.asSignal(1024+1).plot

s.freeAll