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

class Field < Sprite
	def hit
	end
end

class MyBullet < Sprite
@@image=Image.new(3, 7, C_WHITE)

	def initialize(x,y,ang)
		self.x=x+15
		self.y=y-15
		@angle=ang
		@go_out=false
		self.angle=@angle
		self.image=@@image
	end
	
	def update
		rad=Math::PI*@angle/180.0
		dy=10*Math::cos(rad)
		dx=-10*Math::sin(rad)
		self.y=self.y-dy
		self.x=self.x-dx
		if @go_out==true
			self.vanish
		end
	end
	
	def shot
		@go_out=true
	end
end

class Chara < Sprite

	def update
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
			mybullet=MyBullet.new(self.x,self.y,10)
			$m_bullets.push(mybullet)
			#$objects.push(mybullet)
			mybullet=MyBullet.new(self.x,self.y,0)
			$m_bullets.push(mybullet)
			#$objects.push(mybullet)
			mybullet=MyBullet.new(self.x,self.y,-10)
			$m_bullets.push(mybullet)
			#$objects.push(mybullet)
		end
	end

end

$objects=[]

bgi=Image.load('bg.png')  #背景の読み込み
field=Field.new(64,64,bgi)
$objects<<field


img=Image.loadTiles('shoot.png', 4, 1)
mychara=Chara.new(304,400,img[0])

$objects<<mychara
Window.width=640
Window.height=480


$e_bullets=Array.new
$m_bullets=Array.new
$objects<<$m_bullets
$objects<<$e_bullets

Window.loop do
	
	Sprite.check(field,$m_bullets)
	Sprite.update($objects)
	Sprite.clean($objects)
	Sprite.draw($objects)

end