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
class Tutor_2 extends Component {
	private var manager:TutorialManager;
	private var image:ImageSprite;
	
	public function new(manager:TutorialManager) {
		this.manager = manager;
		TutorialManager.eventServiceBike.connect(onServiceBike).once();
		
		image = new ImageSprite(G.pack.getTexture("tutorials/tutor_2"));
		image.disablePointer();
		image.setXY(40, 190);
		new Entity().add(image);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(image.owner);
		
		image.alpha.animate(0, 1, 0.3);
	}
	
	function onServiceBike() {
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