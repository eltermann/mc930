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
#declare cav = < cos(clock*2*pi), sin(clock*2*pi), 0.00 >; //Frontal view
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

// Roulette
#declare roulette = seed(417);

// Bit
#macro bit(value, bug)
  // Check value and set bug, if necessary
  #if (value < 0)
    #local bug = 1;
  #end
  #if (value > 1)
    #local bug = 1;
  #end

  #if (bug = 1)
    box { 
      <-0.2, -0.2, +0.2>, 
      <+0.2, +0.2, -0.2> 
    }
  #else
    #local z_pos = (value - 0.5) / 2;
    sphere {
      <0, 0, z_pos>, 0.50
    }
  #end
#end

// Row
#macro row(n_bits, decimal_value, prob)
  object {
    union {
      // Row bits
      #local i = n_bits;
      #local r = int(decimal_value);
      #local f = decimal_value - r;

      #while (i != 0)
        object {
          // Find out if this bit will be buggy
          #if (rand(roulette) < prob)
            #local bug = 1;
          #else
            #local bug = 0;
          #end

          #if (mod(r, 2) = 0)
            // display fractional value
            bit(f, bug)
            #local f = 0;
          #else
            bit(1-f, bug)
          #end
          translate <0, 2*i, 0>
        }
        #local r = int(r/2);
        #local i = i - 1;
      #end

      // Row base
      box { 
        <-1, 2*n_bits + 1, -0.75>, 
        <+1, 0, -0.75 -0.08> 
      }
    }
  }
#end

// Abacus
#macro abacus(n_rows, n_bits, decimal_values, prob)
  #local i = 0;
  object {
    union {
      #while (i < n_rows)
        object {
          row(n_bits, decimal_values[i], prob)
          translate <0, 0, -2.3 * i>
        }
        #local i = i + 1;
      #end
    }
  }
#end

// Data array
#declare data = array[3];
#declare data[0] = clock*50 + (1-clock)*20;
#declare data[1] = clock*1 + (1-clock)*0;
#declare data[2] = 6;

// Scene description
object {
  abacus(3, 6, data, 0)
  translate <0, -7, +3>

  texture { 
    pigment { color rgb < 0.65, 0.80, 0.95 > } 
    finish { diffuse 0.9 ambient 0.1 } 
  }
}
