package motogp.effects;

import flambe.Component;
import flambe.Entity;
import flambe.animation.Ease;
import flambe.display.Sprite;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;

/**
 * ...
 * @author Vladimir
 */
class Blinker extends Component {
	private var image:Sprite;
	private var oldPosY:Float;
	var script:Script;
	var behavior:Sequence;

	public function new(image:Sprite) {
		this.image = image;
		oldPosY = image.y._;
		image.disablePointer();
		
		script = new Script();
		behavior = new Sequence([
			new CallFunction(start),
			new Delay(0.4),
			new CallFunction(end)
		]);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(image.owner);
		owner.add(script);
	}
	
	public function show() {
		image.y._ = oldPosY;
		script.run(behavior);
	}
	
	function start() {
		image.y.animateTo(image.y._ - 200, 2);
		image.scaleX.animate(0.6, 1, 0.3, Ease.backOut);
		image.scaleY.animate(0.6, 1, 0.3, Ease.backOut);
		image.setAlpha(1);
	}
	
	function end() {
		image.alpha.animate(1, 0, 0.6);
	}
	
}