


///////this function has to be evaluated each time to produce different outcome
(
var x,y;
x =3; y=5;
r =Complex(x,y);
r.real = x;
r.imag = y;
r.abs;
)

////////////////////magnitude
(var z, x, y;
x=1;
y=1;
z=(x.cubed + y.cubed);
z=z.sqrt
)

///is same as
Complex(1,1).abs
/////////////////////////////////////////////////////

a = play({SinOsc.ar(Complex(MouseX.kr(100,400),MouseY.kr(100,400)).magnitude.poll)})
a.free


(
var z,x,y;
z=Complex(2,1).magnitude.postln;

y=Complex(z,2).magnitude.postln;

x=Complex(1,z).magnitude.postln;
)

//////////////////////////////___

( var z, x, y, freq=1,pos=0,dur=2;     x=Complex(freq,pos).abs.postln;     y=Complex(freq,dur).abs.postln;      z=Complex(x,y).abs.postln;)



( var x1=1, x2=2, freq=1,pos,dur;        freq=Complex(x1,x2).abs.postln;       pos=Complex(freq,x1).abs.postln;    dur=Complex(freq,x2).abs.postln;)













