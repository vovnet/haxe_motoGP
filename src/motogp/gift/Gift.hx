package motogp.gift;

import flambe.Component;
import flambe.Entity;
import flambe.animation.Sine;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.input.PointerEvent;
import motogp.screens.GameScreen;
import motogp.tools.TimeFormatter;

/**
 * ...
 * @author Vladimir
 */
class Gift extends Component {
	public static var DELAY:Float = 601;
	
	private var grayGift:ImageSprite;
	private var activeGift:ImageSprite;
	private var timeLabel:TextSprite;

	public function new() {
		grayGift = new ImageSprite(G.pack.getTexture("icons/gift"));
		grayGift.centerAnchor();
		grayGift.setXY(146, 330);
		new Entity().add(grayGift);
		
		timeLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), "2:43");
		timeLabel.setAlign(TextAlign.Center);
		timeLabel.setXY(grayGift.getNaturalWidth() / 2, -24);
		grayGift.owner.addChild(new Entity().add(timeLabel));
		
		activeGift = new ImageSprite(G.pack.getTexture("icons/gift_btn"));
		activeGift.centerAnchor();
		activeGift.setXY(146, 330);
		activeGift.scaleX.behavior = new Sine(1, 1.06, 0.4);
		activeGift.scaleY.behavior = new Sine(1, 1.06, 0.4);
		activeGift.pointerDown.connect(onClickGift);
		new Entity().add(activeGift);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(grayGift.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (G.gameData.giftTimer <= 0) {
			owner.addChild(activeGift.owner);
		} else {
			G.gameData.giftTimer -= dt;
			timeLabel.text = TimeFormatter.minutesFormat(Std.int(G.gameData.giftTimer));
			owner.removeChild(activeGift.owner);
		}
	}
	
	function onClickGift(e:PointerEvent) {
		owner.removeChild(activeGift.owner);
		G.gameData.giftTimer = DELAY;
		var money:Float = calculateMoney();
		G.gameData.money += money;
		GameScreen.instance.showMoneyBonus(money);
	}
	
	private function calculateMoney():Float {
		if (G.gameData.flags == 0) {
			return 200;
		}
		return G.gameData.flags * 200;
	}
	
}