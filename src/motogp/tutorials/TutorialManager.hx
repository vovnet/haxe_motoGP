package motogp.tutorials;

import flambe.Component;
import flambe.Entity;
import flambe.script.CallFunction;
import flambe.script.Delay;
import flambe.script.Script;
import flambe.script.Sequence;
import flambe.util.Signal0;

/**
 * ...
 * @author Vladimir
 */
class TutorialManager extends Component {
	public static var eventBuyBike:Signal0 = new Signal0();
	public static var eventServiceBike:Signal0 = new Signal0();
	
	private var tutorials:Array<Entity> = new Array<Entity>();
	var script:Script;

	public function new() {
		tutorials.push(new Entity().add(new Tutor_1(this)));
		tutorials.push(new Entity().add(new Tutor_2(this)));
		tutorials.push(new Entity().add(new Tutor_3(this)));
	}
	
	override public function onAdded() {
		super.onAdded();
		
		script = new Script();
		owner.add(script);
		script.run(new Sequence([new Delay(1), new CallFunction(nextTutorial)]));
	}
	
	public function tutorialComplete(tutor:Entity) {
		tutorials.remove(tutor);
		
		if (tutorials[0] != null) {
			script.run(new Sequence([new Delay(1), new CallFunction(nextTutorial)]));
		} else {
			G.gameData.isTutorComplete = true;
		}
	}
	
	private function nextTutorial() {
		if (tutorials[0] != null) {
			owner.addChild(tutorials[0]);
		}
	}
}