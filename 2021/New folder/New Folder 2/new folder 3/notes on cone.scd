(
	var x=1;
	var sig1,sig2,sig3,sig4;
	var sum1=0;
    var z1,z2;

{
	32.do{

		x=x+1;
		z1=(x+1)/x;
		sig1=FSinOsc.ar(z1*6*100,mul:0.1/z1);
		sig2=FSinOsc.ar(z1*8*100,mul:0.1/z1);
		sig3=FSinOsc.ar(z1*9*100,mul:0.1/z1);
		sig4=FSinOsc.ar(z1*12*100,mul:0.1/z1);
		sum1=sum1+sig1+sig2+sig3+sig4;
		Out.ar(0,PanAz.ar(2,sum1,LFSaw.ar(z1),width:2));

}}.play
)


(var z,y,x=1,k;
{32.do{
	x=x+1;
	y=1/x;
	k=Complex(x,y).angle;
	Out.ar(0,SinOsc.ar(y*2000,mul:1/x,iphase:pi)!2)
}}.play)



(
{
	var m=0;
	100.do{
		m=m+1;
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*3*40,mul:1/(3*m)),LFSaw.ar(1/3*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*4*40,mul:1/(4*m)),LFSaw.ar(1/4*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*6*40,mul:1/(6*m)),LFSaw.ar(1/6*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*8*40,mul:1/(8*m)),LFSaw.ar(1/8*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*9*40,mul:1/(9*m)),LFSaw.ar(1/9*m)));
		Out.ar(0,PanAz.ar(2,SinOsc.ar(m*12*40,mul:1/(12*m)),LFSaw.ar(1/12*m)));

	}
}.play)