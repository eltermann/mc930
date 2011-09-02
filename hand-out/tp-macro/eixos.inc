// ======================================================================
// EIXOS DE COORDENADAS

#macro eixo(ponta,cor,nome)
  union{
    sphere{ <0,0,0>, 0.02 }
    cylinder{ <0,0,0>, 0.91*ponta, 0.02 }
    cone{ 0.90*ponta, 0.06, ponta, 0.00 }
    texture{ pigment{ color rgb cor } finish{ ambient 0.5 diffuse 0.5 } }
  }
#end
#macro eixos(tamanho)
  union{ 
    object{ eixo( <tamanho,0,0>, <1.0,0.2,0.2>, "X") }
    object{ eixo( <0,tamanho,0>, <0.0,0.8,0.0>, "Y") }
    object{ eixo( <0,0,tamanho>, <0.3,0.3,1.0>, "Z") }
  }
#end

