package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.animation.AnimatedFloat;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.util.Signal0;
import motogp.effects.Blinker;
import motogp.tools.Button;
import motogp.tools.ProgressBar;
import motogp.tutorials.TutorialManager;

/**
 * ...
 * @author Vladimir
 */
class Service extends Component {
	public var eventCompleteWork:Signal0 = new Signal0();
	public var delay:Float = 2.5;
	
	private var currentTime:Float = 0;
	private var isWorking:Bool = false;
	
	private var grayBtn:ImageSprite;
	private var grayLabel:ImageSprite;
	private var serviceBtn:Button;
	private var serviceLabel:ImageSprite;
	private var bar:ProgressBar;
	private var progress:AnimatedFloat = new AnimatedFloat(0);
	private var mainLayer:Entity = new Entity();
	private var effectLayer:Entity = new Entity();
	private var blinker:Blinker;
	var blText:TextSprite;
	private var timerText:TextSprite;

	public function new() {
		grayBtn = new ImageSprite(G.pack.getTexture("buttons/big_blue_btn"));
		grayBtn.setAlpha(0.8);
		grayBtn.centerAnchor();
		grayBtn.setXY(142, 470);
		new Entity().add(grayBtn);
		
		grayLabel = new ImageSprite(G.pack.getTexture("service_text"));
		grayLabel.centerAnchor();
		grayLabel.setXY(grayBtn.getNaturalWidth() / 2, grayBtn.getNaturalHeight() / 2);
		grayBtn.owner.addChild(new Entity().add(grayLabel));
		
		serviceBtn = new Button("buttons/big_blue_btn");
		serviceBtn.setXY(142, 470);
		serviceBtn.eventClick.connect(onClickServiceBtn);
		new Entity().add(serviceBtn);
		
		serviceLabel = new ImageSprite(G.pack.getTexture("service_text"));
		serviceLabel.centerAnchor();
		serviceLabel.setXY(serviceBtn.getWidth() / 2, serviceBtn.getHeight() / 2);
		serviceBtn.owner.addChild(new Entity().add(serviceLabel));
		
		bar = new ProgressBar(
			new ImageSprite(G.pack.getTexture("bars/big_bar_back")),
			new ImageSprite(G.pack.getTexture("bars/big_bar_front")),
			progress
		);
		bar.back.setXY(33, 406);
		bar.front.setXY(-1, 0);
		new Entity().add(bar);
		
		timerText = new TextSprite(new Font(G.pack, "fonts/gray_font_14"), "1.4 sec");
		timerText.setXY(35, 380);
		new Entity().add(timerText);
		
		blText = new TextSprite(new Font(G.pack, "fonts/red_font_24"), "+100");
		blText.setXY(40, -56);
		new Entity().add(blText);
		
		var gear:ImageSprite = new ImageSprite(G.pack.getTexture("icons/middle_gear"));
		gear.centerAnchor();
		gear.setAlpha(0);
		gear.setXY(120, 410);
		new Entity().add(gear);
		gear.owner.addChild(blText.owner);
		
		blinker = new Blinker(gear);
		new Entity().add(blinker);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(mainLayer);
		owner.addChild(effectLayer);
		
		mainLayer.addChild(grayBtn.owner);
		mainLayer.addChild(serviceBtn.owner);
		mainLayer.addChild(bar.owner);
		mainLayer.addChild(timerText.owner);
		effectLayer.addChild(blinker.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		var number = delay - currentTime;
		number *= Math.pow(10, 1);
		var res = Math.round(number) / Math.pow(10, 1);
		timerText.text = Std.string(res) + " sec";
		
		if (isWorking) {
			mainLayer.removeChild(serviceBtn.owner);
			currentTime += dt;
			progress._ = currentTime / delay;
			if (currentTime >= delay) {
				stop();
			}
		} else {
			mainLayer.addChild(serviceBtn.owner);
			progress._ = 0;
		}
	}
	
	public function start() {
		disableBtn();
		isWorking = true;
	}
	
	private function stop() {
		blText.text = "+" + G.gameData.mechanics;
		blinker.show();
		isWorking = false;
		currentTime = 0;
		progress._ = 1;
		G.gameData.gears += G.gameData.mechanics;
		eventCompleteWork.emit();
	}
	
	function onClickServiceBtn() {
		start();
		G.pack.getSound("sounds/service").play();
		TutorialManager.eventServiceBike.emit();
	}
	
	function disableBtn() {
		
	}
	
	function enableBtn() {
		
	}
	
}