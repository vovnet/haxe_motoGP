package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.animation.Ease;
import flambe.display.ImageSprite;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;

/**
 * ...
 * @author Vladimir
 */
class AutoSaver extends Component {
	public static var DELAY:Float = 60;
	public static var instance:AutoSaver;
	
	private var image:ImageSprite;
	private var currentTime:Float;
	private var script:Script;
	private var showSequence:Sequence;

	public function new() {
		instance = this;
		currentTime = 0;
		
		image = new ImageSprite(G.pack.getTexture("icons/save"));
		image.setXY(800, 130);
		new Entity().add(image);
		
		script = new Script();
		showSequence = new Sequence([
			new CallFunction(showIcon),
			new Delay(2),
			new CallFunction(hideIcon)
		]);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(image.owner);
		owner.add(script);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		currentTime += dt;
		if (currentTime >= DELAY) {
			save();
		}
	}
	
	public function save() {
		G.gameData.save();
		currentTime = 0;
		script.run(showSequence);
		G.pack.getSound("sounds/beep").play();
	}
	
	function showIcon() {
		image.x.animateTo(720, 0.3, Ease.backOut);
	}
	
	function hideIcon() {
		image.x.animateTo(800, 0.3, Ease.backIn);
	}
	
}