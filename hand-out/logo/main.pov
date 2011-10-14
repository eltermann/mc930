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
//#declare cav = < 1.00, 0.00, 0.00 >; //Frontal view
#declare cav = < 14.00*clock, 7.00*(1-clock), 6.00*(1-clock) >;
#declare dst = 13.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

// Directions array (only direction matters)
#declare dir = array[8];
#declare dir[0] = <+1, +1, +1>;
#declare dir[1] = <+1, +1, -1>;
#declare dir[2] = <+1, -1, +1>;
#declare dir[3] = <+1, -1, -1>;
#declare dir[4] = <-1, +1, +1>;
#declare dir[5] = <-1, +1, -1>;
#declare dir[6] = <-1, -1, +1>;
#declare dir[7] = <-1, -1, -1>;

// Distance that characters come from (our "infinite")
#declare dist = 10;

// Aux macro
#macro format_char(c)
  text {
    ttf "times.ttf" c
    0.3, 0
    rotate <0, 0, 90>
    rotate <0, 90, 0>
    scale 1.8
  }
#end

// Character
#macro char(c, posi, posf, frac)
  // {c} = Character
  // {posi} = Initial position
  // {posf} = Final position
  // {frac} = Fraction (0 to 1) of path already traveled

  #local pos = (1-frac)*posi + (frac*posf);
  object {
    format_char(c)
    translate pos
  }
#end

// Logo
#macro logo(txt, time)
  #local len = strlen(txt);
  #local stage = int(len * time);
  #local frac = (len * time) - stage;

  // Final position (current + 1)
  #local posf = <0, stage+1, 0>;

  // Initial position
  #local i = mod(stage, 8);
  #local posi = posf + (dist * vnormalize(dir[i]));

  union {
    #local j = 0;
    #while (j < stage)
      // Call char macro, but with frac=1
      char(substr(txt, j+1, 1), <0,0,0>, <0, j, 0>, 1)
      #local j = j + 1;
    #end

    object {
      char(substr(txt, j+1, 1), posi, posf, frac)
    }
  }
#end


// Scene description
union {

  object {
    logo("UNICAMP", clock)
  }

  texture {
    pigment { color rgb < 0.65, 0.80, 0.95 > }
    finish { diffuse 0.9 ambient 0.1 }
  }

  translate <0, -5, 0>
}
