result = undef;
$lcs = [0,0,0];

function getLCS() = $lcs;
module item() {
	result = $lcs;
	echo(str("LCS_known: ", result));
	cube([10,20,30]);
}

module translate_ok(v) {
	$lcs = $lcs + v;
	//echo(parent_module());
	echo(str("TRANSLATE: ", v));
	echo(str("LCS: ", $lcs));
	translate(v) children();
}
echo(str("LCS_before: ", $lcs));
translate_ok([10,0,0])
translate_ok([0,10,0])
translate_ok([0,0,10])
translate_ok([-5,-5,10])
item();

echo(str("LCS_after: ", result));

a=1;
$b=4;
echo(a);
module test(a) {
$b=3;
}
test(a);
a=2;
echo($b);

echo(getLCS());