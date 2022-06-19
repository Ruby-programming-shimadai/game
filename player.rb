class Player < Sprite
    attr_accessor :score
    def initialize(x,y,image)
        @score = 0
        super
    end

    def update
        self.draw
        self.x+=Input.x
        self.y+=Input.y
        if Input.key_push?(K_SPACE) then
            $PlayerShot << PlayerShot.new(self.x,self.y)
        end
    end

end

class PlayerShot < Sprite
    def initialize(x,y)
        @sound = Sound.new("sound/explosion.wav")
        super
        self.image=Image.load("image/bullet_new.png")
        self.x = x
        self.y = y
    end

    def update
        self.draw
        self.y -= 10

        if self.y<=0 then
            self.vanish
        end
    end

    def shot
        self.vanish
        @sound.play
    end
end
