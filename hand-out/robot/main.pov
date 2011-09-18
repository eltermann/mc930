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
//#declare cav = < 1.00, 0.00, 0.00 >; Frontal view
#declare dst = 16.0;
#declare lux = 1.00;
camlight(ctr, rad, cav, dst, z, lux)
background { color rgb < 1.00, 1.00, 1.00 > }

/**
 * Elements declaration
 */


// Trunk
#macro trunk(pos, hei)
  // {pos} = position (center of base)
  // {hei} = height
  #local p1 = pos + < hei/4, -hei/3, 0 >;
  #local p2 = pos + < -hei/4, hei/3, hei >;

  box { p1, p2 }
#end

// Neck
#macro neck(pos, hei)
  #local p1 = pos + < hei/2, -hei/2, 0 >;
  #local p2 = pos + < -hei/2, hei/3, hei >;

  box { p1, p2 }
#end

// Head
#macro head(pos, hei, rot)
  #local joint_rad = hei/4;
  #local joint_ctr = pos + < 0, 0, joint_rad>;

  #local p1 = < hei/2, -hei/2, 0 >;
  #local p2 = < -hei/2, hei/2, hei >;
  #local box_pos = pos + < 0, 0, (3/4)*joint_rad >;
  union {
    sphere { joint_ctr, joint_rad }
    box { p1, p2 rotate rot translate box_pos }
  }
#end

// Robot
#macro robot(col, pos, siz, hrot)
  // {col} = color (rgb vector)
  // {pos} = base position
  // {siz} = size
  // {hrot} = head rotation

  #local neck_pos = pos + < 0, 0, siz >;
  #local neck_hei = siz/4;

  #local head_pos = neck_pos + < 0, 0, neck_hei>;
  #local head_hei = siz/2;

  union {
    object { trunk(pos, siz) }
    object { neck(neck_pos, neck_hei) }
    object { head(head_pos, head_hei, hrot) }

    texture { pigment { color rgb col } finish { diffuse 0.9 ambient 0.1 } }
  }
#end

/**
 * Scene description
 */
robot(< 0.65, 0.80, 0.95 >, < 0, 0, 0 >, 2, < 0, 0, 0>)
