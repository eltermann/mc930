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

// Bit
#macro bit(value, bug)
  #if (bug = 1)
    box { 
      <-0.2, -0.2, +0.2>, 
      <+0.2, +0.2, -0.2> 
      //color rgb < 1, 0, 0 >
    }
  #else
    #if (value = 0)
      #local z_pos = -0.25;
    #else
      #local z_pos = +0.25;
    #end
    sphere {
      <0, 0, z_pos>, 0.50

    }
  #end
#end

// Row
#macro row(n_bits, decimal_value)
  #local i = n_bits;

  object {
    union {
      // Row bits
      #while (i != 0)
        object {
          bit(mod(decimal_value, 2), 0)
          translate <0, 2*i, 0>
        }
        #local decimal_value = int(decimal_value/2);
        #local i = i - 1;
      #end
      // Row base
      box { 
        <-1, 2*n_bits + 1, -0.75>, 
        <+1, 0, -0.75 -0.08> 
        //color rgb < 0, 0, 0 >
      }
    }
  }
#end

// Abacus
#macro abacus(n_rows, n_bits, decimal_values)
  #local i = 0;
  object {
    union {
      #while (i < n_rows)
        object {
          row(n_bits, decimal_values[i])
          translate <0, 0, -2.3 * i>
        }
        #local i = i + 1;
      #end
    }
  }
#end

// Data array
#declare data = array[5];
#declare data[0] = 23;
#declare data[1] = 123;
#declare data[2] = 7;

// Scene description
object {
  //bit(0, 1)
  
  abacus(3, 6, data)
  translate <0, -7, +3>

  texture { 
    pigment { color rgb < 0.65, 0.80, 0.95 > } 
    finish { diffuse 0.9 ambient 0.1 } 
  }
}
