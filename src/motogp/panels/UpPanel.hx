package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import motogp.tools.BigNumber;

/**
 * ...
 * @author Vladimir
 */
class UpPanel extends Component {
	private var gearIcon:ImageSprite;
	private var coinIcon:ImageSprite;
	private var gearLabel:TextSprite;
	private var coinLabel:TextSprite;
	private var minusGears:TextSprite;
	private var plusCoins:TextSprite;

	public function new() {
		gearIcon = new ImageSprite(G.pack.getTexture("icons/big_gear"));
		gearIcon.centerAnchor();
		gearIcon.setXY(500, 38);
		new Entity().add(gearIcon);
		
		coinIcon = new ImageSprite(G.pack.getTexture("icons/big_coin"));
		coinIcon.centerAnchor();
		coinIcon.setXY(656, 38);
		new Entity().add(coinIcon);
		
		gearLabel = new TextSprite(new Font(G.pack, "fonts/red_font_24"), BigNumber.format(G.gameData.gears));
		gearLabel.setAlign(TextAlign.Left);
		gearLabel.setXY(532, -38);
		new Entity().add(gearLabel);
		
		coinLabel = new TextSprite(new Font(G.pack, "fonts/yellow_font_24"), BigNumber.format(G.gameData.money));
		coinLabel.setAlign(TextAlign.Left);
		coinLabel.setXY(686, -38);
		new Entity().add(coinLabel);
		
		minusGears = new TextSprite(new Font(G.pack, "fonts/red_font_12"), "-0");
		minusGears.setAlign(TextAlign.Left);
		minusGears.setXY(532, 43);
		new Entity().add(minusGears);
		
		plusCoins = new TextSprite(new Font(G.pack, "fonts/yellow_font_12"), "+0");
		plusCoins.setAlign(TextAlign.Left);
		plusCoins.setXY(686, 43);
		new Entity().add(plusCoins);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(gearIcon.owner);
		owner.addChild(coinIcon.owner);
		owner.addChild(gearLabel.owner);
		owner.addChild(coinLabel.owner);
		owner.addChild(minusGears.owner);
		owner.addChild(plusCoins.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		gearLabel.text = BigNumber.format(G.gameData.gears);
		coinLabel.text = BigNumber.format(G.gameData.money);
		
		var coins:Float = 0;
		var gears:Float = 0;
		for (i in G.gameData.bikesData) {
			if (i.isOpen) {
				coins += i.award;
				gears += i.gears;
			}
		}
		
		if (gears < 9999999999) {
			minusGears.text = "-" + gears;
		} else {
			minusGears.text = "-" + BigNumber.format(gears);
		}
		plusCoins.text = "+" + BigNumber.format(coins);
	}
	
}