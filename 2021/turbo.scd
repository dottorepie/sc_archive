{LFPulse.ar(300000,add:SinOsc.ar(MouseX.kr(1,440),mul:1))}.play


{ HPF.ar(LFPulse.ar(300000,add:SinOsc.ar(220)), 1000) }.play;

{SinOsc.ar(440,0.1)}.play


{Out.ar(0,LFPulse.ar(220),1)}.play