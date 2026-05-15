~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:2 );
~c4 = Buffer.readChannel(s,,channels:3 );
~c5 = Buffer.readChannel(s,,channels:0 );
~c6 = Buffer.readChannel(s,,channels:1 );
~c7 = Buffer.readChannel(s,,channels:2 );
~c8 = Buffer.readChannel(s,,channels:3 );

(
{Out.ar(PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c5.bufnum, BufRateScale.kr(~c5.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c6.bufnum, BufRateScale.kr(~c6.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c7.bufnum, BufRateScale.kr(~c7.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(PlayBuf.ar(1, ~c8.bufnum, BufRateScale.kr(~c8.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)


