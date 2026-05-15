(
~c1 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/1.wav");
~c2 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/+2.wav");
~c3 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/+4.wav");
~c4 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/2.wav");
~c5 = Buffer.read(s,"/Users/petrostatsiopoulos/Desktop/4.wav");
)




(
{Out.ar(0,PlayBuf.ar(2, ~c1.bufnum, BufRateScale.kr(~c1.bufnum), loop: 0, doneAction:0)*1/1)}.play;
{Out.ar(0,PlayBuf.ar(2, ~c2.bufnum, BufRateScale.kr(~c2.bufnum), loop: 0, doneAction:0)*1/2)}.play;
{Out.ar(0,PlayBuf.ar(2, ~c3.bufnum, BufRateScale.kr(~c3.bufnum), loop: 0, doneAction:0)*1/4)}.play;
{Out.ar(0,PlayBuf.ar(2, ~c4.bufnum, BufRateScale.kr(~c4.bufnum), loop: 0, doneAction:0)*2/1)}.play;
{Out.ar(0,PlayBuf.ar(2, ~c5.bufnum, BufRateScale.kr(~c5.bufnum), loop: 0, doneAction:0)*4/1)}.play;
s.record
)