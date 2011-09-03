#include "eixos.inc"


// background
background{ color rgb < 100, 100, 100 > }

#declare bola = 
  sphere{ < 0,0,0 >, 0.1 }

#macro bolas(n)
  #if (n > 0)
    union {
      object { bola translate <0, 0, n>}
      object { bolas(n - 1) }
    }
  #else
    object { bola }
  #end
#end



union {
  object{ eixos(3.00) }
  object { bolas(10)  }
}


#include "camlight.inc"
#declare centro_cena = < 0.00, 0.00, 1.00 >;
#declare raio_cena = 6.0;
#declare dir_camera = < 14.00, 7.00, 4.00 >;
#declare dist_camera = 20.0;
#declare intens_luz = 1.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
