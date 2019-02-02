package motogp.panels;

import flambe.Component;
import flambe.System;
import motogp.tools.Button;

/**
 * ...
 * @author Vladimir
 */
class SoundButton extends Component {
	private var soundOn:Button;
	private var soundOff:Button;

	public function new() {
		soundOn = new Button("buttons/sound_on");
		soundOff = new Button("buttons/sound_off");
		
		soundOn.eventClick.connect(onClickSoundOn);
		soundOff.eventClick.connect(onClickSoundOff);
	}
	
	public function setXY(x:Float, y:Float) {
		soundOn.setXY(x, y);
		soundOff.setXY(x, y);
	}
	
	function onClickSoundOn() {
		G.gameData.isOnSound = false;
		System.volume._ = 0;
	}
	
	function onClickSoundOff() {
		G.gameData.isOnSound = true;
		System.volume._ = 1;
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		if (!G.gameData.isOnSound) {
			owner.add(soundOff);
			System.volume._ = 0;
		} else {
			owner.add(soundOn);
			System.volume._ = 1;
		}
	}
	
}