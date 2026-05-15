(SynthDef.new(\iter1, {
	var temp,freq,ph,ph_new,sum;
	a=1;ph=0pi;sum = SinOsc.ar(220);
	40.do{
		a = a+1;
		freq = (a+1)/a;
		temp = SinOsc.ar( 220*freq, mul: 1/freq);
	sum = sum +temp;
};

Out.ar(0,sum*0.1!2);
}).add;
)

(
k = Synth.new(\iter1);
//s.record(numChannels:2);
)
////////////////////////////////////////////////////////////////////////////////////////////////multiple scales 1
(SynthDef.new(\iter1, { var temp,freq,a=1, sum=0,temp1,freq1,temp2,freq2;
	6.do{
		freq = (a+1)/a;
		freq1 = (a+2)/a;
		freq2 = (a+3)/a;
		a = a+1;
		temp = SinOsc.ar( 220*freq ,mul: 1/freq);
		temp1 =SinOsc.ar( 220*freq1 ,mul: 1/freq1);
		temp2 =SinOsc.ar( 220*freq2 ,mul: 1/freq2);
	sum = sum +temp+temp1+temp2;
};

Out.ar(0,sum!2);
}).add;
)

(
k = Synth.new(\iter1);
//s.record(numChannels:2);
)

/////////////////////////////////////////////////////////////////////////////////////////////partials and wavetable 2
(SynthDef.new(\iter1, { var temp,freq,a=1, sum=0,temp1,freq1,temp2,freq2;
	300.do{
		freq = (a+1)/a;
		freq1 = (a+2)/a;
		freq2 = (a+3)/a;
		a = a+1;
		temp = Shaper.ar(~tfBuf, SinOsc.ar( 440*freq)*MouseX.kr(0,1),mul: 1/freq);
		temp1 = Shaper.ar(~tfBuf, SinOsc.ar( 440*freq1)*MouseX.kr(0,1),mul: 1/freq1);
		temp2 = Shaper.ar(~tfBuf, SinOsc.ar( 440*freq2)*MouseX.kr(0,1),mul: 1/freq2);
	sum = sum +temp+temp1+temp2;
};

Out.ar(0,sum!2);
}).add;
)

(
k = Synth.new(\iter1);
//s.record(numChannels:2);
)
/////////////////////////////////////////////////////////////////////////////////////partials with sp //// different synths 3

s.options.numOutputBusChannels=12

(SynthDef.new(\iter1_1, {
	var temp,freq,sum,audio0,audio1,audio2,audio3,audio4,audio5,audio6,audio7,audio8,audio9,audio10,audio11,f=1;
	a=1;sum = SinOsc.ar(220);
	3.do{
		a = a+1;
		freq = (a+1)/a;
		temp = SinOsc.ar( 220*freq, mul: 1/freq);
	sum = sum +temp;
		sum = sum*0.1;
};
	audio0 = PanAz.ar(12,sum,LFSaw.ar(f*(2/1)),width:3);audio1 = PanAz.ar(12,sum,LFSaw.ar(f*(3/2)),width:3);
	audio2 = PanAz.ar(12,sum,LFSaw.ar(f*(4/3)),width:3);audio3 = PanAz.ar(12,sum,LFSaw.ar(f*(5/4)),width:3);
	audio4 = PanAz.ar(12,sum,LFSaw.ar(f*(6/5)),width:3);audio5 = PanAz.ar(12,sum,LFSaw.ar(f*(7/6)),width:3);
	audio6 = PanAz.ar(12,sum,LFSaw.ar(f*(8/7)),width:3);audio7 = PanAz.ar(12,sum,LFSaw.ar(f*(9/8)),width:3);
	audio7 = PanAz.ar(12,sum,LFSaw.ar(f*(10/9)),width:3);audio9 = PanAz.ar(12,sum,LFSaw.ar(f*(11/10)),width:3);
	audio10 = PanAz.ar(12,sum,LFSaw.ar(f*(12/11)),width:3);audio11 = PanAz.ar(12,sum,LFSaw.ar(f*(13/12)),width:3);
	Out.ar(0,audio0);Out.ar(1,audio1);Out.ar(2,audio2);
	Out.ar(3,audio3);Out.ar(4,audio4);Out.ar(5,audio5);
	Out.ar(6,audio6);Out.ar(7,audio7);//Out.ar(8,audio8);
	Out.ar(9,audio9);Out.ar(10,audio10);Out.ar(11,audio11);
}).add;
)

(
k = Synth.new(\iter1_1);
//s.record(numChannels:2);
)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////partials  4
(SynthDef.new(\iter, {
	var temp,freq,ph,ph_new,sum;
	a=1;ph=0pi;sum = SinOsc.ar(220);
	2.do{
		a = a+1;
		freq = ((a^2)+1)/a;
		temp = SinOsc.ar( 220*freq, mul: 1/freq);
	sum = sum +temp;
};

Out.ar(0,sum*0.1!2);
}).add;
)

(
k = Synth.new(\iter);
//s.record(numChannels:2);
)
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////complex(final version epifanies) 5
(SynthDef.new(\iter_c, {
	var temp,freq,freq1,temp1,sum=0,sum1=0,a,b,c,d,fundamental=100;
	a=2;
	b=1;
	c=4;
	d=1;
	3.do{a=a+1; b=b +1; freq=Complex(a,b).magnitude.postln; temp=SinOsc.ar( fundamental*freq, mul: 1/freq); sum=sum +temp;};
	3.do{c= c+1; d=d+1; freq1=Complex(c,d).abs.postln; temp=SinOsc.ar( fundamental*freq1, mul: 1/freq1); sum=sum +temp; };
Out.ar(0,sum); Out.ar(0,sum1);
}).add;
)
k.free;
(
k = Synth.new(\iter_c);
//s.record(numChannels:2);
)

s.options.sampleRate =48000
(
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=2;
TempoClock.default.tempo_(120/60);
MIDIClient.init;
MIDIIn.connectAll;
)////////////////////////////////////////////////////////////// 6 drum


(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,x=0,y=0,fundamental=55;
	a=MouseX.kr(1,6).poll;
	sum=SinOsc.ar(fundamental,mul:1);
	//////if a is to be above 6 or 5 then the scale of mouse x has to be also harmonic as the total frequency and not linear
	3.do{
		x=x+1;
		y = (x+a)/x;
		freq=Complex(x,y).magnitude.postln;
		temp=SinOsc.ar( fundamental*freq, mul: 1/freq);
		sum=sum +temp};
	Out.ar(0,sum*(1/2));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2);
)
k.free;
/////////////////////////////////////////////////////////7 string


(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,x=0,y=0,fundamental=120,amp,gain=1,octave=1;
	a= octave;
	sum=0;
	//////if a is to be above 6 or 5 then the scale of mouse x has to be also harmonic as the total frequency and not linear
	32.do{
		x=x+1;
		"y".postln;
		y = ((x+a)/x).postln;
		"freq".postln;
		//this version of freq works as a kind of filter to the more airy, noise sounding fundamental*y
		freq=((x+y)/y).postln;
		"amp".postln;
		temp=SinOsc.ar( fundamental*freq, mul: 1/freq);
		sum=sum +temp};
	Out.ar(0,sum*(1/10));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2);
)
k.free;
//////////////////9 drum reverse
(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,x=0,y=0,fundamental=100,amp,gain=1,octave=1;
	a= octave;
	sum=0;
	//////if a is to be above 6 or 5 then the scale of mouse x has to be also harmonic as the total frequency and not linear
	12.do{
		x=x+1;
		"y".postln;
		y = ((x+a)/x).postln;
		"freq".postln;
		freq=(y+x/y).postln;
		"amp".postln;
		amp=((y+a)/x).postln;
		temp=SinOsc.ar( fundamental*freq, mul: gain/amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/100));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2);
)
k.free;

/////////////////////////////////////////////////8 drum.2


(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,x=0,y=0,fundamental=440,amp,gain=1,octave=1;
	a= octave;
	sum=0;
	//////if a is to be above 6 or 5 then the scale of mouse x has to be also harmonic as the total frequency and not linear
	5.do{
		x=x+1;
		"y".postln;
		y = ((x+a)/x).postln;
		"freq".postln;
		freq=(Complex(y,x).abs/y).postln;
		"amp".postln;
		amp=((y+a)/x).postln;
		temp=SinOsc.ar( fundamental*freq, mul: gain/amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/100));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2);
)
k.free;

// ////////////////////////////////////////////////////////////////////////////////////////////// 10(if not complex then 'noise')
(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,x=0,y=0,fundamental,amp,gain=1/2,octave=1,radiai=8,partials=4;
	"fundamental".postln;
	fundamental = (radiai/partials).postln;
	fundamental = fundamental * MouseY.kr(100,100000); ////could be midicps and a the octave up down without affect to cps
	a= octave;
	sum=0;
	partials.do{
		x=x+1;
		y = ((x+a)/x);
		"freq".postln;     freq=(fundamental/y).postln;
		"amp".postln;    amp=((y+gain)/y).postln;
		temp=SinOsc.ar( freq, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/10));
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2);
)
//////////////////////////////////////////////////////////////////////////11 amp and freq on same graph //ORGAN// octave as notes
(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=1,radiai=8,partials=4;

	"fundamental".postln;  fundamental = (radiai/partials).postln;
	fundamental =fundamental*1000; ////could be midicps and a the octave up down without affect to cps
	a= octave;      sum=SinOsc.ar(fundamental,mul:1);      partials=partials;
	partials.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = (gain/(gain+x));
		"freq".postln;     freq=(fundamental/y1).postln;
		"amp".postln;    amp=(gain*y2).postln;
		temp=SinOsc.ar( freq, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum*(1/2));
}).add;
)
k.free
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)
///////////////////////////////////as wave  fundamental as notes

(SynthDef.new(\iter_d, {
	var temp,freq=1,sum=0,
	x=0,y1=0,y2=0,
	fundamental,amp,
	gain=1,octave=2,radiai=16,partials=8;

	"fundamental".postln;  fundamental = (radiai/partials).postln;
	fundamental =fundamental *110; ////could be midicps and a the octave up down without affect to cps
	a= octave;      sum=SinOsc.ar(fundamental,mul:1);      partials=partials;
	partials.do{
		x=x+1;
		y1 = (gain/x);
		y2 = ((x+a)/x);
		"freq".postln;     freq=(fundamental/y1).postln;
		"amp".postln;    amp=(y1).postln;
		temp=SinOsc.ar( freq*y2, mul: amp);
		sum=sum +temp};
	Out.ar(0,sum);
}).add;
)
(
k = Synth.new(\iter_d);
//s.record(numChannels:2) ;
)




