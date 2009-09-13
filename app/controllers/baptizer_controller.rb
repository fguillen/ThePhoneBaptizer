#
# author: fernandoguillen.info
# date: 2008.05.12
#

class BaptizerController < ApplicationController
  
  
  def baptism
    dicc_param = params[:dic]
    phone_param = params[:phone]
    num_param = params[:num].nil? ? 100 : params[:num]
    
    logger.debug( "dicc_param" + dicc_param.to_s )
    logger.debug( "phone_param" + phone_param.to_s )
    logger.debug( "num_param:" + num_param.to_s )
    
    #
    # llamamos al PhoneBaptizer
    #
    dicc_path = "#{RAILS_ROOT}/public/dics/#{dicc_param}_reduced.dic"
    phone_baptizer = PhoneBaptizer.new
    names = phone_baptizer.baptize( phone_param, dicc_path )
    
    # how many?
    @total_names = names.size

    # order by the bigger word
    phone_baptizer.sort_by_max_chars( names )
    
    
    # take the first numParam elements
    names = names[0..(num_param - 1)]
    
    # marcamos los pesos
    names.each_with_index do |baptism, index|
      baptism.peso = names.size - index
    end
    
    # removemos
    names.mezclar!
    
    # el telefono 
    @phone = phone_param
    
    # los bautizados    
    @telephoneNames = names
    
    logger.debug "num elements => " + @telephoneNames.size.to_s
    
  end
  
  
  # def copia_agenda
  #   flash[:error] = nil
  #   
  #   phone = params[:cam_phone]
  #   pass = params[:cam_pass]
  #   
  #   cam = CopiaAgendaMovistar.new
  #   
  #   begin
  #     @cam_contacts = cam.get_only_phone_and_name( phone, pass )
  #   rescue
  #     flash[:error] = "Error al cargar cargar copiagenda"
  #   end
  #     
  # end
  # 
  # def enviar_sms
  #   from = params[:sms_phone];
  #   pass = params[:sms_pass];
  #   to = params[:sms_contacto];
  #   text = params[:sms_text];
  #   
  #   #
  #   # un poco de log
  #   #
  #   logger.debug( 'from:' + from );
  #   logger.debug( 'pass:' + pass );
  #   logger.debug( 'to:' + to );
  #   logger.debug( 'text:' + text );
  #   
  #   #
  #   # enviamos el sms
  #   #
  #   begin
  #     mss = MovistarSmsSender.new( from, pass )
  #     mss.send( to, text )
  #   
  #     logger.debug( 'ningun error enviar mensaje' )
  #     flash[:notice] = "El SMS ha sido enviado con éxito. O por lo menos el servidor a contestado con \'OK\' :)"
  #   rescue 
  #     logger.debug( 'error al enviar mensaje' )
  #     flash[:error] = "El SMS no pudo ser eviado. Respuesta del servidor: \'#{$!}\'"
  #   end
  #   
  # end
  
  
end
