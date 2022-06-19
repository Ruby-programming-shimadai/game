require 'dxruby'

require_relative 'player'
require_relative 'enemy'

font=Font.new(32)
player_img=Image.load("image/player.png")
enemy_img=Image.load("image/object1_new.png")
ground_img = Image.load("image/ground.png")

player=Player.new(320,400,player_img)
$PlayerShot = []
enemies=[]
10.times do
    enemies << Enemy.new(rand(0..(640-32-1)),rand((300-32-1)),enemy_img)
end


Window.loop do
    Window.draw_scale(0,0,ground_img,1,1)
    player.update
    Sprite.update($PlayerShot)

    Sprite.draw(enemies)
    Window.draw_font(10,0,"スコア：#{player.score}",font)

    Sprite.check($PlayerShot,enemies)
end