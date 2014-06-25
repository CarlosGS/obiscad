use <obiscad/vector.scad>
use <obiscad/attach.scad>

//-- Connector
//--   att. point  att. axis  roll
origin = [ [0,0,0], [0,0,1],   0  ];
%connector(origin);

module arm(n=0) {
//-- Connectors
//--   att. point  att. axis  roll
origin = [ [0,0,0], [0,0,1],   0  ];
//--    att. point  att. axis  roll
a = [ [0,0,20], [0,1,1],   5  ];
%connector(a);
    %frame(l=10);
	cylinder(r=0.25,h=20,$fn=3);
	if(n > 0)
		attach(a,origin)
			arm(n-1);
}

arm(n=20);



//attach(c1,a) arm(debug);
