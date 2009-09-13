require File.dirname(__FILE__) + '/../test_helper'

class BaptizerControllerTest < ActionController::TestCase
  def test_on_index
    get :index
    
    assert_response :success
  end
  
  def test_on_batism
    get(
     :baptism,
     :dic => 'prueba',
     :phone => '2225537827'
    )
    
    assert_response :success
    
    assert( assigns(:telephoneNames).size > 0 )
    assert( assigns(:telephoneNames).map { |e| e.name }.include?( "aballestar" ) )
  end
end