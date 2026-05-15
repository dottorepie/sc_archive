(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(MouseX.kr(110,440),0.degrad,1),SinOsc.ar(MouseY.kr(110,440),mul:1/2)))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(440,90.degrad,1),SinOsc.ar(MouseY.kr(110,440),mul:1/2)))}.play;
)


(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(220,0.degrad,1),SinOsc.ar(MouseY.kr(110,220))))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(220,90.degrad,1),SinOsc.ar(MouseY.kr(110,220))))}.play;

{Out.ar(0,PanAz.ar(2,SinOsc.ar(220*1.5,0.degrad,1),SinOsc.ar(MouseY.kr(110,220))))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(220*1.5,90.degrad,1),SinOsc.ar(MouseY.kr(110,220))))}.play;

)





(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(MouseX.kr(110,440),0.degrad,1),SinOsc.ar(440,mul:1/2)))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(MouseY.kr(110,440),90.degrad,1),SinOsc.ar(440,mul:1/2)))}.play;
)


(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(110,0.degrad,1),SinOsc.ar(MouseY.kr(110,440)),width:1,orientation:0))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(110,90.degrad,1),SinOsc.ar(MouseY.kr(110,440)),width:1,orientation:0))}.play;
)



{Out.ar(0,PanAz.ar(4,WhiteNoise.ar(0.1),SinOsc.ar(MouseX.kr(0.1,100) ,mul:MouseY.kr(0.1,1)),width:2))}.play;


s.options.numOutputBusChannels=4

//////////////////////////////////////////////////////////////////////////






(
{Out.ar(0,PanAz.ar(2,SinOsc.ar(440,0.degrad,mul:1),SinOsc.ar(55,mul:1/2)))}.play;
{Out.ar(0,PanAz.ar(2,SinOsc.ar(440,90.degrad,mul:1),SinOsc.ar(55,mul:1/2)))}.play;
)























