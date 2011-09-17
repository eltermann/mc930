/**
 * Author: Felipe Eltermann (RA 070803)
 */

// camera and light source
#include "camlight.inc"
#declare ctr = < 0.00, 0.00, 1.00 >;
#declare rad = 6.0;
#declare cav = < 14.00, 7.00, 4.00 >;
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)

// background
background { color rgb < 1.00, 1.00, 1.00 > }
