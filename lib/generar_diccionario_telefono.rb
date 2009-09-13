#
# este script recibe la ruta a un fichero como argumento
# el fichero debe ser un listado de palabras separadas por saltos de carro
# generará un fichero adecuado para la aplicación
#
# conviene quitar los acentos y las ñs porque dan problemas
# así como cualquier caracter especial .. guiones letras griegas o yo que sé
#

@letras = {
  'a' => '2',
  'b' => '2',
  'c' => '2',
  'd' => '3',
  'e' => '3',
  'f' => '3',
  'g' => '4',
  'h' => '4',
  'i' => '4',
  'j' => '5',
  'k' => '5',
  'l' => '5',
  'm' => '6',
  'n' => '6',
  'ñ' => '6',
  'o' => '6',
  'p' => '7',
  'q' => '7',
  'r' => '7',
  's' => '7',
  't' => '8',
  'u' => '8',
  'v' => '8',
  'w' => '9',
  'x' => '9',
  'y' => '9',
  'z' => '9'
}


#dicc_telefonico = open('./dicc_telefonico.dic','w')
open( ARGV[0] ).each do |palabra|
  palabra.gsub!(/\n/,'')
  palabra.downcase!
  numero = palabra.lstrip
  palabra.scan( /./u).each do |letra|
#    p letra
    numero.gsub!( letra, @letras[letra])
  end
  puts	 numero	+ ',' + palabra
end
