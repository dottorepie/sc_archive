



//time:/uodu is now in 3/2,6/2 etc, for it to become 4/2 or 5/2 or 7/2 the same value has to be added to the array every thee values for 4/2 or every six values for 7/2, or two same values added every thee values for 5/2 etc
//another alternative for time would be (not from the sphere) [t1,t2,t3,t4...].normalizeSum.sqrt with t.rand(0.999) and *scalar



///tones// tone selection pl1// ifhe are not rounded the intervals are not known(to the ear) and if used as degrees in a scale they are automatically converted to integers, but not rounded means they represent exact spherical coordinates so all are harmonic to each other no matter what sequence they are, a big soup of harmony.
//if rounded they can represent known intervals and correct degrees in a scale but then they are not exact spheric harmonies rather areas one the sphere. Since the tones are made with three oscillators and defined by the x,y,z of a coordinate they are chords of specific 12-tone degrees in a scale, if that is the choice. Therefore since many coordinates are very close to each other there is an area on the sphere of specific diameter, as long as it takes for the value to be roiunded to the next integer, where this chord is the smae for different coordinates, hence tone areas. These areas can be identfied if we take the az and el arrays pass them to a spherical object and the derive the three rounded x,y,x components.
//In this sence since we have a set array of coordinates, by choosing an azimuth and elevation the respective known chord can be selected. If no pre-fixed spherical model is used, then of-course the coordinates and respective initial choice of azimuth and elevation can be whatever and completely random and float.
//So a pattern can be devised to create sequencies of the known chords acoording to need. But first the chords/areas have to be documented and studied for sequential potential.

///the pl1 tone selection has to have as input the coordinate (spherical) and as ouput the chord

///generative swlection pattern can be formed through a randomness seed that will define the generative pattern evolution (seed the golden ratio spheric model?)

///phase of oscillators, phases of coordinates or golen angle sequence.

~seed =10;
(
thisThread.randSeed = ~seed;
4.rand
)
////this is an example of setting a random seed but what about using a sequence as seed for a thread
///in the case of using a sequence as a seed for a pattern it would be like so: (this shuffles a sequence in time)
(
~seed = [1,2,3,4,5];

a= Pshuf(~seed, 20);
b = a.asStream;
20.do({ b.next.postln; });
)
//another example would be to create two arrays of azimuth and elevation points in a constant elevation and azimuth increase eg. down to up (so that locations in the area can be conceptualized in series and choose the coordinate via Pwrand on these area through another array of weights that will point the randomness toward a specific area on the sphere, thus creating an instance of the code that produces some specific locations/chords more than other instances
///in such a case also random motion patterns can be used with lo and high boundaries of az and el (no arrays)
(
var a, b;
a = Pwrand.new([1, 2, 3], [1, 0, 0].normalizeSum, 6);    // return 6 items
b = a.asStream;
7.do({ b.next.postln; });
)
////the weight array can also be a pattern so that the area of choice can change in time
(
~weightStream = Ppatlace([
    Pseq([[1, 0, 0]], 2),
    Pseq([[0, 1, 0]], 2),
    Pseq([[0, 0, 1]], 2)
], 2).asStream;

a =  Pwrand(
        [1,2,3],
        Pfunc({ ~weightStream.next }),
       6
    );
b = a.asStream;
6.do({ b.next.postln; });
)

///another alternative for selection would to use
Pclutch(Pseq([1, 2, 3, 4, 5], 3), Pseq([0, 0, 1, 0, 0, 0, 1, 1])).asStream.nextN(10);
// and an l systme for 0 and 1 to make the progression rather than having the l-system as a pesudo-gate in the basic algorithm// a form of repetition

///considering most of the above the selection pattern could be a combination of these in order:
/// having a pool array of all possible spherical locations--->creating different instance arrays by applying weights on these arrays according to target chords.-->use these weighted arrays as seeds for shufling patterns that will in turn return a generative randomness sequenece of the seed array. All of these can ofcourse be parallel generative processes in one pbind thus making on instance basic algorithm, not many, and a selection of coordinates where the weights, seeds and final shuffled sequences change in time. Thus a final interface for the tone selection would adress which spherical coordinate areas will be weighted, according to sets of chords and how their resulting seeds will be placed in time, For instance it can be a movement from the bottom-half of the sphere to the top-part of the sphere and back again oscillating between these to seed states.
///susch a selection process requires an initial array of spherical coordinates where the linear location of the values on the array can be conceptualized as locations on the sphere so that the weights can be added also linearly on known chord areas and progressions, otherwise conditional logic is required.
//for example the elevation array progresses from bottom to top linearly and the azimuth array progresses with certain amount of points for each elevation progression, which in turn can be acceses linearly from eg. 180 to -180 degrees.

///such an array would look like so (no golden angle)/// golden angle information can be added later as phases to the oscillators
///with simpler arrays like these it simpler to categorize the chord locations and access the coordinates linearly, otherwise a math formula must be devised to able to extract from the more complex (golden ratio angle) spherical location array, sets of its coordinates corespondent to concrete locations on the sphere, or a table of the categorized locations. Since this is bery time consuming for the time being the following solution is put forth. For rounded value tones to scales, a simple periodic spherical model will be used, and the golden angle as phase. If the tones are to be used unrounded in the 12-tone system with no scales, with the inherit harmony of the sphere then the golden angle spherical model will be used (look below, third and second spherical model example) and the selection process will depend solely on this array with no areas or other nestings, just a controlled generative random motion through this array, as all the tones are harmonic to each in theory and there is no need for inherit grouping and specific time sequencing, the sequencing can depend solely on the kind of motion trough the array. Therefore concluding for the tonal system there are two options: to use the inherit harmony of the sphere as sole argument or to round its values and through groupings, scaling, and generative processes to achieve a desired generative musical harmony.
//In the case of the urounded spheric tonal model the change in the tonal model happens through application of spherical harmonics, each harmonics is a different tonal group (stick to z harmonics).


////azimuth increments one degree per 20 degrees and elevation every 10 angle degrees, so there 18 azimuth angles and 18 elevation angles with 8 basic areas: +++, -++, --+, +-+, ++-, -+-, ---, -+- 12
// which map to the array of values as -z from values 0 to 161 and +z from 180 to 342 with 162 to 179 being 0.
//the order of tonic areas is -++,--+,---,-+-,+++,+-+,+--,++- for every elevation, eg. azimuth elevation 90.neg is values 0-18 where 0-4 are -++, 5-9 are --+, 10-13 are --- and, 14 to 18 -+-/// the final table is derived by maping these values of the array for all elevations, to 8 different arrays.
////so in essence for rounded tones there is no need for an initial array as az is simply a selection of multiples of 20 degrees and az a selection of 10 degrees.
///similar approach can be ofcourse applied to the golden angle aperiodic spherical model with two arrays of azimuth and elevation being manipulated through randmnoess nut in this case with the same randomness and seed for both arrays since these two values are entangled.
///////1#completely periodic sphere model
~az.[19]

]
(
var data;
var az=0,el=0,az_rot;
var m=600,sph,az1,el1,pl=0,daz,del,harm,mag,r=1.neg;
var r1,harm1,r2,harm2,rad,call;


data=(18*19).collect{

	az=~az.[pl];
	el=~el.[pl];
	mag=1;
//	mag=
//(Cartesian(~magx.[pl],~magy.[pl],~magz.[pl]).rho/(2.sqrt))+
//	(Cartesian(~qx.[pl],~qy.[pl],~magz.[pl]).rho/(2.sqrt));
	//	Cartesian(~magx.[pl],~magy.[pl],0).rho;
	//	Cartesian(~qx.[pl],~qy.[pl],0).rho;
	pl=pl+1;
		sph=Spherical(mag*400,az,el).asCartesian.asArray;



};
data.postln;

w = Window.new("3D Scatterplot", Rect(40,40, 1000, 800)).front;
a = ScatterView3d(w, Rect(0,0, 800,800), data, [-1000, 1000].asSpec,[-1000, 1000].asSpec,[-1000, 1000].asSpec);
a.drawMethod = \fillRect;
a.symbolSize = 1;
a.symbolColor = Color.white;
a.background = Color.black;

// Y Slider
Slider(w, Rect(820, 10, 10, 450)).action_{|me|
    a.rotY = me.value * 2pi;
    w.refresh;
};
// X Slider
Slider(w, Rect(870, 10, 10, 450)).action_{|me|
    a.rotX = me.value * 2pi;
    w.refresh;
};
// Z Slider
Slider(w, Rect(920, 10, 10, 450)).action_{|me|
    a.rotZ = me.value * 2pi;
    w.refresh;
};

)

(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=90.neg,az2=0,el2=90.neg,az3=0,el3=90.neg,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=90.neg,az5=0,el5=90.neg,az6=0,el6=90.neg,az7=0,el7=90.neg;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg,p1=0,p2=0;
var ellipsis=[1,1,1];
var spread=1,h=90.neg;

	~az=[];~el=[];~qx=[];~qy=[];

19.do{
azimuth=(19).collect{

		az1 = (p1).wrap(180.neg,180);  // Increment azimuth
				el1 = (h).wrap(90.neg,90);
p1=p1+20;
		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);
	};

elevation=(18).collect{

				az2 = (p2).wrap(180.neg,180);  // Increment elevation
			el2 = (h).wrap(90.neg,90);
p2=p2+20;
		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};

////z axis   ambi..  sin for odd numbers, cos for even
	h=h+10;p1=0;p2=0;~az=~az++azimuth;~el=~el++elevation;	};

}.value;
)



//////////////////////////////////spherical model arrays and selection
(var chord,sph,pl1=1;
///sph=Spherical(28,~az.[pl1],~el.[pl1]);
sph=Spherical(28,0.degrad,45.degrad);
chord=[sph.x.round(1),sph.y.round(1),sph.z.round(1)];
chord.postln;
)

////////2#golden angle spherical model with periodic azimuth
(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1],spread=1;
			~az=[];~el=[];~dur=[];

		361.do{
durx=(12).collect{
			azx = (angle+(360*2.pow(plx/12))).wrap(180.neg,180);  // Increment azimuth
				elx = (angle+(180*2.pow(plx/12))).wrap(90.neg,90);
		plx=(plx+1).mod(12);

		sphx=(Spherical(14,(azx.degrad),(elx.degrad))).x.round(1/32);

	};

dury=(12).collect{
		azy = (angle+(360*2.pow(ply/12))).wrap(180.neg,180);  // Increment azimuth
			ely = (angle+(180*2.pow(ply/12))).wrap(90.neg,90);
		ply=(ply+1).mod(12);

		sphy=(Spherical(14,(azy.degrad),(ely.degrad))).y.round(1/32);

	};
durz=(12).collect{
			azz = (angle+(360*2.pow(plz/12))).wrap(180.neg,180);  // Increment azimuth
				elz = (angle+(180*2.pow(plz/12))).wrap(90.neg,90);
		plz=(plz+1).mod(12);

		sphz=(Spherical(14,(azz.degrad),(elz.degrad))).z.round(1/32);

	};

azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))).phi.round(0.00001);

	};

angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;

				12.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];};num=1.neg;};
}.value;

)


(
{
var  sph1,sph2,sph3,sph4,sph5,sph6,sph7,m_x=3,m_y=3,m_z=3,qx,qy,mq=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z,mag_qx,mag_qy;
var az4=0,el4=0,az5=0,el5=0,az6=0,el6=0,az7=0,el7=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx=0,elx=0,azy=0,ely=0,azz=0,elz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
	~dur=[];

durx=(360*8).collect{
			azx = (azx+1).wrap(180.neg,180);  // Increment azimuth
				elx = (elx+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphx=(Spherical(1,(azx.degrad),(elx.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).x.round(0.000000001).abs;

	};

dury=(360*8).collect{
		azy = (azy+1).wrap(180.neg,180);  // Increment azimuth
			ely = (ely+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphy=(Spherical(1,(azy.degrad),(ely.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).y.round(0.000000001).abs;

	};
durz=(360*8).collect{
			azz = (azz+1).wrap(180.neg,180);  // Increment azimuth
				elz = (elz+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sphz=(Spherical(1,(azz.degrad),(elz.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).z.round(0.000000001).abs;

	};

~az=(360*8).collect{

			az1 = (az1+1).wrap(180.neg,180);  // Increment azimuth
				el1 = (el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

~el=(360*8).collect{

				az2 = (az2+1).wrap(180.neg,180);  // Increment azimuth
			el2 = (el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};


				360.do{ num=num+1; ~dur=~dur++durx.[num]++dury.[num]++durz.[num];}
}.value;
)


////////////golden angle sphere example with nested 12-tonal increments of azimuth and elevation

(
{
var  sph1,sph2,sph3,sph4,sph5,m_x=2,m_y=2,m_z=2;
var az1=0,el1=0,az2=0,el2=0,az3=0,el3=0,mag,mag_x,mag_y,mag_z;
var az4=0,el4=0,az5=0,el5=0,pl1=0,pl2=0,pl3=0,pl4=0,pl5=0;
var angle=0,ang=0;
var azimuth,elevation,magnitudex,magnitudey,magnitudez;
var durx,dury,durz;
var sphx,sphy,sphz,azx,elx,azy,ely,azz,elz,plx=0,ply=0,plz=0;
var num=1.neg;
var ellipsis=[1,1,1];
var spread=1;
			~az=[];~el=[];~magx=[];~magy=[];~magz=[];

		360.do{


azimuth=(12).collect{

			az1 = (angle+(360*2.pow(pl1/12))).wrap(180.neg,180);  // Increment azimuth
				el1 = (angle+(180*2.pow(pl1/12))).wrap(90.neg,90);
		pl1=(pl1+1).mod(12);

		sph1=(Spherical(1,(az1.degrad),(el1.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).theta.round(0.00001);

	};

elevation=(12).collect{

				az2 = (angle+(360*2.pow(pl2/12))).wrap(180.neg,180);  // Increment azimuth
			el2 = (angle+(180*2.pow(pl2/12))).wrap(90.neg,90);
		pl2=(pl2+1).mod(12);

		sph2=(Spherical(1,(az2.degrad),(el2.degrad))/Cartesian(ellipsis.normalizeSum.sqrt.[0],ellipsis.normalizeSum.sqrt.[1],ellipsis.normalizeSum.sqrt.[2])).phi.round(0.00001);

	};


};angle=(angle+(360-(360/1.6180339887499))).wrap(0,360);~az=~az++azimuth;~el=~el++elevation;


}.value;
)


