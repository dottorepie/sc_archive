
(
var phase, angle=0;
4.do{
phase=exp(Complex(0,1)*angle.degrad).theta;
	angle=(angle+(90)).wrap(0,360);
	phase.linlin(2pi.neg,2pi,1.neg,1).abs.postln;
	angle.postln;
}
)