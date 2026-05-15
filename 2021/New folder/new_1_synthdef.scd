/////SynthDef  uno
(SynthDef(\r0,{
	var fundamental=100, frequency=1, x=0, y=0, a=MouseY.kr(1,10), 	gain=1,
	duration=16, bend=(-4),  envelope=1, tone,
	signal0=0, signal,
	height=1, length=4, width=2,
	partials=10,
	z_bus=8, x_bus=9, y_bus=0,
	right, left, z,
	position,
	point_x=0, point_y=0, point_z=0,
	lineZ, lineX1, lineY1, lineY2;

	signal0=SinOsc.ar(fundamental,mul:gain);
	partials.do{ x=x+1; y = (x+a)/x; frequency=Complex(x,y).magnitude.postln; signal=SinOsc.ar( fundamental*frequency, mul: gain/frequency); signal0=signal0 +signal};

	duration=(duration/1);
	envelope=EnvGen.kr(Env.new([0,0.9,0.6,0.6,0], [duration], [bend]),doneAction:2);
	tone=signal0*envelope;

	"position".postln;
	position = Complex(x,frequency).abs.postln;
	"z".postln;
	z=Complex(position,frequency).abs.postln;
	"left".postln;
	left=Complex(z,frequency).abs.postln;
	"right".postln;
	right=Complex(position,z).abs.postln;

	"point_x".postln;
	point_x=left.linlin(0,20,0,2).postln;
	"point_y".postln;
	point_y=right.linlin(0,20,0,2).postln;

	lineZ= PanAz.ar(numChans:height,in:tone,pos:point_z);
	Out.ar(z_bus,lineZ);
	lineX1= PanAz.ar(numChans:width,in:InFeedback.ar(z_bus),pos: point_x);
	Out.ar(x_bus,lineX1);
	lineY1=PanAz.ar(numChans:length,in:InFeedback.ar(x_bus),pos: point_y*MouseX.kr(1,2));
	Out.ar(y_bus,lineY1);
	lineY2=PanAz.ar(numChans:length,in:InFeedback.ar(x_bus+1),pos:point_y*MouseX.kr(1,2));
	Out.ar(y_bus+4,lineY2);

}).add)

k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=11;
////////////////////////////////////////////////////////////SynthDef  udue
(SynthDef(\r0,{
	var fundamental, frequency=1, x=0, y1=0,y2=0, a, gain=1,
	duration=16, bend=(-3),  envelope=1, tone,
	signal0=0, signal,
	height=1, length=4, width=2,
	partials=3, radius=10,
	z_bus=8, x_bus=9, y_bus=0,
	right, left, z,
	position, octave =1, amp,
	point_x=0, point_y=0, point_z=0,
	lineZ, lineX1, lineY1, lineY2;
	"fundamental".postln;  fundamental = (radius/partials);
	fundamental =(fundamental *220).postln; ////could be midicps and a the octave up down without affect to cps
	a= octave;    partials=partials*1;
	signal0=SinOsc.ar(fundamental,mul:gain);
	partials.do{
		x=x+1;
		y1 = ((x+a)/x);
		y2 = (gain/x);
		frequency=(fundamental/y1).postln;
		"amp".postln;    amp=(gain*y2).postln;
		signal=SinOsc.ar( frequency, mul: amp);
		signal0=signal0 +signal};

	"duration".postln;
	duration=Complex(x,y1).abs.postln;
	duration=(duration/10);
	envelope=EnvGen.kr(Env.new([0,0.9,0.6,0.6,0], [duration], [bend]),doneAction:2);
	tone=signal0*envelope;

	"position".postln;
	position = Complex(x,y2).abs.postln;
	Out.ar(0,tone!2);
}).add)

k.free;
k = Synth.new(\r0);
s.record(numChannels:2);
s.options.sampleRate =48000;
s.options.device_("ASIO : ASIO4ALL v2");
s.options.numOutputBusChannels=12;