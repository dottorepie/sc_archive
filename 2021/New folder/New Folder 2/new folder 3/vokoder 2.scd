{Out.ar(0,SoundIn.ar(0)!2)}.play



(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,a=1;
	var x=0,y1;
	var fundamental,amp;
	sum=PitchShift.ar(SoundIn.ar(0),0.01,pitchRatio:0,mul:1/1);
	3.do{
		x=x+1;
		y = ((x+a)/x).postln;
		temp=PitchShift.ar(SoundIn.ar(0),0.01,pitchRatio:y.linlin(1,2,0,4),mul:1/y);
		sum=sum +temp};
	Out.ar(0,sum!2);
}).add;
)


(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)

s.options.numInputBusChannels=1