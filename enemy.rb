class Enemy < Sprite
  def hit
      self.vanish
  end

  def update
      self.y += 1
      if self.y>=400
          self.vanish
      end
  end
end