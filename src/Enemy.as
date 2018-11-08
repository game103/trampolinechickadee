package  {
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class Enemy {
		private var enemy:MovieClip;
		private var dir:String;
		private var distance:Number;
		private var distanceTraveled:Number;
		private var speed:Number;
		
		public function Enemy(enemy:MovieClip,dir:String,distance:Number,speed:Number) {
			this.enemy = enemy;
			this.dir = dir;
			this.distance = distance;
			this.distanceTraveled = 0;
			this.speed = speed;
			this.enemy.addEventListener(Event.ENTER_FRAME,move);
			if(this.dir == "Right") {
				this.enemy.gotoAndStop(2);
			}
		}
		
		public function move(event:Event) {
			if(this.dir == "Left") {
				this.enemy.x = this.enemy.x - this.speed;
				this.distanceTraveled = this.distanceTraveled + this.speed;
				if(this.distanceTraveled >= this.distance) {
					this.dir = "Right";
					this.distanceTraveled = 0;
					this.enemy.gotoAndStop(2);
				}
			}
			else if(this.dir == "Right") {
				this.enemy.x = this.enemy.x + this.speed;
				this.distanceTraveled = this.distanceTraveled + this.speed;
				if(this.distanceTraveled >= this.distance) {
					this.dir = "Left";
					this.distanceTraveled = 0;
					this.enemy.gotoAndStop(1);
				}
			}
		}
		
		public function stopMoving() {
			this.enemy.removeEventListener(Event.ENTER_FRAME,move);
		}
		
		public function getTarget():MovieClip {
			return this.enemy;
		}

	}
	
}
