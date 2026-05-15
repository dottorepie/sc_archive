r = Buffer.read(s,"/Users/petrostatsiopoulos/Music/SuperCollider Recordings/h/windhh.wav");


(
{Out.ar(0,FreeVerb.ar(LPF.ar(PlayBuf.ar(2,0,BufRateScale.kr(0)),MouseY.kr(20,20000)),mix:MouseX.kr(0,1),room:1))}.play;
)