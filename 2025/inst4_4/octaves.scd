(
s.options.numBuffers=1024*2;
s.options.numWireBufs = 1024*4;
s.options.numOutputBusChannels=8;
s.options.numInputBusChannels=0;
s.options.memSize = 8192*128*2;
s.options.blockSize = 64;
s.options.maxNodes = 1024 * 16;
s.options.sampleRate= 44100;
s.options.maxSynthDefs=1024*16;
s.waitForBoot;
)


(
~c1 = Buffer.readChannel(s,,channels:0 );
~c2 = Buffer.readChannel(s,,channels:1 );
~c3 = Buffer.readChannel(s,,channels:2 );
~c4 = Buffer.readChannel(s,,channels:3 );
)
(
~c1a = Buffer.readChannel(s,,channels:0 );
~c2a = Buffer.readChannel(s,,channels:1 );
~c3a = Buffer.readChannel(s,,channels:2 );
~c4a = Buffer.readChannel(s,,channels:3 );
)
(
~c1b = Buffer.readChannel(s,,channels:0 );
~c2b = Buffer.readChannel(s,,channels:1 );
~c3b = Buffer.readChannel(s,,channels:2 );
~c4b = Buffer.readChannel(s,,channels:3 );
)
(
~c1c = Buffer.readChannel(s,,channels:0 );
~c2c = Buffer.readChannel(s,,channels:1 );
~c3c = Buffer.readChannel(s,,channels:2 );
~c4c = Buffer.readChannel(s,,channels:3 );
)
(
~c1c = Buffer.readChannel(s,,channels:0 );
~c2c = Buffer.readChannel(s,,channels:1 );
~c3c = Buffer.readChannel(s,,channels:2 );
~c4c = Buffer.readChannel(s,,channels:3 );
)

(
{Out.ar(0,PlayBuf.ar(1, ~c1.bufnum, BufRateScale.kr(~c1.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2.bufnum, BufRateScale.kr(~c2.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3.bufnum, BufRateScale.kr(~c3.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4.bufnum, BufRateScale.kr(~c4.bufnum),startPos:0, loop: 0, doneAction:2))}.play;
)
(
{Out.ar(0,PlayBuf.ar(1, ~c1a.bufnum, BufRateScale.kr(~c1a.bufnum),startPos:0, loop: 0, doneAction:2)*(1/2))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2a.bufnum, BufRateScale.kr(~c2a.bufnum),startPos:0, loop: 0, doneAction:2)*(1/2))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3a.bufnum, BufRateScale.kr(~c3a.bufnum),startPos:0, loop: 0, doneAction:2)*(1/2))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4a.bufnum, BufRateScale.kr(~c4a.bufnum),startPos:0, loop: 0, doneAction:2)*(1/2))}.play;
)
(
{Out.ar(0,PlayBuf.ar(1, ~c1b.bufnum, BufRateScale.kr(~c1b.bufnum),startPos:0, loop: 0, doneAction:2)*(1/4))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2b.bufnum, BufRateScale.kr(~c2b.bufnum),startPos:0, loop: 0, doneAction:2)*(1/4))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3b.bufnum, BufRateScale.kr(~c3b.bufnum),startPos:0, loop: 0, doneAction:2)*(1/4))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4b.bufnum, BufRateScale.kr(~c4b.bufnum),startPos:0, loop: 0, doneAction:2)*(1/4))}.play;
)
(
{Out.ar(0,PlayBuf.ar(1, ~c1c.bufnum, BufRateScale.kr(~c1c.bufnum),startPos:0, loop: 0, doneAction:2)*(1/8))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2c.bufnum, BufRateScale.kr(~c2c.bufnum),startPos:0, loop: 0, doneAction:2)*(1/8))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3c.bufnum, BufRateScale.kr(~c3c.bufnum),startPos:0, loop: 0, doneAction:2)*(1/8))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4c.bufnum, BufRateScale.kr(~c4c.bufnum),startPos:0, loop: 0, doneAction:2)*(1/8))}.play;
)
(
{Out.ar(0,PlayBuf.ar(1, ~c1d.bufnum, BufRateScale.kr(~c1d.bufnum),startPos:0, loop: 0, doneAction:2)*(1/16))}.play;
{Out.ar(1,PlayBuf.ar(1, ~c2d.bufnum, BufRateScale.kr(~c2d.bufnum),startPos:0, loop: 0, doneAction:2)*(1/16))}.play;
{Out.ar(2,PlayBuf.ar(1, ~c3d.bufnum, BufRateScale.kr(~c3d.bufnum),startPos:0, loop: 0, doneAction:2)*(1/16))}.play;
{Out.ar(3,PlayBuf.ar(1, ~c4d.bufnum, BufRateScale.kr(~c4d.bufnum),startPos:0, loop: 0, doneAction:2)*(1/16))}.play;
)