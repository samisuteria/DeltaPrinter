// This Kossel delta printer magnetic arm end was inspired by:
//   http://forum.seemecnc.com/viewtopic.php?f=54&t=1704&p=10703
//
// Use 10mm diameter, 15mm high cylindrical magnets like these:
//   http://www.ebay.com/itm/291100526510
// 
// Use 3/8" chrome plated steel bearings like these:
//   http://www.ebay.com/itm/380140413083
//
// Use .230" diameter carbon fiber rods like these:
//   http://www.tridprinting.com/Mechanical-Parts/#3D-Printer-Rod-Kit
//
// This work is licensed under a Creative Commons Attribution-ShareAlike 4.0
// International License.
// Visit:  http://creativecommons.org/licenses/by-sa/4.0/
//
// This can be printed with a layer height of 0.2mm or 0.1mm.
// Use a shell thickness of 2mm, so that all of the walls will be printed
// with concentric circles, instead of back-and-forth infill.
// For PLA, use a relatively low temperature, like 185C, so that the overhangs
// inside of the ball bearing sockets come out as cleanly as possible.
// I use a 3/8" ball end mill to gently clean out the ball bearing sockets.
//
// Use a Dremel to roughen up a patch on the ball bearings, then use acetone to
// clean the 3mm screws and ball bearings, and use epoxy to join them together.
//
// Alternatively, you can TIG weld the ball bearings to stainless steel M3x10
// SHCS.
//
// I had a bunch of "ball studs" fabricated.  It was essentially the same price
// to manufacture 1000 as it was 50, so I got a bunch!  As a result, I have
// quite a few left over to share with the Delta/Maker community.  I'm offering
// them for $1 each, plus shipping.
//
// This version works with Slic3r.
//
// Note: I have to print out at least two of these at a time, to get the
// correct dimensions.  I usually print out a dozen of the ball bearing,
// holders, followed by another of the rod ends -- ie. I usually don't mix
// them in one print run.
//
// Haydn Huntley
// haydn.huntley@gmail.com

$fa = 1;
$fs = 0.2;

// All measurements in mm.
smidge              = 0.1;
mmPerInch           = 25.4;
minWallWidth        = 1.0;
magnetDiameter      = 10.0;
magnetHeight        = 15.0;
magnetRadius        = (magnetDiameter+4*smidge)/2;
rodDiameter         = 0.230 * mmPerInch;
rodRadius           = (rodDiameter+6*smidge)/2;
ballBearingDiameter = 3/8 * mmPerInch;
ballBearingRadius   = ballBearingDiameter/2;

height              = 35;
magnetOffset        = 3.4; // Can decrease this to 3.4 for more force.
ballBearingOffset   = 1.4;
rodEndLipHeight		= 1;
rodEndHeight        = height + rodEndLipHeight - magnetHeight - magnetOffset;


module ballBearingHolder()
{
	difference()
	{
		// The body.
		cylinder(r=magnetRadius+minWallWidth, h=height);
		
		// Hollow out the inside for the magnet and rod end to slide into.
		translate([0, 0, magnetOffset])
		cylinder(r=magnetRadius, h=height);

		// Make a hole through the center to try to eliminate the badly formed
		// plastic from almost horizontal overhangs.
		cylinder(r=ballBearingRadius*0.60, h=height);

		// Hollow out the socket for the ball bearing to rest in.
		translate([0, 0, -ballBearingOffset])
		sphere(r=ballBearingRadius);
	}
}


module rodEnd()
{
	difference()
	{
		union()
		{
			// To fit inside of the magnet's pocket.
			cylinder(r=magnetRadius-smidge, h=rodEndHeight);

			cylinder(r=magnetRadius-smidge+minWallWidth, h=rodEndLipHeight);
		}
		
		// Space for the rod.
		translate([0, 0, -smidge/2])
		cylinder(r=rodRadius, h=rodEndHeight+smidge);
	}
}


translate([7, 0, 0])
ballBearingHolder();

translate([-7, 0, 0])
rodEnd();

