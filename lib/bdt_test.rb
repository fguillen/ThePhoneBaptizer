#!/usr/bin/ruby
require 'logger'
require 'bautizador_de_telefonos'
require 'Baptism'

PHONE='600600600'
#DICC='english_reduced'
DICC='spanish_reduced'
MAX_ELEMENTS=50
DICC_PATH = "../public/dics/#{DICC}.dic"

bdt = PhoneBaptizer.new
names = bdt.baptize( PHONE, DICC_PATH )

bdt.sort_by_max_chars( names )

names = names[0..(MAX_ELEMENTS - 1)]

bdt.print_names( names )

