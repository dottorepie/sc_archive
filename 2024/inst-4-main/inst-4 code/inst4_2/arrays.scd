{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=1,m_z=1;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;

~az = (90*~time).collect{
	pl1=pl1+1;

		az1=(az1+(1)).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1.degrad*~h.[pl1],el1.degrad*~j.[pl1]).theta.round(0.00001);

	};

~el = (90*~time).collect{
	pl2=pl2+1;

		az2=(az2+(1)).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2.degrad*~h.[pl2],el2.degrad*~j.[pl2]).phi.round(0.00001);

	};

~magx = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);

//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=1,m_y=1,m_z=1;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx1 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy1 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz1 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx2 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy2 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz2 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=3,m_y=3,m_z=3;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx3 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy3 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz3 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=4,m_y=4,m_z=4;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx4 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy4 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz4 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=5,m_y=5,m_z=5;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx5 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy5 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz5 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;

{
var  sph1,sph2,sph3,sph4,sph5,m_x=6,m_y=6,m_z=6;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;


~magx6 = (90*~time).collect{
pl3=pl3+1;
	az3=(az3+(1)).wrap(180.neg,180);

	el3=(el3+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph3=Spherical(1,az3.degrad*~h.[pl3],el3.degrad*~j.[pl3]);


mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;



//mag_x=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_x).wrap(pi.neg,pi))).real).rho*

//		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_x-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


//			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_x).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;


};

~magy6 = (90*~time).collect{
pl4=pl4+1;
	az4=(az4+(1)).wrap(180.neg,180);

	el4=(el4+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph4=Spherical(1,az4.degrad*~h.[pl4],el4.degrad*~j.[pl4]);

	mag_y=(Complex(exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,exp(Complex(0,1)*((sph4.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*Complex(exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph4.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph4.rho;

		/*mag_y=(Complex(exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag,			exp(Complex(0,1)*((sph3.theta.round(0.00001)*m_y).wrap(pi.neg,pi))).imag).rho*

		Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph3.phi.round(0.00001)*(m_y-1)).wrap((pi/2).neg,(pi/2)))).imag).rho*


			Complex(exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph3.phi.round(0.00001)*m_y).wrap((pi/2).neg,(pi/2)))).real).rho)*sph3.rho;*/

};

~magz6 = (90*~time).collect{
pl5=pl5+1;
	az5=(az5+(1)).wrap(180.neg,180);

	el5=(el5+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph5=Spherical(1,az5.degrad*~h.[pl5],el5.degrad*~j.[pl5]);

if(
m_z.even,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).real).rho*sph5.rho,
mag_z=Complex(exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag,exp(Complex(0,1)*((sph5.phi.round(0.00001)*m_z).wrap((pi/2).neg,(pi/2)))).imag).rho*sph5.rho
	);
////z axis   ambi..  sin for odd numbers, cos for even
	};
}.value;
///////////////////////////////////////az///randomizer-difuser

{
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));
var harm1,harn2,harm3;

~az_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

raz1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).theta.round(0.0000000000001);
};

~az_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v2=q2*v2*q2.conjugate;

raz2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).theta.round(0.0000000000001);
};

~az_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v3=q3*v3*q3.conjugate;

raz3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).theta.round(0.0000000000001);
};

}.value;
///////////////////////el
{
var pl1=0,az1,el1,sph1,rot1,i1,j1,k1,q1,raz1,rel1;
var pl2=0,az2,el2,sph2,rot2,i2,j2,k2,q2,raz2,rel2;
var pl3=0,az3,el3,sph3,rot3,i3,j3,k3,q3,raz3,rel3;
var r1=[0,0,1],r2=[1,0,0],r3=[0,1,0];
var v1=Quaternion(0,r1.[0],r1.[1],r1.[2]),v2=Quaternion(0,r2.[0],r2.[1],r2.[2]),v3=Quaternion(0,r3.[0],r3.[1],r3.[2]);
var angle=(360-(360/1.6180339887499));

~el_x=(90*~time).collect{

	az1=~az.[pl1];el1=~el.[pl1];
	pl1=pl1+1;
sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v1=q1*v1*q1.conjugate;

rel1=Cartesian(v1.b.round(0.0001),v1.c.round(0.0001),v1.d.round(0.0001)).phi.round(0.0000000000001);
};

~el_y=(90*~time).collect{

	az2=~az.[pl2];el2=~el.[pl2];
	pl2=pl2+1;
sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

q2=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v2=q2*v2*q2.conjugate;

rel2=Cartesian(v2.b.round(0.0001),v2.c.round(0.0001),v2.d.round(0.0001)).phi.round(0.0000000000001);
};

~el_z=(90*~time).collect{

	az3=~az.[pl3];el3=~el.[pl3];
	pl3=pl3+1;
sph3=Spherical(1,az3,el3).asCartesian;

	rot3=[sph3.x,sph3.y,sph3.z];

	i3=Quaternion(0, rot3.[0], 0, 0);
	j3=Quaternion(0, 0, rot3.[1], 0);
	k3=Quaternion(0, 0, 0, rot3.[2]);

q3=(exp(Complex(0,1)*(angle.degrad)).real+(exp(Complex(0,1)*(angle.degrad)).imag*(i1+j1+k1)));
v3=q3*v3*q3.conjugate;

rel3=Cartesian(v3.b.round(0.0001),v3.c.round(0.0001),v3.d.round(0.0001)).phi.round(0.0000000000001);
};

	}.value;