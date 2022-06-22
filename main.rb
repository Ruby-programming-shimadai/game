require 'dxruby'

require_relative 'player'
require_relative 'enemy'

num = rand(5)+1
font=Font.new(32)
timer = 0
player_img=Image.load("image/tank.png")
enemy_img=Image.load("image/enemy#{num}.png")
ground_img = Image.load("image/ground.png")

player=Player.new(320,400,player_img)
$PlayerShot = []
enemies=[]
enemy_n = 35
enemy_n.times do
    enemies << Enemy.new(rand(0..(640-32-1)),rand((300-32-1)),enemy_img)
end


Window.loop do
    Window.draw_scale(0,0,ground_img,1,1)

    Sprite.update([$PlayerShot,enemies])
    timer += 1
    player.update

    Sprite.clean(enemies)
    (enemy_n-enemies.size).times do
        enemies << Enemy.new(rand(0..(640-32-1)),rand((60-32-1)),enemy_img)
    end

    Sprite.draw(enemies)
    player.draw

    Window.draw_font(10,0,"スコア：#{timer/10}",font)

    Sprite.check($PlayerShot,enemies)
    if $PlayerShot === enemies
        timer+=10
    end
    Sprite.check(enemies,player)
    if player.gameover
        Window.draw_font(210, 190, "ゲームオーバー", font, {color: C_BLACK})
    end
end