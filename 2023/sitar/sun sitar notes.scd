 {Out.ar(0,PanAz.ar(3,WhiteNoise.ar(0.1),pos:-1,width:2,orientation:0))}.play



(Env.new([0,1,0],[4,4],curve:\sine)).plot


(Env.new([0,1,0,1,0],[2],curve:\sine)).plot

(Env.new([0,0.5,1,0,1,0],[0.01,1,2,2,2],curve:\sine)).plot




(Env.new([0,1,0,-1,0],[2],curve:[-4,4])).plot///////////0

(Env.new([0,1,0,-1,0,1],[0.01,2,2,2,2],curve:[-4,4])).plot




(Env.new([0,0,1,0,-1,0],[2,2,2,2],curve:[4,-4])).plot////////////90
(Env.new([0,0,1,0,-1,0],[1,2,2,2,2],curve:[4,-4])).plot//////////////45





{PanAz.ar(3, WhiteNoise.ar(0.1), pos: 1.65, level: 1.0, width: 2.0, orientation: 0.5)}.play

Complex.new(1,1).phase
Complex.new(045).phase.degrad
Complex.new(90,45).phase.degrad



(
{Pan2.ar(SinOsc.ar(220,0.degrad),SinOsc.ar(0.1,0.degrad))}.play;
{Pan2.ar(SinOsc.ar(220,90.degrad),SinOsc.ar(0.1,90.degrad))}.play;
)
Cartesian.new(0,0,1).theta
Cartesian.new(0,0,1).phi
Cartesian.new(0,1,0).theta
Cartesian.new(0,1,0).phi
Cartesian.new(1,0,0).theta
Cartesian.new(1,0,0).phi


Spherical.new(1,45,45).tilt
Cartesian.new(1,1,0).tilt.asCartesian
Cartesian.new(1,0,1).phi
Cartesian.new(0,1,1).theta

Spherical

(
(
{Out.ar(0,SinOsc.ar(220,Cartesian.new(1,1,0).phi,1))}.play;
{Out.ar(0,SinOsc.ar(220,Cartesian.new(1,1,0).theta,1))}.play;
);

(
{Out.ar(1,SinOsc.ar(220,Cartesian.new(1,0,1).phi,1))}.play;
{Out.ar(1,SinOsc.ar(220,Cartesian.new(1,0,1).theta,1))}.play;
)
)