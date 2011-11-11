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
#include "eixos.inc"

/**
 * Scene description
 */

#macro interpol(t0, v0, t1, v1, inst)
  #local ss = (inst - t0) / (t1 - t0);
  #local rr = 1 - ss;
  (rr * v0 + ss * v1)
#end

#macro interpol4(t0, v0, v1, v2, v3, t3, inst)
  #local v01 = interpol(t0, v0, t3, v1, inst);
  #local v12 = interpol(t0, v1, t3, v2, inst);
  #local v23 = interpol(t0, v2, t3, v3, inst);
  #local v012 = interpol(t0, v01, t3, v12, inst);
  #local v123 = interpol(t0, v12, t3, v23, inst);
  #local v0123 = interpol(t0, v012, t3, v123, inst);

  v0123
#end

#macro graph(x0, y0, y1, y2, y3, x3, N)
  #local i = 0;
  #local frac = (x3 - x0) / N;
  
  object {
    union {
      #while (i < N)
        #local xx = x0 + (i * frac);
        #local yy = interpol4(x0, y0, y1, y2, y3, x3, xx);
        sphere { < 0, xx, yy > 0.05 }

        #local i = i + 1;
      #end
    }
  }
  
#end

union {
  object{ eixos(3.00) }
  object { graph(0, 1, 1, 1, 1, 10, 50) }
  translate <0, -5, 0>
}
