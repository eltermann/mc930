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

/**
 * Elements declaration
 */

// Robot
#macro robot(col, pos, siz)
  // {col} = color (rgb vector)
  // {pos} = base position (from the beggining of element)
  // {siz} = size

  union {
    object { trunk(pos, siz) }
    texture { pigment { color rgb col } finish { diffuse 0.9 ambient 0.1 } }
  }
#end

// Trunk
#macro trunk(pos, siz)
  #local p1 = pos + < siz/4, -siz/3, 0 >;
  #local p2 = pos + < -siz/4, siz/3, siz >;

  #local head_siz = siz/2;
  #local head_pos = pos + < 0, 0, siz >;
  union {
    box { p1, p2 }
    object { head(head_pos, head_siz) }
  }
#end

// Head
#macro head(pos, siz)
  #local neck_siz = siz/2;

  #local box_pos = pos + < 0, 0, (2/3)*neck_siz >;
  #local box_p1 = box_pos + < siz/2, -siz/2, 0 >;
  #local box_p2 = box_pos + < -siz/2, siz/2, siz >;

  union {
    // Neck
    sphere { pos + neck_siz/2, neck_siz/2 }
    box { box_p1, box_p2 }
  }
#end

/**
 * Scene description
 */
robot(< 0.65, 0.80, 0.95 >, < 0, 0, 0 >, 2)
