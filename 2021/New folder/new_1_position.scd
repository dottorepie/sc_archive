


(
var x, y, a, freq, pos, xc, yc, zc;  x=1; a=1; y=(x+a)/x;
"freq".postln;
freq=Complex(x,y).abs.postln;
"pos".postln;
pos=Complex(x,freq).abs.postln;
"z".postln;
zc=Complex(pos,freq).abs.postln;
"x".postln;
xc=Complex(zc,freq).abs.postln;
"y".postln;
yc=Complex(pos,zc).abs.postln;
)



sound=PanAz.ar(numChans:lines,in:tone,pos:point,level:gain,width:group);



x = Complex(x1,y).abs;
y = Complex(x2,y).abs;
z = Complex()


//////////////////////////////////////////////////////////////////////////////duration/sweep
s.options.device_("ASIO : ASIO4ALL v2");
TempoClock.default.tempo_(120/60);
s.options.numOutputBusChannels=8

play({PanAz.ar(24,WhiteNoise.ar(),LFSaw.ar(MouseY.kr(0.1,10560)))});
///////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////


"point_x".postln;
	point_x=left.linlin(0,20,0,2).postln;
	"point_y".postln;
	point_y=right.linlin(0,20,0,2).postln;

	lineZ= PanAz.ar(numChans:height,in:tone,pos:point_z);
	Out.ar(z_bus,lineZ);
	lineX1= PanAz.ar(numChans:width,in:InFeedback.ar(z_bus),pos: point_x);
	Out.ar(x_bus,lineX1);
	lineY1=PanAz.ar(numChans:length,in:InFeedback.ar(x_bus),pos: point_y);
	Out.ar(y_bus,lineY1);
	lineY2=PanAz.ar(numChans:length,in:InFeedback.ar(x_bus+1),pos:point_y);
	Out.ar(y_bus+4,lineY2);
