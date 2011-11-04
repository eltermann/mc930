/**
 * Author: Felipe Eltermann (RA 070803)
 */

/**
 * Camera, light source and background
 */
#include "camlight.inc"
#declare ctr = < 0.00, 0.00, 1.00 >;
#declare rad = 10.0;
#declare cav = < 14.00, 7.00, 6.00 >;
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

#macro dodecaedro()
  #local phi = (sqrt(5)-1)/2;
  #local dist = 1;
  intersection {
    // <0 , +-phi, +-1>
    plane { < +0, +phi, +1> dist }
    plane { < +0, +phi, -1> dist }
    plane { < +0, -phi, +1> dist }
    plane { < +0, -phi, -1> dist }

    // <+-phi, +-1, 0>
    plane { < +phi, +1, +0> dist }
    plane { < +phi, -1, +0> dist }
    plane { < -phi, +1, +0> dist }
    plane { < -phi, -1, +0> dist }

    // <+-1, 0, +-phi>
    plane { < +1, +0, +phi> dist }
    plane { < -1, +0, +phi> dist }
    plane { < +1, +0, -phi> dist }
    plane { < -1, +0, -phi> dist }
  }
#end

// Scene description
object {
  dodecaedro()
  texture { 
    pigment { color rgb < 0.65, 0.80, 0.95 > } 
    finish { diffuse 0.9 ambient 0.1 } 
  }
}

