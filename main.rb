require 'dxruby'

require_relative 'apple'
require_relative 'bomb'
require_relative 'player'


ground_img = Image.load("images/apple.png") # 背景の作成
font = Font.new(32)

apples = []
apple_n = 5
apple_n.times do
  apples << Apple.new()
end

bombs = []
bomb_n = 5
bomb_n.times do
  bombs << Bomb.new()
end

player = Player.new()

Window.loop do
  Window.draw_scale(0,0,ground_img,100,100) # 背景の描画
  if player.active
    Sprite.update(apples)
    Sprite.update(bombs)
    player.update

    Sprite.check(player, apples)
    Sprite.clean(apples)
    (apple_n - apples.size).times do
      apples << Apple.new()
    end

    Sprite.check(bombs, player)
    Sprite.clean(bombs)
    (bomb_n - bombs.size).times do
      bombs << Bomb.new()
    end
  end

  Sprite.draw(apples)
  Sprite.draw(bombs)
  player.draw

  Window.draw_font(10, 10, "落ち物ゲーム　スコア：#{player.score}", font, {color: C_BLUE})

  if !player.active # 以下追加
    if player.game_end
      Window.draw_font(210, 190, "ゲームオーバー", font, {color: C_BLUE})
    end
    Window.draw_font(120, 282, "スペースキー：ゲームスタート", font, {color: C_BLUE})
    Window.draw_font(181, 314, "ESCキー：ゲーム終了", font, {color: C_BLUE})
    if Input.key_push?(K_SPACE)
      if player.game_end
        apples.map {|apple| apple.vanish}
        Sprite.clean(apples)
        bombs.map {|bomb| bomb.vanish}
        Sprite.clean(bombs)
      end
      player.restart
    elsif Input.key_push?(K_ESCAPE)
      break
    end
  end
end