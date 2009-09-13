require 'rubygems'
require 'hpricot'
require 'net/http'
require 'net/https'
require 'uri'

# to_hash
class String
   def to_hash(seperation='&', assignment='=')
     hash = Hash.new
     self.split(seperation).each do |elemement|
       pieces = elemement.split(assignment)
       hash[pieces[0]] = pieces[1]
     end
     hash.delete_if { |key, value| value.nil? }
   end
end


def get_data(login, pass)
  # urlS 
  url = "copiagenda.movistar.es"
  url_login = "/cp/ps/Main/login/Agenda"
  url_verification = "/cp/ps/Main/login/Verificacion?d=movistar.es"
  url_token = "/cp/ps/Main/login/Authenticate"
  url_ask = "/cp/ps/PSPab/preferences/ExportContacts?d=movistar.es&c=yes"

  ## iniciamos conexiÃ³n
  http = Net::HTTP.new(url, 443)
  http.use_ssl = true

  ## nos logueamos
  data = "TM_ACTION=LOGIN&TM_LOGIN=#{login}&TM_PASSWORD=#{pass}" 
  headers = {
    'User-Agent'    => 'Mozilla/4.0',
    'Content-Type'  => 'application/x-www-form-urlencoded',
    'Connection'    => 'Keep-Alive'
  }
  resp, data = http.post(url_login, data, headers)
  cookie = resp.response['set-cookie']
  cookie = cookie.sub(" Path=/, "," ")
  cookie = cookie.sub("; Domain=.movistar.es; Path=/","")
  cookie = cookie.rstrip

  ## conseguimos con la cookie el token de sesiÃ³n
  headers = {
    'Cookie'        => cookie,
    'User-Agent'    => 'Mozilla/4.0',
    'Content-Type'  => 'application/x-www-form-urlencoded',
    'Connection'    => 'Keep-Alive'
  }
  resp, data = http.get(url_verification, headers)

  # pasamos la respuesta por hpricot para buscar la password codificada
  doc = Hpricot(resp.response.body)
  passCode = doc.search("//input[@name='password']").first.attributes['value']

  data = "password=#{passCode}&u=#{login}&d=movistar.es"
  headers = {
    'Cookie'          => cookie,
    'User-Agent'      => 'Mozilla/4.0',
    'Accept-Encoding' => 'gzip, deflate', 
    'Host'            => 'copiagenda.movistar.es', 
    'Referer'         => 'https://copiagenda.movistar.es/cp/ps/Main/login/Verificacion?d=movistar.es',
    'Content-Type'    => 'application/x-www-form-urlencoded',
    'Connection'      => 'Keep-Alive'
  }

  resp, data = http.post(url_token, data, headers)
  doc = Hpricot(resp.response.body)
  frameSrc = doc.search("//frame[@name='BrandHeader']").first.attributes["src"].to_hash
  token = frameSrc.fetch("t")

  data = "fileFormat=TEXT&charset=UTF8&delimiter=TAB"
  headers = {
    'Cookie'          => cookie,
    'User-Agent'      => 'Mozilla/4.0',
    'Accept-Encoding' => 'gzip, deflate',
    'Host'            => 'copiagenda.movistar.es', 
    'Referer'         => 'https://copiagenda.movistar.es/cp/ps/Main/login/Verificacion?d=movistar.es',
    'Content-Type'    => 'application/x-www-form-urlencoded',
    'Accept-Language' => 'es',
    'Cache-Control'   => 'no-cache',
    'Connection'      => 'Keep-Alive'
  }
  resp, data = http.post("#{url_ask}&u=#{login}&t=#{token}", data, headers)
  
  doc = Hpricot(resp.response.body)
  # eliminamos script tag y comentarios
  doc.search("script").remove  
  doc.search("*").map{|e| e.swap("") if e.comment?}
  csv = doc.to_s
  
end


def parse_contacts(csv)
  contactos = []
  csv = csv.split("\r")
  csv.each_with_index do |row, index|
    if index > 0 && row.split("\"\t\"").size > 1
      contactos << row.split("\"\t\"") 
    end
  end
  contactos
end

LOGIN = '600600600'
PASS = 'xxx'

puts get_data(LOGIN, PASS)
puts parse_contacts(get_data(LOGIN, PASS))