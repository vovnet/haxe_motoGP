package motogp.effects;

import flambe.Component;
import flambe.Entity;
import flambe.animation.Ease;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.display.Sprite;
import flambe.input.PointerEvent;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;

/**
 * ...
 * @author Vladimir
 */
class Sun extends Component {
	private var fade:FillSprite;
	private var sun:ImageSprite;
	private var image:Entity;
	
	private var script:Script;
	private var sequenceShow:Sequence;
	private var sequenceHide:Sequence;
	private var clickTimer:Float;

	public function new() {
		fade = new FillSprite(0x000000, G.width, G.height);
		fade.setAlpha(0.6);
		fade.pointerDown.connect(onClick);
		new Entity().add(fade);
		
		sun = new ImageSprite(G.pack.getTexture("sun2"));
		sun.disablePointer();
		sun.centerAnchor();
		sun.setXY(G.width / 2, G.height / 2);
		new Entity().add(sun);
		
		script = new Script();
		
		sequenceShow = new Sequence([
			new CallFunction(startShow)
		]);
		
		sequenceHide = new Sequence([
			new CallFunction(startHide),
			new Delay(1),
			new CallFunction(endHide)
		]);
	}
	
	
	
	override public function onAdded() {
		super.onAdded();
		
		owner.add(script);
		
		
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		sun.rotation._ += 50 * dt;
		if (clickTimer > 0) {
			clickTimer -= dt;
		}
	}
	
	public function show(image:Entity) {
		this.image = image;
		clickTimer = 1;
		script.run(sequenceShow);
	}
	
	private function hide() {
		script.run(sequenceHide);
	}
	
	function onClick(e:PointerEvent) {
		if (clickTimer <= 0) {
			hide();
		}
	}
	
	private function startShow() {
		owner.addChild(fade.owner);
		owner.addChild(sun.owner);
		owner.addChild(image);
		
		
		fade.alpha.animate(0, 0.6, 0.3);
		sun.alpha.animate(0, 1, 0.3);
		
		var spr:Sprite = image.get(Sprite);
		spr.alpha.animate(0, 1, 0.3);
		spr.scaleX.animate(0.3, 1, 0.8, Ease.backOut);
		spr.scaleY.animate(0.3, 1, 0.8, Ease.backOut);
	}
	
	private function startHide() {
		fade.alpha.animateTo(0, 0.3);
		sun.alpha.animateTo(0, 0.3);
		
		var spr:Sprite = image.get(Sprite);
		spr.alpha.animateTo(0, 0.3);
	}
	
	private function endHide() {
		owner.removeChild(fade.owner);
		owner.removeChild(sun.owner);
		owner.removeChild(image);
	}
	
}