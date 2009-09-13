#
# de Curso de Ruby de Anaya O'Relly
#

class Array
  def mezclar!
    self.each_index do |i|
      j = Kernel.rand( self.length - i ) + i
      self[j], self[i] = self[i], self[j]
    end
  end
end