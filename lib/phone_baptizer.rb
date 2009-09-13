#
# author: fernandoguillen.info
# date: 2008.05.12
#

#
# esta pensado para funcionar desde consola
# sin Rails ni nada
#
class PhoneBaptizer

  #
  # recibe un número de telefono en formato string
  # recibe un path a un fichero de diccionario, no vale 
  # cualquier fichero tiene que ser un diccionario hecho para la aplicación
  #  111,aaa
  #
  def baptize( phone_number, dicc_path ) 
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    
    time_ini = Time.now
    logger.info( "empezamos el bautizo:" + time_ini.to_s )
    
    @telephoneNames = [] 
    
    baptism = Baptism.new
    baptism.name = phone_number
    
    logger.debug "getting names.. "
    bautizo_recurrente( @telephoneNames, baptism, open( dicc_path ), 0 )
    logger.debug "..names getted"
    logger.debug "num elements => " + @telephoneNames.size.to_s
    
    #
    # calculamos lo que ha costado
    #
    time_end = Time.now
    logger.info( "terminamos el bautizo:" + time_end.to_s )
    logger.info( "bautizo realizado en:" + (time_end - time_ini).to_s + " segundos" )
    
    @telephoneNames
  end
  
  def bautizo_recurrente( baptisms, baptism, dic, deep )
    logger = Logger.new(STDOUT)
    logger.level = Logger::DEBUG
    
    newDic = []
    
    dic.each do |linea|
      linea.gsub!(/\n/,'')
#      linea.downcase!
      
      numero = linea.split(/,/)[0]
      palabra = linea.split(/,/)[1]
      
      if not baptism.name.rindex( numero ).nil?
        _baptism = Baptism.new
        _baptism.add_words( baptism.words )
        _baptism.max_chars = baptism.max_chars 
        _baptism.name = baptism.name.gsub( numero, palabra )
        _baptism.add_word( palabra )
        
        #looking for the max characters
        if _baptism.max_chars < palabra.size
          _baptism.max_chars= palabra.size
        end
        baptisms << _baptism
        newDic << linea
        #
        # frenando la profundidad de recursividad
        #
        if deep < 2
          bautizo_recurrente( baptisms, _baptism, newDic, deep + 1 )
        end
      end
    end
  end
  
  #
  # ordena los resultados por el numero de caracteres
  #
  def sort_by_num_characters( baptisms )
    baptisms.sort! do |x,y|
      if( y.num_characters != x.num_characters )
        y.num_characters <=> x.num_characters
      else
        y.max_chars <=> x.max_chars
      end
    end
  end

  #
  # ordena los resultados por la palabra mas gorda
  #
  def sort_by_max_chars( baptisms )
    baptisms.sort! do |x,y|
      if( y.max_chars != x.max_chars )
        y.max_chars <=> x.max_chars
      else
        y.num_characters <=> x.num_characters
      end
    end
  end
  
  
  def print_names( telephone_names )
    telephone_names.each do |t|
       texto = t.name + '(' + t.num_characters.to_s + ') (' + t.max_chars.to_s + ') => '
       t.words.each do |word|
        texto  += word + ','
      end 
        puts texto
    end
    "nada"
  end
end