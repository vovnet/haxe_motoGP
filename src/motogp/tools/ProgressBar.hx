package motogp.tools;

import flambe.Component;
import flambe.Entity;
import flambe.animation.AnimatedFloat;
import flambe.display.ImageSprite;
import flambe.math.Rectangle;

/**
 * ...
 * @author Vladimir
 */
class ProgressBar extends Component {
	public var back:ImageSprite;
	public var front:ImageSprite;
	public var progress:AnimatedFloat;

	public function new(back:ImageSprite, front:ImageSprite, progress:AnimatedFloat) {
		this.back = back;
		this.front = front;
		this.progress = progress;
		
		front.scissor = new Rectangle(0, 0, front.getNaturalWidth(), front.getNaturalHeight());
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(new Entity().add(back));
		back.owner.addChild(new Entity().add(front));
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		front.scissor.width = progress._ * front.getNaturalWidth();
	}
}