Spherical.new(1,(180/4).degrad,(90/2).degrad).z.round(0.000000001)


[1,1,1].normalizeSum.sqrt

0.5.pow(2)+0.5.pow(2)+0.707106781.pow(2)



(
{
	var n1,n2,n3;
	var sig1,sig2,sig3,sig4,sig5,sig6;
	var v,i,j,k,q;
	var pitch1, pitch2, pitch3;
	var pitch, fund=440;
	var xyz,xyz_array,axis;
	var angle=0.degrad;

	angle=MouseX.kr(180.neg,180);

	xyz=Spherical(1,angle.degrad,(90/2).degrad);
	xyz_array=[xyz.x.round(0.000001),xyz.y.round(0.000001),xyz.z.round(0.000001)].postln;


v=Quaternion(0,0,0,1);

i=Quaternion(0, xyz_array.[0], 0, 0); j=Quaternion(0, 0, xyz_array.[1], 0); k=Quaternion(0, 0, 0, xyz_array.[2]);

	axis=(i+j+k);

q=((axis*exp(Complex(0,1)*90.degrad).imag)+exp(Complex(0,1)*90.degrad).real);

v=q*v*q.conjugate;

	pitch=Cartesian(v.b,v.c,v.d);

	n1=(pitch.x*10).round(1).poll; n2=(pitch.y*10).round(1); n3=(pitch.z*10).round(1);

	pitch1=2.pow(n1/12);
	pitch2=2.pow(n2/12);
	pitch3=2.pow(n3/12);

	sig1=SinOsc.ar(fund*pitch1,0,mul:pitch1.reciprocal);
	sig2=SinOsc.ar(fund*pitch2,0,mul:pitch1.reciprocal);
	sig3=SinOsc.ar(fund*pitch3,0,mul:pitch1.reciprocal);

	sig4=SinOsc.ar(fund*pitch1,90.degrad,mul:pitch1.reciprocal);
	sig5=SinOsc.ar(fund*pitch2,90.degrad,mul:pitch2.reciprocal);
	sig6=SinOsc.ar(fund*pitch3,90.degrad,mul:pitch3.reciprocal);

	Out.ar(0,sig1);Out.ar(0,sig2);Out.ar(0,sig3);
	Out.ar(1,sig4);Out.ar(1,sig5);Out.ar(1,sig6);

}.play;
)