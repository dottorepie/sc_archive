(
var a;
a=Complex.new(0,1).pow(2).theta
)

exp(Complex.new(0,1)*2.pow(48/12))

exp(Complex.new(0,1)*(137.5*2))


exp(Complex.new(0,1)*1).theta




exp(Complex.new(0,1)*1.618033)


	(
var a;
a=exp(Complex.new(0,1)*(137.5*2)).real
)




(var an=0,pan,pa;
10.do{
	 an=an+137.5;
		pan=an.wrap(0,360);
		pa=exp(Complex.new(0,1)*an);
	pa.postln;
};
)