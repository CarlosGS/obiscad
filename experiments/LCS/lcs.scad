// Local Coordinate System implementation

use <obiscad/vector.scad>
include <lcs_autosave.scad>

echo(tofile="lcs_autosave.scad","// Auto-generated file\n",append=false);

TRANSF_NONE = 0;
TRANSF_TRANSLATE = 1;

$transformations = [[TRANSF_NONE,[]]];

module echo_transform_stack() {
	echo("TRANFORM STACK:");
	for ( i = [0:len($transformations)-1] ) {
		assign (transf = $transformations[i], transf_type = transf[0], transf_params = transf[1]) {
			if (transf_type == TRANSF_TRANSLATE) {
				echo(str("translate(",transf_params[0],")"));
			} else if (transf_type == TRANSF_NONE) {
				echo("none()");
			} else {
				echo(str("UNKNOWN: ",transf));
			}
		}
	}
}

module apply_lcs(transforms,index=0) {
	if(index < len(transforms)) {
		assign (transf = transforms[index]) {
			assign (transf_type = transf[0], transf_params = transf[1]) {
				if (transf_type == TRANSF_TRANSLATE) {
					echo(str("translate(",transf_params[0],")"));
					translate_lcs(transf_params[0]) apply_lcs(transforms,index=index+1) children();
				} else if (transf_type == TRANSF_NONE) {
					echo("none()");
					apply_lcs(transforms,index=index+1) children();
				} else {
					echo(str("UNKNOWN: ",transf));
					apply_lcs(transforms,index=index+1) children();
				}
			}
		}
	} else {
		echo("done!");
		children();
	}
}

module translate_lcs(v) {
	prev = $transformations;
	transf_step = [TRANSF_TRANSLATE, [v]];
	$transformations = concat(prev,[transf_step]);
	translate(v) children();
}

module save_current_lcs(name) {
	echo(tofile="lcs_autosave.scad",str(name," = ",$transformations,";\n"));
}

translate_lcs([10,0,0])
save_current_lcs("lcs1");

apply_lcs(lcs1)
translate_lcs([0,10,0])
save_current_lcs("lcs2");

apply_lcs(lcs2)
translate_lcs([0,0,10])
save_current_lcs("lcs3");

apply_lcs(lcs3)
translate_lcs([10,0,0])
{
save_current_lcs("lcs4");
//echo_transform_stack();
}

apply_lcs(lcs3)
color("blue") sphere(r=1);

apply_lcs(lcs4)
cube([1,2,3],center=true);

apply_lcs(lcs1)
color("red") sphere(r=1);

apply_lcs(lcs2)
color("green") sphere(r=1);
