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
//#declare cav = < 1.00, 0.00, 0.00 >; //Frontal view
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
  #local joint_ctr = pos + < 0, 0, joint_rad >;

  #local p1 = < hei/2, -hei/2, 0 >;
  #local p2 = < -hei/2, hei/2, hei >;
  #local head_pos = pos + < 0, 0, (3/4)*joint_rad >;

  union {
    sphere { joint_ctr, joint_rad }
    box { p1, p2 rotate rot translate head_pos }
  }
#end

// Arm
#macro arm(pos, wid, arm1_rot)
  #local joint1_rad = wid/2;
  #local joint1_ctr = pos + < 0, 0, -joint1_rad >;

  #local arm1_hei = 5 * wid;
  #local arm1_p1 = < +wid/2, -wid/2, -arm1_hei >;
  #local arm1_p2 = < -wid/2, +wid/2, 0 >;
  #local arm1_pos = joint1_ctr;

  union {
    sphere { joint1_ctr, joint1_rad }
    box { arm1_p1, arm1_p2 rotate arm1_rot translate arm1_pos }
  }
#end

// Leg
#macro leg(pos, wid, leg1_rot)
  #local joint1_rad = wid/2;
  #local joint1_ctr = pos + < 0, 0, -joint1_rad >;

  #local leg1_hei = 6 * wid;
  #local leg1_p1 = < +wid/2, -wid/2, -leg1_hei >;
  #local leg1_p2 = < -wid/2, +wid/2, 0 >;
  #local leg1_pos = joint1_ctr;

  union {
    sphere { joint1_ctr, joint1_rad }
    box { leg1_p1, leg1_p2 rotate leg1_rot translate leg1_pos }
  }

#end

// Robot
#macro robot(col, pos, siz, hrot, rarot, larot, rlrot, llrot)
  // {col} = color (rgb vector)
  // {pos} = base position
  // {siz} = size
  // {hrot} = head rotation
  // {rarot} = right arm rotation
  // {larot} = left arm rotation
  // {rlrot} = right leg rotation
  // {llrot} = left leg rotation

  #local neck_pos = pos + < 0, 0, siz >;
  #local neck_hei = siz/4;

  #local head_pos = neck_pos + < 0, 0, neck_hei>;
  #local head_hei = siz/2;

  #local rig_arm_wid = (1/4)*siz;
  #local rig_arm_pos = neck_pos + < 0, -siz/3 -rig_arm_wid/2, 0 >;

  #local lef_arm_wid = (1/4)*siz;
  #local lef_arm_pos = neck_pos - < 0, -siz/3 -lef_arm_wid/2, 0 >;

  #local rig_leg_wid = (1/4)*siz;
  #local rig_leg_pos = pos + < 0, -siz/3 +rig_leg_wid/2, 0 >;

  #local lef_leg_wid = (1/4)*siz;
  #local lef_leg_pos = pos - < 0, -siz/3 +lef_leg_wid/2, 0 >;

  union {
    object { trunk(pos, siz) }
    object { neck(neck_pos, neck_hei) }
    object { head(head_pos, head_hei, hrot) }
    object { arm(rig_arm_pos, rig_arm_wid, rarot) }
    object { arm(lef_arm_pos, lef_arm_wid, larot) }
    object { leg(rig_leg_pos, rig_leg_wid, rlrot) }
    object { leg(lef_leg_pos, lef_leg_wid, llrot) }

    texture { pigment { color rgb col } finish { diffuse 0.9 ambient 0.1 } }
  }
#end

/**
 * Scene description
 */
#declare rob_color = < 0.65, 0.80, 0.95 >;
#declare rob_pos = < 0, 0, 0 >;
#declare rob_size = 2;
#declare rob_head_rotate = < 0, 0, 0>;
#declare rob_rig_arm_rotate = < 0, -10, 0>;
#declare rob_lef_arm_rotate = < 0, 0, 0>;
#declare rob_rig_leg_rotate = < 0, 5, 0>;
#declare rob_lef_leg_rotate = < 0, -20, 0>;
robot(rob_color, rob_pos, rob_size, rob_head_rotate, rob_rig_arm_rotate, rob_lef_arm_rotate, rob_rig_leg_rotate, rob_lef_leg_rotate)
