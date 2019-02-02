package motogp.screens;

import flambe.Component;
import flambe.Entity;
import flambe.System;
import flambe.animation.AnimatedFloat;
import flambe.asset.AssetPack;
import flambe.asset.Manifest;
import flambe.display.FillSprite;
import flambe.display.ImageSprite;
import flambe.scene.Scene;
import flambe.util.Promise;
import format.tools.Image;
import motogp.tools.ProgressBar;

/**
 * ...
 * @author Vladimir
 */
class PreloaderScreen extends Component {
	private var bootstrapPack:AssetPack;
	private var loader:Promise<AssetPack>;
	private var progress:AnimatedFloat = new AnimatedFloat(0);
	private var background:FillSprite;
	private var logo:ImageSprite;
	private var bar:ProgressBar;

	public function new(pack:AssetPack) {
		bootstrapPack = pack;
		var manifest = Manifest.fromAssets("game");
		loader = System.loadAssetPack(manifest);
		loader.get(onLoad);
		loader.progressChanged.connect(onProgress);
		
		background = new FillSprite(0x000000, G.width, G.height);
		new Entity().add(background);
		
		logo = new ImageSprite(pack.getTexture("logo"));
		logo.centerAnchor();
		logo.setXY(G.width / 2, G.height / 2);
		new Entity().add(logo);
		
		bar = new ProgressBar(
			new ImageSprite(pack.getTexture("long_bar_back")),
			new ImageSprite(pack.getTexture("long_bar_front")),
			progress
		);
		bar.back.centerAnchor();
		bar.front.setXY(6, 6);
		bar.back.setXY(G.width / 2, 500);
		new Entity().add(bar);
	}
	
	override public function onAdded() {
		super.onAdded();
		
		owner.addChild(background.owner);
		owner.addChild(logo.owner);
		owner.addChild(bar.owner);
	}
	
	function onProgress() {
		progress._ = loader.progress / loader.total;
	}
	
	function onLoad(pack:AssetPack) {
		G.pack = pack;
		G.director.unwindToScene(new Entity().add(new Scene()).add(new GameScreen()));
	}
	
}