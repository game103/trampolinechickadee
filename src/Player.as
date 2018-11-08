package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.media.Sound;

	public class Player
	{
		private var fallSpeed:Number;
		private var player:MovieClip;
		private var trampolines:Array;
		private var stage:Stage;
		private var trampolinesView:Array;
		private var moveSpeed:Number;
		private var enemies:Array;
		private var score:Score;
		private var coins:Array;
		private var iRo:Number;
		private var lastT:Number;
		private var finish:MovieClip;
		private var deathCheck:Function;
		private var nextLevel:Function;
		private var b1:TextField;
		private var b2:TextField;
		private var b3:TextField;
		private var b4:TextField;
		private var b5:TextField;
		private var bounce:Sound;
		private var lose:Sound;

		public function Player(player:MovieClip,trampolines:Array,trampolinesView:Array,enemies:Array,stage:Stage,score:Score,coins:Array,finish:MovieClip,b1:TextField,b2:TextField,b3:TextField,b4:TextField,b5:TextField)
		{
			this.stage = stage;
			this.player = player;
			this.trampolines = trampolines;
			this.trampolinesView = trampolinesView;
			this.fallSpeed = 0;
			this.moveSpeed = 2;
			this.enemies = enemies;
			this.coins = coins;
			this.score = score;
			this.iRo = 0;
			this.lastT = 0;
			this.finish = finish;
			stage.stageFocusRect = false;
			stage.focus = this.player;
			this.b1 = b1;
			this.b2 = b2;
			this.b3 = b3;
			this.b4 = b4;
			this.b5 = b5;
			bounce = new BounceS();
			lose = new Lose();
			this.player.addEventListener(Event.ENTER_FRAME,exist);
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyboardDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,onKeyboardUp);
		}

		public function setDeathCheck(f:Function) {
			this.deathCheck = f;
		}
		
		public function setNextLevel(f:Function) {
			this.nextLevel = f;
		}

		public function exist(event:Event)
		{
			fallDown();
			for (var i:Number = 0; i < this.trampolines.length; i++)
			{
				if(this.player.hitTestObject(this.trampolines[i])) {
					if (this.player.perfectHitTest(this.trampolines[i],1) && this.fallSpeed > 0)
					{
						if(this.iRo > 320 && lastT != i) {
							this.score.setScore(this.score.getScore() + 20);
						}
						this.lastT = i;
						this.iRo = 0;
						this.trampolinesView[i].play();
						this.player.y = this.trampolines[i].y - this.player.height;
						bounce.play();
						if (this.fallSpeed > 5.4)
						{
							this.fallSpeed =  -  this.fallSpeed / 1.2;
						}
						else
						{
							this.fallSpeed = -5.4;
						}
					}
				}
			}
			for (i = 0; i < this.coins.length; i++) {
				if(this.player.hitTestObject(this.coins[i])) {
					if (this.player.perfectHitTest(this.coins[i],1)) {
						this.score.setScore(this.score.getScore() + 10);
						this.coins[i].y = - 2000;
					}
				 }
			}
			for (i = 0; i < this.enemies.length;i++) {
				if(this.player.hitTestObject(this.enemies[i].getTarget())) {
					if (this.player.perfectHitTest(this.enemies[i].getTarget(),1)) {
						for (var i2:Number = 0; i2 < this.enemies.length;i2++) {
							this.enemies[i2].stopMoving();
						}
						lose.play();
						removeEventListeners();
					}
				}
			}
			if(player.perfectHitTest(finish,1)) {
				nextLevel();
				removeAllListeners();
			}
		}

		public function moveLeft(event:Event)
		{
			for (var i:Number = 0; i < this.trampolines.length; i++)
			{
				this.trampolines[i].x = this.trampolines[i].x + 4;
				this.trampolinesView[i].x = this.trampolinesView[i].x + 4;
			}
			for (i = 0; i < this.enemies.length; i++)
			{
				this.enemies[i].getTarget().x = this.enemies[i].getTarget().x + 4;
			}
			for (i = 0; i < this.coins.length; i++)
			{
				this.coins[i].x = this.coins[i].x + 4;
			}
			this.finish.x = this.finish.x + 4;
			if(this.b1 != null) {
				this.b1.x = this.b1.x + 4;
				this.b2.x = this.b2.x + 4;
				this.b3.x = this.b3.x + 4;
				this.b4.x = this.b4.x + 4;
				this.b5.x = this.b5.x + 4;
			}
		}

		public function moveRight(event:Event)
		{
			for (var i:Number = 0; i < this.trampolines.length; i++)
			{
				this.trampolines[i].x = this.trampolines[i].x - 4;
				this.trampolinesView[i].x = this.trampolinesView[i].x - 4;
			}
			for (i = 0; i < this.enemies.length; i++)
			{
				this.enemies[i].getTarget().x = this.enemies[i].getTarget().x - 4;
			}
			for (i = 0; i < this.coins.length; i++)
			{
				this.coins[i].x = this.coins[i].x - 4;
			}
			this.finish.x = this.finish.x - 4;
			if(this.b1 != null) {
				this.b1.x = this.b1.x - 4;
				this.b2.x = this.b2.x - 4;
				this.b3.x = this.b3.x - 4;
				this.b4.x = this.b4.x - 4;
				this.b5.x = this.b5.x - 4;
			}
		}

		public function moveDown(event:Event)
		{
			if (this.fallSpeed < 14)
			{
				this.fallSpeed = this.fallSpeed + 0.2;
			}
		}

		public function rotateLeft(event:Event)
		{
			this.iRo = this.iRo + 6;
			this.player.inside.rotation = this.player.inside.rotation - 6;
		}

		public function rotateRight(event:Event)
		{
			this.iRo = this.iRo + 6;
			this.player.inside.rotation = this.player.inside.rotation + 6;
		}

		public function onKeyboardDown(event:KeyboardEvent)
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				this.moveSpeed = 0;
				this.player.addEventListener(Event.ENTER_FRAME,moveLeft);
			}
			if (event.keyCode == Keyboard.RIGHT)
			{
				this.moveSpeed = 0;
				this.player.addEventListener(Event.ENTER_FRAME,moveRight);
			}
			if (event.keyCode == Keyboard.DOWN)
			{
				this.player.addEventListener(Event.ENTER_FRAME,moveDown);
			}
			if (event.keyCode == 90)
			{
				this.player.addEventListener(Event.ENTER_FRAME,rotateLeft);
			}
			if (event.keyCode == 88)
			{
				this.player.addEventListener(Event.ENTER_FRAME,rotateRight);
			}
		}

		public function onKeyboardUp(event:KeyboardEvent)
		{
			if (event.keyCode == Keyboard.LEFT)
			{
				this.player.removeEventListener(Event.ENTER_FRAME,moveLeft);
			}
			if (event.keyCode == Keyboard.RIGHT)
			{
				this.player.removeEventListener(Event.ENTER_FRAME,moveRight);
			}
			if (event.keyCode == Keyboard.DOWN)
			{
				this.player.removeEventListener(Event.ENTER_FRAME,moveDown);
			}
			if (event.keyCode == 90)
			{
				this.player.removeEventListener(Event.ENTER_FRAME,rotateLeft);
			}
			if (event.keyCode == 88)
			{
				this.player.removeEventListener(Event.ENTER_FRAME,rotateRight);
			}
		}

		public function removeEventListeners()
		{
			this.player.removeEventListener(Event.ENTER_FRAME,rotateRight);
			this.player.removeEventListener(Event.ENTER_FRAME,rotateLeft);
			this.player.removeEventListener(Event.ENTER_FRAME,moveDown);
			this.player.removeEventListener(Event.ENTER_FRAME,moveRight);
			this.player.removeEventListener(Event.ENTER_FRAME,moveLeft);
			this.player.removeEventListener(Event.ENTER_FRAME,exist);
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyboardDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyboardUp);
			this.player.addEventListener(Event.ENTER_FRAME,fallToDeath);
			for (var i:Number = 0; i < this.trampolines.length; i++)
			{
				this.trampolinesView[i].alpha = 0.5;
			}
			for (i = 0; i < this.enemies.length; i++)
			{
				this.enemies[i].getTarget().alpha = 0.5;
			}
			for (i = 0; i < this.coins.length; i++)
			{
				this.coins[i].alpha = 0.5;
			}
			this.finish.alpha = 0.5;
		}
		
		public function removeAllListeners() {
			this.player.removeEventListener(Event.ENTER_FRAME,rotateRight);
			this.player.removeEventListener(Event.ENTER_FRAME,rotateLeft);
			this.player.removeEventListener(Event.ENTER_FRAME,moveDown);
			this.player.removeEventListener(Event.ENTER_FRAME,moveRight);
			this.player.removeEventListener(Event.ENTER_FRAME,moveLeft);
			this.player.removeEventListener(Event.ENTER_FRAME,exist);
			this.stage.removeEventListener(KeyboardEvent.KEY_DOWN,onKeyboardDown);
			this.stage.removeEventListener(KeyboardEvent.KEY_UP,onKeyboardUp);
			this.player.removeEventListener(Event.ENTER_FRAME,fallToDeath);
		}
		
		public function fallToDeath(event:Event) {
			fallDown();
		}
		
		public function fallDown() {
			if (this.fallSpeed < 12)
			{
				this.fallSpeed = this.fallSpeed + 0.2;
			}
			this.player.y = this.player.y + fallSpeed;
			if(this.player.y > 450) {
				removeAllListeners();
				deathCheck();
			}
		}

	}

}