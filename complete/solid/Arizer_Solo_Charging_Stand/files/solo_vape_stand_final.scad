$fn=150;

// Charging stand for the Arizer Solo vaporizer
// Designed for the power wart that was supplied
// with mine.  The plug into the Solo is straight,
// not a right-angle plug, so it needs a bit of
// room (height) in order to have the cord come out
// the back of the stand.

// This model is not very well paramaterized.
// Changes may throw off rest of code, so check
//  carefully if you change this too far.
// Someday I'll do a better parameterization, but
// this was my third or fourth openscad model.
//
// Robert Wallace   final: 10/07/15

base_thick = 29; // thickness of base under the vape cutout
                 // (or how high the base is above 0)
                 
ht = base_thick + 5;  // how much flange sticks above base
pad = .02;  // used to scale = 1+pad


difference()
{
//cylinder(d=dia+5, h=ht+5);
cylinder(d1=dia+22, d2=dia+3,h=ht+5);
  {
  // cutout for vape
  translate([0,0,base_thick])
    scale([1+pad,1+pad,1+pad])
      vape_cutout(ht+5);
 
  // cutout on front for LED viewing
  translate([0,-28,base_thick+18])
    rotate([-90,90,0])
      scale([4,2,1])
        cylinder(d1 =10,d2=8, h=9.5);

  // oval cutout for power plug - but it lets plug move too freely
/* translate([3,-9,-.5]) 
    linear_extrude(height=base_thick+1)
  union()
   {
   translate([4.6,0,0])circle(d=9.2);
   translate([4.6,10,0])circle(d=9.2);
   square([9.2,10]);
   }
*/
  //translate([(9.2/2)+3,-9,0]) cylinder(d=9.2, h=base_thick+1);
 translate([3, -9,-.5]) slantpipe(9.2,base_thick-5,5);


  // "tunnel" for power cord
 translate([7.6,0,.4]) rotate([-90,0,0]) cylinder(d=9.2, h=35); 
 }  // end "union"-style grouping
}  // end difference


// the three cord-keepers
translate([1,25,0]) cylinder(d=15, h=1.75);
translate([14,11,0]) cylinder(d=15, h=1.75);
translate([7.5,-12.5,0]) cylinder(d=15, h=1.75);



/* vape_cutout
 *    creates the shape used to diff out the vape "socket"
 */

dia = 46;   // vape cutout diameter -- don't modify
wid = 36.5;  // vape cutout width -- don't modify
len = 43.6;  // vape cutout length -- don't modify
block_len = 50;  // vape cutout 
block_wid = 10;  // vape cutout
block_ht = 16;   // vape cutout

module vape_cutout(height=15)
{
difference()
{
cylinder(d=dia, h=height);   // the initial cylinder

translate([-(block_len/2),wid/2,-.5])
  cube([block_len,block_wid,height+1]); // top side block   (+y)
translate([-(block_len/2),-block_wid-(wid/2),-.5])
  cube([block_len,block_wid,height+1]); // bot side block  (-y)
translate([len/2,-(block_len/2),-.5])
  cube([block_wid,block_len,height+1]); // rt side block (+x) 
translate([-block_wid-(len/2),-(block_len/2),-.5])
  cube([block_wid,block_len,height+1]); // lt side block (-x)
}
}


/* slantpipe
 *   highly hand-tweaked shape used to cut out the
 *   slanting channel for the power cord and plug
 */

module slantpipe(m_dia=9.2, m_ht = 35, m_ht2 = 5)
{
difference()
 {
 hull()
 {
 // top object
 translate([m_dia/2,0,m_ht]) sphere(d=m_dia);
 
 // bottom object (hull source grouping)
  {
  translate([m_dia/2,0,0]) sphere(d=m_dia);
  translate([m_dia/2,m_dia,0])sphere(d=m_dia);
  } // end hull source grouping
 }  // end hull

 // clip off the top and bottoms of spheres
 translate([-.5,-5,-5]) cube([m_dia+1,20,5]);//bottom
 translate([-.5,-5,m_ht+(m_dia/4)]) cube([m_dia+1,20,5]);//top

 }   // end difference
// add stovepipe section to top
translate([m_dia/2,0,m_ht-.1]) cylinder(d=m_dia, h=m_ht2+1);
}   // end module