/**
 * Author: Felipe Eltermann (RA 070803)
 */

/**
 * Camera, light source and background
 */
#include "camlight.inc"
#declare ctr = < 0.00, 0.00, 1.00 >;
#declare rad = 10.0;
//#declare cav = < 14.00, 7.00, 6.00 >;
#declare cav = < 1.00, 0.00, 0.00 >; //Frontal view
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

#macro bit(value)
  #if (value = 0)
    #local z_pos = -1;
  #else
    #local z_pos = +1;
  #end
  sphere {
    <0, 0, z_pos>, 0.80
  }
#end

#macro fileira(n_bits, decimal_value)
  #local i = n_bits;

  object {
    union {
      #while (i != 0)
        object {
          bit(mod(decimal_value, 2))
          translate <0, 2*i, 0>
        }
        #local decimal_value = int(decimal_value/2);
        #local i = i - 1;
      #end
    }
  }
#end


object {
  union {
    // object {bit(0) translate <0, 0, 0>}
    // object {bit(1) translate <0, 0, 0>}
    // object {bit(0) translate <0, -4, 0>}
    fileira(6, 6)
  }
  translate <0, -5, 0>
  texture { 
    pigment { color rgb < 0.65, 0.80, 0.95 > } 
    finish { diffuse 0.9 ambient 0.1 } 
  }
}
