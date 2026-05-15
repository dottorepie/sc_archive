~t= Buffer.alloc(s,2048);

(
{
		var angle=0;
		~angle=(720).collect{
		angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);
		}
		}.value;
		{
var signal,wt,m=0,amp;

~level=90.collect{m=m+1;amp=m.reciprocal};
	~phase=90.collect{~angle.[m].degrad};
signal=Signal.sineFill(1024,~level,~phase);

wt = signal.asWavetable;
~t.loadCollection(wt);
signal.plot;
		}.value;
)


{Osc.ar(~t.bufnum,220)}.play