(
var data;
var az=0,el=0,rad=0,d;

data = 20000.collect{

		az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

	rad=(rad+(360-(360/1.6180339887499))).wrap(1000.neg,1000);

	d=Spherical(rad,az,el).asCartesian.asArray;
};

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
////////////////////////////////
(
var data;
var az=0,el=0,rad=0;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,r,d,m=1,rot,sph;

r=[0,0,1000];
v=Quaternion(0,r.[0].neg,r.[1],r.[2]);
angle=(360-(360/1.6180339887499));

data = 20000.collect{

		az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

	rad=(rad+(360-(360/1.6180339887499))).wrap(1000.neg,1000);

	sph=Spherical(1,az,el).asCartesian;

	rot=[sph.x,sph.y,sph.z];

	i=Quaternion(0, rot.[0], 0, 0);
	j=Quaternion(0, 0, rot.[1], 0);
	k=Quaternion(0, 0, 0, rot.[2]);

		q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	    v=q*v*q.conjugate;

	d=Cartesian(v.b.round(0.0001)*m,v.c.round(0.0001)*m,v.d.round(0.0001)*m).asArray;

};

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
var data;
var az=0,el=0,rad=0;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,r,d,m=1,rot,sph,az1,el1,rot1,dd,i1,j1,k1,q1,v1,r1;

r=[0,0,1];
r1=[0,0,1000];
v=Quaternion(0,r.[0],r.[1],r.[2]);
v1=Quaternion(0,r1.[0],r1.[1],r1.[2]);
angle=(360-(360/1.6180339887499));

data = 20000.collect{

		az=(az+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el=(el+(360-(360/1.6180339887499))).wrap(90.neg,90);

	rad=(rad+(360-(360/1.6180339887499))).wrap(1000.neg,1000);

	sph=Spherical(1,az,el).asCartesian;

	rot=[sph.x,sph.y,sph.z];

	i=Quaternion(0, rot.[0], 0, 0);
	j=Quaternion(0, 0, rot.[1], 0);
	k=Quaternion(0, 0, 0, rot.[2]);

		q=(cos(angle.degrad)+(sin(angle.degrad)*(i+j+k)));
	    v=q*v*q.conjugate;
	az1=v.c.round(0.000001).linlin(1.neg,1,180.neg,180);
	el1=v.c.round(0.000001).linlin(1.neg,1,90.neg,90);

	d=Spherical(1,az1,el1).asCartesian;

	rot1=[d.x,d.y,d.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v1=q1*v1*q1.conjugate;

	dd=Cartesian(v1.b.round(0.0001)*m,v1.c.round(0.0001)*m,v1.d.round(0.0001)*m).asArray;

};

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
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 20000.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 20000.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

)



(
var data;
var az=0,el=0,rad=0;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,r,d,m=1,rot,sph,az1,el1,rot1,dd,i1,j1,k1,q1,v1,r1,pl=0,daz,del;

r=[0,0,1];
r1=[0,0,1000];
v=Quaternion(0,r.[0],r.[1],r.[2]);
v1=Quaternion(0,r1.[0],r1.[1],r1.[2]);
angle=(360-(360/1.6180339887499));

data = 20000.collect{

	az=~az.[pl];
	el=~el.[pl];
	pl=pl+1;

	rad=(rad+(360-(360/1.6180339887499))).wrap(1000.neg,1000);

	sph=Spherical(1,az,el).asCartesian;

	az1=sph.z.round(0.000001).linlin(1.neg,1,180.neg,180);
	el1=sph.z.round(0.000001).linlin(1.neg,1,90.neg,90);

	d=Spherical(1,az1,el1).asCartesian;

	rot1=[d.x,d.y,d.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v1=q1*v1*q1.conjugate;

	dd=Cartesian(v1.b.round(0.0001)*m,v1.c.round(0.0001)*m,v1.d.round(0.0001)*m).asArray;

};

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
var  angle=((360-(360/1.6180339887499))),q1,q2,v2,v3,r,m=1,sph1,sph2,rot1,rot2;
var i1,j1,k1,i2,j2,k2,az,el,az1=0,el1=0,az2=0,el2=0;

r=[0,0,1].normalizeSum;

v2=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);
v3=Quaternion(0,r.[0].sqrt,r.[1].sqrt,r.[2].sqrt);

~az = 20000.collect{

		az1=(az1+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el1=(el1+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph1=Spherical(1,az1,el1).asCartesian;

	rot1=[sph1.x,sph1.y,sph1.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

		q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v2=q1*v2*q1.conjugate;

	az=Cartesian(v2.b.round(0.00001),v2.c.round(0.00001),v2.d.round(0.00001)).theta.raddeg

	};

~el = 20000.collect{

		az2=(az2+(360-(360/1.6180339887499))).wrap(180.neg,180);

	el2=(el2+(360-(360/1.6180339887499))).wrap(90.neg,90);

	sph2=Spherical(1,az2,el2).asCartesian;

	rot2=[sph2.x,sph2.y,sph2.z];

	i2=Quaternion(0, rot2.[0], 0, 0);
	j2=Quaternion(0, 0, rot2.[1], 0);
	k2=Quaternion(0, 0, 0, rot2.[2]);

		q2=(cos(angle.degrad)+(sin(angle.degrad)*(i2+j2+k2)));
	    v3=q2*v3*q2.conjugate;

	el=Cartesian(v3.b.round(0.00001),v3.c.round(0.00001),v3.d.round(0.00001)).phi.raddeg

	};

)



(
var data;
var az=0,el=0,rad=0;
var i = Quaternion(0, (1/3).sqrt, 0, 0),j = Quaternion(0, 0, (1/3).sqrt,0),k = Quaternion(0, 0, 0, (1/3).sqrt);
var q,v,angle=0,r,d,m=1,rot,sph,az1,el1,rot1,dd,i1,j1,k1,q1,v1,r1,pl=0,daz,del,harm,daz1,del1,dd1;

r=[0,0,1];
r1=[0,0,600];
v=Quaternion(0,r.[0],r.[1],r.[2]);
v1=Quaternion(0,r1.[0],r1.[1],r1.[2]);
angle=(360-(360/1.6180339887499));

data = 20000.collect{

	az=~az.[pl];
	el=~el.[pl];
	pl=pl+1;

	rad=(rad+(360-(360/1.6180339887499))).wrap(1000.neg,1000);

	sph=Spherical(1,az,el).asCartesian;

	az1=sph.z.round(0.000001).linlin(1.neg,1,180.neg,180);
	el1=sph.z.round(0.000001).linlin(1.neg,1,90.neg,90);

	d=Spherical(1,az1,el1).asCartesian;

	rot1=[d.x,d.y,d.z];

	i1=Quaternion(0, rot1.[0], 0, 0);
	j1=Quaternion(0, 0, rot1.[1], 0);
	k1=Quaternion(0, 0, 0, rot1.[2]);

q1=(cos(angle.degrad)+(sin(angle.degrad)*(i1+j1+k1)));
	    v1=q1*v1*q1.conjugate;

	dd=Cartesian(v1.b.round(0.0001)*m,v1.c.round(0.0001)*m,v1.d.round(0.0001)*m);

	daz=Cartesian(v1.b.round(0.0001)*m,v1.c.round(0.0001)*m,v1.d.round(0.0001)*m).theta;

	del=Cartesian(v1.b.round(0.0001)*m,v1.c.round(0.0001)*m,v1.d.round(0.0001)*m).phi;

	dd1=dd.mirrorX;

	harm=Spherical(Complex(dd1.x,dd.x).abs,daz,del).asCartesian.asArray


};

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