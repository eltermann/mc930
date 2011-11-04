/**
 * Author: Felipe Eltermann (RA 070803)
 */

/**
 * Camera, light source and background
 */
#include "camlight.inc"
#declare ctr = < 0.00, 0.00, 1.00 >;
#declare rad = 6.0;
#declare cav = < 14.00, 7.00, 6.00 >;
//#declare cav = < 1.00, 0.00, 0.00 >; //Frontal view
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

/**
 * Colors and textures
 */
#declare tx_xadrez =
  texture {
    pigment { checker color rgb < 0.10, 0.32, 0.60 >, color rgb < 1.00, 0.97, 0.90 > }
    finish{ diffuse 0.9 ambient 0.1 }
  }
#declare tx_vidro =
  texture {
    pigment { color rgb < 0.85, 0.95, 1.00 > filter 0.70 }
    finish { diffuse 0.03 reflection 0.25 ambient 0.02 specular 0.25 roughness 0.005 }
  }


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

#macro octaedro()
  #local dist = 1;
  intersection {
    plane { < +1, +1, +1> dist }
    plane { < +1, +1, -1> dist }
    plane { < +1, -1, +1> dist }
    plane { < +1, -1, -1> dist }
    plane { < -1, +1, +1> dist }
    plane { < -1, +1, -1> dist }
    plane { < -1, -1, +1> dist }
    plane { < -1, -1, -1> dist }
  }
#end

// Scene description
union {
  object {
    //dodecaedro()
    octaedro()
    texture { tx_vidro }
  }

  // Floor
  plane {
    <0, 0, -1> 10
    texture { tx_xadrez }
  }
}
