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
 * Interpol
 */
#macro interpol(t0, v0, t1, v1, inst)
  #local ss = (inst - t0) / (t1 - t0);
  #local rr = 1 - ss;
  (rr * v0 + ss * v1)
#end

/**
 * Interpol 4
 */
#macro interpol4(t0, v0, v1, v2, v3, t3, inst)
  #local v01 = interpol(t0, v0, t3, v1, inst);
  #local v12 = interpol(t0, v1, t3, v2, inst);
  #local v23 = interpol(t0, v2, t3, v3, inst);
  #local v012 = interpol(t0, v01, t3, v12, inst);
  #local v123 = interpol(t0, v12, t3, v23, inst);
  #local v0123 = interpol(t0, v012, t3, v123, inst);

  v0123
#end

/**
 * Graph
 */
#macro graph(x0, y0, y1, y2, y3, x3, N)
  #local i = 0;
  #local frac = (x3 - x0) / N;

  union {
    #while (i < N)
      #local xx = x0 + (i * frac);
      #local yy = interpol4(x0, y0, y1, y2, y3, x3, xx);
      sphere { < 0, xx, yy > 0.05 }
      #local i = i + 1;
    #end
  }
#end

/**
 * Complex Graph
 */
#macro complex_graph(x0, y_init, y_final, y_values, x3, M, N)
  #local j = 0;
  #local x_frac = (x3 - x0)/M;
  
  union {
    #while (j < M)
      #local j2 = 2 * j;

      // Defining Y0
      #if (j = 0)
        // If first graph
        #local y0 = y_init;
      #else
        #local y0 = (y_values[j2-1] + y_values[j2])/2;
      #end

      // Defining Y1 and Y2
      #local y1 = y_values[j2];
      #local y2 = y_values[j2+1];

      // Defining Y3
      #if (j = M - 1)
        // If last graph
        #local y3 = y_final;
      #else
        #local y3 = (y_values[j2+1] + y_values[j2+2])/2;
      #end

      #local xx0 = x0 + j * x_frac;
      #local xx3 = x0 + (j+1) * x_frac;
      graph(xx0, y0, y1, y2, y3, xx3, int(N/M))

      // Update loop variable
      #local j = j + 1;
    #end
  }
#end

#declare M = 4;
#declare MM = 2 * M;
#declare y_values = array[MM];
#declare y_values[0] = -5;
#declare y_values[1] = 6;
#declare y_values[2] = 3;
#declare y_values[3] = 0;
#declare y_values[4] = 5;
#declare y_values[5] = -3;
#declare y_values[6] = 0;
#declare y_values[7] = 0;

/**
 * Scene description
 */
union {
  object{ eixos(7.00) }
  //object { graph(0, 0, 5, -3, 2, 10, 50) }
  object { complex_graph(0, 1, 1, y_values, 15, M, 100) }
  translate <0, -5, 0>
}
