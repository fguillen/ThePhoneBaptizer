require File.dirname(__FILE__) + '/../test_helper'


class PhoneBaptizerTest < ActiveSupport::TestCase
  def test_baptism
    phone_param = "2225537827"
    dicc_path = "#{RAILS_ROOT}/public/dics/prueba_reduced.dic"
    phone_baptizer = PhoneBaptizer.new
    names = phone_baptizer.baptize( phone_param, dicc_path )
    
    assert( names.size > 0 )
    assert( names.map { |e| e.name }.include?( "aballestar" ) )
  end
end