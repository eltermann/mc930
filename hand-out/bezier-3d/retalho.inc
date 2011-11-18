// Last edited on 2010-09-30 21:08:00 by stolfi

#macro retalho_barra(p,q,r,txg)
  #if ((r > 0) & (vlength(p - q) > 0.01*r)) 
     cylinder{p,q,r texture{txg}}
  #end
#end

#macro retalho (p11,p12,p13,p14,p21,p22,p23,p24,p31,p32,p33,p34,p41,p42,p43,p44, rad,txg,txr)
 
union{
 #local r = rad; // Raio das varetas.
 #local R = 2*r; // Raio das bolas.
 
 bicubic_patch{
  type 1 u_steps 3 v_steps 3
  p41,p42,p43,p44
  p31,p32,p33,p34
  p21,p22,p23,p24
  p11,p12,p13,p14 
  texture {txr}
 }

#if (rad > 0)
 sphere{p11,R texture{txg}}
 sphere{p12,R texture{txg}}
 sphere{p13,R texture{txg}}
 sphere{p14,R texture{txg}}
 sphere{p21,R texture{txg}}
 sphere{p22,R texture{txg}}
 sphere{p23,R texture{txg}}
 sphere{p24,R texture{txg}}
 sphere{p31,R texture{txg}}
 sphere{p32,R texture{txg}}
 sphere{p33,R texture{txg}}
 sphere{p34,R texture{txg}}
 sphere{p41,R texture{txg}}
 sphere{p42,R texture{txg}}
 sphere{p43,R texture{txg}}
 sphere{p44,R texture{txg}}

 retalho_barra(p11,p12,r, txg)
 retalho_barra(p12,p13,r, txg)
 retalho_barra(p13,p14,r, txg)
 retalho_barra(p11,p21,r, txg)
 retalho_barra(p12,p22,r, txg)
 retalho_barra(p13,p23,r, txg)
 retalho_barra(p14,p24,r, txg)
 retalho_barra(p21,p22,r, txg)
 retalho_barra(p22,p23,r, txg)
 retalho_barra(p23,p24,r, txg)
 retalho_barra(p21,p31,r, txg)
 retalho_barra(p22,p32,r, txg)
 retalho_barra(p23,p33,r, txg)
 retalho_barra(p24,p34,r, txg)
 retalho_barra(p31,p32,r, txg)
 retalho_barra(p32,p33,r, txg)
 retalho_barra(p33,p34,r, txg)
 retalho_barra(p31,p41,r, txg)
 retalho_barra(p32,p42,r, txg)
 retalho_barra(p33,p43,r, txg)
 retalho_barra(p34,p44,r, txg)
 retalho_barra(p41,p42,r, txg)
 retalho_barra(p42,p43,r, txg)
 retalho_barra(p43,p44,r, txg)
}
#end

#end


