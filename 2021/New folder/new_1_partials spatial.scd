//////////////from partial_new_1
//////////////////////////////////////////////////////////////////////////11 amp and freq on same graph //ORGAN// octave as notes
(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=1,radiai=8,partials=2;

	"fundamental".postln;  fundamental = (radiai/partials).postln;
	fundamental =fundamental *220; ////could be midicps and a the octave up down without affect to cps
	a= octave;      sum=SinOsc.ar(fundamental,mul:1);      partials=partials*4;
	partials.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = (gain/x);
		"freq".postln;     freq=(fundamental/y1).postln;
		"amp".postln;    amp=(gain*y2).postln;
		temp=SinOsc.ar( freq, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/2));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)
///////////////////////////////////as wave  fundamental as notes

(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,sig,audio,fm,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=2,partials=4;

	"fundamental".postln; fundamental =440.postln;
	a=octave;
	sum=Out.ar(0,PanAz.ar(2,SinOsc.ar(fundamental,mul:1),LFNoise1.ar(1)));
	fm = SinOsc.ar(fundamental,mul:100);
	partials.do{
		x=x+1;
		y1 = ((gain+x)/gain);
		y2 = ((x+a)/x);
		"freq".postln;freq=(fundamental/y2).postln;
		"amp".postln;amp=(gain/y1).postln;
		temp=SinOsc.ar(freq+fm,mul: amp);
		sig = PanAz.ar(2,temp,LFNoise1.ar(y1));
		audio = Out.ar(0,sig);
		sum=sum +audio;

	};
	Out.ar(0,sum);
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)
/////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////
s.options.numOutputBusChannels=12;


play({SinOsc.ar(330+SinOsc.ar(1,mul:100))})


