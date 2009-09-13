#
# ya sé que esta clase está bastante mal
# pero me hago un lio con los scope y los setter and getter en ruby
# todavía
#

class Baptism
  def initialize
    @words = []
    @peso = 0
  end
  
  def peso= _peso
    @peso = _peso
  end
  
  def peso
    @peso
  end
  
  def num_characters
    @name.count('a-zA-Z', "^\000ds")
  end
  
  def words
    @words
  end
  
  def add_word( word )
    @words << word
  end
  
  def add_words( words )
    if words != nil
       words.each do |word|
        self.add_word word  
      end
    end
  end
  
  def max_chars
    if @max_chars == nil
      @max_chars = 0
    end
    @max_chars
  end
  
  def max_chars= num
    @max_chars = num
  end
  
  def name
    @name
  end
  
  def name= _name
    @name = _name
  end
  
end
