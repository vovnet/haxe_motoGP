package motogp.panels;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.animation.AnimatedFloat;
import flambe.display.Font;
import flambe.display.ImageSprite;
import flambe.display.TextSprite;
import kong.KongStats;
import motogp.screens.GameScreen;
import motogp.tools.ProgressBar;

/**
 * ...
 * @author Vladimir
 */
class Distance extends Component {
	private static var maxDistance:Float = 100000;
	private var game:GameScreen;
	
	private var bar:ProgressBar;
	private var progress:AnimatedFloat = new AnimatedFloat(0);
	private var flagIcon:ImageSprite;
	private var label:TextSprite;

	public function new(game:GameScreen) {
		this.game = game;
		
		bar = new ProgressBar(
			new ImageSprite(G.pack.getTexture("bars/long_bar_back")),
			new ImageSprite(G.pack.getTexture("bars/long_bar_front")),
			progress
		);
		bar.back.setRotation(-90);
		bar.back.setXY(5, 584);
		bar.front.setXY(6, 6);
		new Entity().add(bar);
		
		flagIcon = new ImageSprite(G.pack.getTexture("icons/flag"));
		flagIcon.setXY(0, 20);
		new Entity().add(flagIcon);
		
		label = new TextSprite(new Font(G.pack, "fonts/white_font_18"), "0");
		label.setXY(52, -30);
		new Entity().add(label);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(bar.owner);
		owner.addChild(flagIcon.owner);
		owner.addChild(label.owner);
		
		start();
	}
	
	override public function onUpdate(dt:Float) {
		super.onUpdate(dt);
		
		if (G.gameData.distance >= maxDistance) {
			game.showNewLevel();
			G.gameData.flags++;
			G.gameData.distance = 0;
			start();
			KongStats.submit("Flags", Std.int(G.gameData.flags));
		}
		
		progress._ = G.gameData.distance / maxDistance;
		
		label.text = Std.string(G.gameData.flags);
		
	}
	
	private function start() {
		var length:Float = (G.gameData.flags == 0) ? 1 : G.gameData.flags;
		maxDistance = length * 300;
	}
	
}