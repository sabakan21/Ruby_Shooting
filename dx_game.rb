=begin
やること。

弾を撃てるように
	弾の設定
		自機弾、敵弾（Bulletクラスを作って継承。グローバル配列に挿入して管理）
		被ダメージ判定（自機で判定）

敵の描画
	キャラクタクラスから自機と敵機を
	それぞれに発射メソッド


=end

require 'dxruby'

class Bullet <Sprite
	
end

class Chara < Sprite

	def action
	# move
		dx = Input.x  # x座標の移動量
		dy = Input.y  # y座標の移動量
	
		unless Input.padDown?(P_BUTTON0) then  # Zキーかパッドのボタン０を押しているか判定
			dx = dx * 2
			dy = dy * 2
		end
	
		# 画面外へ出ない判定
		self.x+=dx
		if self.x>(Window.width-32) then
			self.x=Window.width-32
		elsif self.x<0
			self.x=0
		end
		
		self.y+=dy
		if self.y>(Window.height-32) then
			self.y=Window.height-32
		elsif self.y<0
			self.y=0
		end
	
	#shoot
		if Input.padDown?(P_BUTTON2) then
			
		end
	end

end

img=Image.loadTiles('shoot.png', 4, 1)
mychara=Chara.new(0,0,img[0])

dx=0
dy=0

Window.width=640
Window.height=480

bgi=Image.load('bg.png')  #背景の読み込み


Window.loop do
	Window.draw(0,0,bgi,0)

	mychara.action
  mychara.draw
end