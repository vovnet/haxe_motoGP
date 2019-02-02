package motogp.tutorials;

import flambe.Component;
import flambe.Entity;
import flambe.display.ImageSprite;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;
import motogp.tutorials.TutorialManager;

/**
 * ...
 * @author Vladimir
 */
class Tutor_1 extends Component {
	private var manager:TutorialManager;
	private var image:ImageSprite;
	
	public function new(manager:TutorialManager) {
		this.manager = manager;
		TutorialManager.eventBuyBike.connect(onBuyBike).once();
		
		image = new ImageSprite(G.pack.getTexture("tutorials/tutor_1"));
		image.disablePointer();
		image.setXY(100, 96);
		new Entity().add(image);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(image.owner);
		
		image.alpha.animate(0, 1, 0.3);
	}
	
	function onBuyBike() {
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