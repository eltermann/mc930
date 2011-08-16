// Exemplo de arquivo de descricao de cena para POV-ray
// Last edited on 2010-03-04 15:44:01 by stolfi

// ======================================================================
// CORES E TEXTURAS

// background changed to yellow
background{ color rgb < 0.8, 0.9, 0.06 > }

#declare tx_plastico = 
  texture{
    pigment{ color rgb < 0.10, 0.80, 1.00 > }
    finish{ diffuse 0.8 ambient 0.1 specular 0.5 roughness 0.005 }
  }

#declare tx_fosca = 
  texture{
    pigment{ color rgb < 1.00, 0.80, 0.10 > }
    finish{ diffuse 0.9 ambient 0.1 }
  }

#declare tx_espelho = 
  texture{
    pigment{ color rgb < 1.00, 0.85, 0.30 > }
    finish{ diffuse 0.2 reflection 0.7*< 1.00, 0.85, 0.30 > ambient 0.1 }
  }

#declare tx_vidro = 
  texture{
    pigment{ color rgb < 0.85, 0.95, 1.00 > filter 0.70 }
    finish{ diffuse 0.03 reflection 0.25 ambient 0.02 specular 0.25 roughness 0.005 }
  }


#declare tx_xadrez =
  texture{
    pigment{ checker color rgb < 0.10, 0.32, 0.60 >, color rgb < 1.00, 0.97, 0.90 > }
    finish{ diffuse 0.9 ambient 0.1 }
    scale 2.0
  }

// ======================================================================
// DESCRIÇÃO DA CENA 

#declare raio = 2.000;

// Partes da cena:
  
#declare bolinha = 
  sphere{ < 1,1,0 >, 0.60 }
 
#declare bolota = 
  sphere{ < 1,1,0 >, 1.50 }
 
#declare bola =
  sphere{
    < 1.00, 1.00, 1.00 >, raio 
    texture{ tx_plastico }
  }
  
#declare pino = 
  cylinder{
    < -2.00, +2.00, -1.00 >,
    < +2.00, -2.00, +1.00 >,
    0.75
    texture{ tx_fosca }
  }
  
#declare furo = 
  cylinder{
    < -1.00, -2.00, -2.00 >,
    < +1.00, +2.00, +2.00 >,
    0.75*raio
    texture{ tx_fosca }
  }

#declare chao = 
  box{ <-20,-20,-1>, <+20,+20,0> }

#include "eixos.inc"

// Aqui está a cena, finalmente:

union{
  object{ eixos(3.00) }

  object{ chao  translate < 0,0,-5 > texture{ tx_xadrez } }
  object{ bolota  translate < -2,+1,+3 > texture{ tx_espelho } }
  object{ bolinha translate < +5,+4,+2 > texture{ tx_vidro } interior { ior 1.01 } }

  difference{ 
    union{
      object{ bola } 
      object{ pino }
    }
    object{ furo }
  }
}

#include "camlight.inc"
#declare centro_cena = < 0.00, 0.00, 1.00 >;
#declare raio_cena = 6.0;
#declare dir_camera = < 14.00, 7.00, 4.00 >;
#declare dist_camera = 16.0;
#declare intens_luz = 1.00;
camlight(centro_cena, raio_cena, dir_camera, dist_camera , z, intens_luz)
