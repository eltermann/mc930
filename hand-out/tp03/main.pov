// TODO - ficou faltando: definir a base do tronco filho
// TODO - melhorar 


// background
background{ color rgb < 100, 100, 100 > }

// folha: esfera
#declare folha = 
  sphere{ < 0,0,0 >, 0.5 }

// definicao da macro
// @param nivel
//   Qual o nivel da recursao
// @param base_tronco
//   Vetor: representa o final do tronco anterior (base do atual)

#macro arvore(nivel, base_tronco)
  //#local altura_tronco = nivel/2;

  #if (nivel = 0)
    object { folha }
  #else
    union {
      // tronco
      cylinder { 
        base_tronco,
        base_tronco + <0, 0, nivel>,
        0.1
      }

      // ramo1
      object { 
        arvore(n - 1, base_tronco)
        rotate <0, 0, -605>
      }

      // ramo2
      object { 
        arvore(n - 1, base_tronco)
        rotate <0, 0, -5>
      }

      // ramo3
      object { 
        arvore(n - 1, base_tronco)
        rotate <0, 0, +50>
      }
    }
  #end
#end


// Descricao da cena
arvore(1, <0,0,0>)

#include "camlight.inc"
#declare centro_cena = < 0.00, 0.00, 1.00 >;
#declare raio_cena = 6.0;
#declare dir_camera = < 14.00, 7.00, 4.00 >;
#declare dist_camera = 1000.0;
#declare intens_luz = 1.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
