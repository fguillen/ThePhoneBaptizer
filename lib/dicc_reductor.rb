#!/usr/bin/ruby

#
# diseñado para optimizar los diccionarios
#

DICC = 'spanish'
DICC_PATH = "../public/dics/#{DICC}.dic"
DICC_REDUCTED_PATH = "../public/dics/#{DICC}_reduced.dic"

dicc_array = []

open( DICC_PATH ).each do |linea|
      linea.gsub!(/\n/,'')
      linea.downcase!
      
      # borrar mayores de 11 digitos
      if( linea.size <= 23 )
        dicc_array << linea   
      end
end

# ordenar
dicc_array.sort! {|x,y| y.size <=> x.size }

File.open( DICC_REDUCTED_PATH, 'w' ) do |f|
  dicc_array.each do |linea|
    f.write linea + "\n"
  end
end