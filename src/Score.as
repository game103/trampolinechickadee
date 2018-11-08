package  {
	import flash.text.TextField;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.display.MovieClip;
	
	public class Score {
		private var score:Number;
		private var scoreBox:TextField;
		private var lives:Number;
		private var livesBox:TextField;
		private var level:Number;
		private var levelBox:TextField;

		public function Score() {
			this.lives = 10;
			this.score = 0;
			this.level = 1;
		}
		
		public function setBoxes(scoreBox:TextField,livesBox:TextField,levelBox:TextField) {
			this.scoreBox = scoreBox;
			this.livesBox = livesBox;
			this.levelBox = levelBox;
			this.scoreBox.text = score.toString();
			this.levelBox.text = level.toString();
			this.livesBox.text = lives.toString();
		}
		
		public function update() {
			this.scoreBox.text = score.toString();
			this.levelBox.text = level.toString();
			this.livesBox.text = lives.toString();							   
		}
		
		public function getLives():Number {
			return this.lives;
		}
		
		public function setLives(t:Number) {
			this.lives = t;
		}
		
		public function getScore():Number {
			return this.score;
		}
		
		public function setScore(t:Number) {
			this.score = t;
			update();
		}
		
		public function getLevel():Number {
			return this.level;
		}
		
		public function setLevel(t:Number) {
			this.level = t;
		}

	}
	
}
