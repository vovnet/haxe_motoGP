package motogp.bikes;

import flambe.Component;
import flambe.Entity;
import flambe.animation.AnimatedFloat;
import flambe.animation.Sine;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import flambe.math.Point;
import flambe.util.Signal1;
import flambe.util.Signal2;
import format.tools.Image;
import motogp.data.BikeData;
import motogp.tools.BigNumber;
import motogp.tools.Button;
import motogp.tools.ProgressBar;

/**
 * ...
 * @author Vladimir
 */
class UnlockedBike extends Component {
	private var data:BikeData;
	private var position:Point;
	private var background:ImageSprite;
	private var nameLabel:TextSprite;
	private var image:ImageSprite;
	private var upgradeBtn:Button;
	private var upgradeLabel:TextSprite;
	private var gearIcon:ImageSprite;
	private var coinIcon:ImageSprite;
	private var gearLabel:TextSprite;
	private var coinLabel:TextSprite;
	private var grayBtn:ImageSprite;
	private var grayBtnLabel:TextSprite;
	private var progress:AnimatedFloat = new AnimatedFloat(0);
	private var bar:ProgressBar;
	
	private var gearSine:Sine = new Sine(1, 0 ,0.3);

	public function new(data:BikeData, position:Point) {
		this.data = data;
		this.position = position;
		progress._ = data.timeToFihish / data.speed;
		
		background = new ImageSprite(G.pack.getTexture("unlocked_back"));
		background.setXY(position.x, position.y);
		new Entity().add(background);
		
		image = new ImageSprite(G.pack.getTexture("bikes/" + data.image));
		image.setXY(4, 4);
		new Entity().add(image);
		
		nameLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), data.name);
		nameLabel.align = TextAlign.Center;
		nameLabel.setXY(158, -58);
		new Entity().add(nameLabel);
		
		grayBtn = new ImageSprite(G.pack.getTexture("buttons/small_haki_btn"));
		grayBtn.centerAnchor();
		grayBtn.setXY(47, 75);
		new Entity().add(grayBtn);
		
		grayBtnLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(data.upgradePrice));
		grayBtnLabel.align = TextAlign.Center;
		grayBtnLabel.setXY(grayBtn.getNaturalWidth() / 2, -53);
		grayBtnLabel.setAlpha(0.5);
		new Entity().add(grayBtnLabel);
		grayBtn.owner.addChild(grayBtnLabel.owner);
		
		upgradeBtn = new Button("buttons/small_green_btn");
		upgradeBtn.setXY(47, 75);
		upgradeBtn.eventClick.connect(onClickUpgradeBtn);
		new Entity().add(upgradeBtn);
		
		upgradeLabel = new TextSprite(new Font(G.pack, "fonts/white_font_18"), BigNumber.format(data.upgradePrice));
		upgradeLabel.align = TextAlign.Center;
		upgradeLabel.setXY(upgradeBtn.getWidth() / 2, -53);
		new Entity().add(upgradeLabel);
		upgradeBtn.owner.addChild(upgradeLabel.owner);
		
		gearIcon = new ImageSprite(G.pack.getTexture("icons/small_gear"));
		gearIcon.setXY(96, 60);
		new Entity().add(gearIcon);
		
		coinIcon = new ImageSprite(G.pack.getTexture("icons/small_coin"));
		coinIcon.setXY(160, 62);
		new Entity().add(coinIcon);
		
		gearLabel = new TextSprite(new Font(G.pack, "fonts/red_font_12"), Std.string(data.gears));
		gearLabel.align = TextAlign.Left;
		gearLabel.setXY(128, 65);
		new Entity().add(gearLabel);
		
		coinLabel = new TextSprite(new Font(G.pack, "fonts/white_font_14"), BigNumber.format(data.award));
		coinLabel.align = TextAlign.Left;
		coinLabel.setXY(190, 0);
		new Entity().add(coinLabel);
		
		bar = new ProgressBar(
			new ImageSprite(G.pack.getTexture("bars/small_bar_back")), 
			new ImageSprite(G.pack.getTexture("bars/small_bar_front")),
			progress
		);
		bar.back.setXY(97, 30);
		bar.front.setXY(2, 3);
		new Entity().add(bar);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(background.owner);
		
		background.owner.addChild(image.owner);
		background.owner.addChild(nameLabel.owner);
		background.owner.addChild(grayBtn.owner);		
		background.owner.addChild(upgradeBtn.owner);
		background.owner.addChild(gearIcon.owner);
		background.owner.addChild(coinIcon.owner);
		background.owner.addChild(gearLabel.owner);
		background.owner.addChild(coinLabel.owner);
		background.owner.addChild(bar.owner);
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (progress._ >= 1) {
			progress._ = 0;
			G.gameData.money += data.currentAward;
			G.gameData.distance += data.speed;
			data.timeToFihish = 0;
		} else if (progress._ == 0 && G.gameData.gears >= data.gears) {
			G.gameData.gears -= data.gears;
			data.currentAward = data.award;
			data.timeToFihish += dt;
		} else if (progress._ > 0 && progress._ < 1) {
			data.timeToFihish += dt;
		}
		
		progress._ = data.timeToFihish / data.speed;
		
		if (G.gameData.money >= data.upgradePrice) {
			background.owner.addChild(upgradeBtn.owner);
			background.owner.removeChild(grayBtn.owner);
		} else {
			 background.owner.removeChild(upgradeBtn.owner);
			background.owner.addChild(grayBtn.owner);
		}
		
		grayBtnLabel.text = BigNumber.format(data.upgradePrice);
		upgradeLabel.text = BigNumber.format(data.upgradePrice);
		gearLabel.text = "-" + BigNumber.format(data.gears);
		coinLabel.text = "+" + BigNumber.format(data.award);
		
		if (G.gameData.gears < data.gears) {
			gearIcon.alpha.behavior = gearSine;
		} else {
			gearIcon.alpha.behavior = null;
			gearIcon.setAlpha(1);
		}
	}
	
	function onClickUpgradeBtn() {
		if (G.gameData.money >= data.upgradePrice) {
			G.pack.getSound("sounds/buy").play();
			G.gameData.money -= data.upgradePrice;
			data.upgradePrice += data.awardRait;
			data.gears++;
			data.award += data.awardRait;
		}
	}
	
}