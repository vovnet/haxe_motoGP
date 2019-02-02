package motogp.tutorials;

import flambe.Component;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.input.PointerEvent;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;
import motogp.tutorials.TutorialManager;

/**
 * ...
 * @author Vladimir
 */
class Tutor_3 extends Component {
	private var manager:TutorialManager;
	private var image:ImageSprite;
	private var countService:Int = 0;
	
	public function new(manager:TutorialManager) {
		this.manager = manager;
		TutorialManager.eventServiceBike.connect(onSerice);
		
		image = new ImageSprite(G.pack.getTexture("tutorials/tutor_3"));
		image.pointerDown.connect(onClick).once();
		image.centerAnchor();
		image.setXY(G.width / 2, G.height / 2);
		new Entity().add(image);
	}
	
	function onSerice() {
		countService++;
		if (countService > 3) {
			owner.addChild(image.owner);
			image.alpha.animate(0, 1, 0.3);
		}
	}
	
	override public function onAdded() {
		super.onAdded();
		
		
	}
	
	function onClick(e:PointerEvent) {
		manager.tutorialComplete(owner);
		
		var script:Script = new Script();
		var sequence:Sequence = new Sequence([
			new CallFunction(startHide),
			new Delay(1),
			new CallFunction(completeHide)
		]);
		owner.add(script);
		script.run(sequence);
	}
	
	function startHide() {
		image.alpha.animateTo(0, 0.3);
	}
	
	function completeHide() {
		owner.parent.removeChild(owner);
	}
	
}