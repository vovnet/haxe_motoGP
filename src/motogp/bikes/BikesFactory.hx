package motogp.bikes;
import motogp.data.BikeData;

/**
 * ...
 * @author Vladimir
 */
class BikesFactory {
	private var bikes:Array<BikeData> = new Array<BikeData>();
	
	private var visuals:Array<BikeStruct> = [
		new BikeStruct("cbr-250f", "cbr_250f"),
		new BikeStruct("ktm-rc-200", "ktm_rc_200"),
		new BikeStruct("ninja-250r", "ninja_250r"),
		new BikeStruct("ninja-h2", "ninja_h2"),
		new BikeStruct("r-125", "r_125"),
		new BikeStruct("r4-250", "r4_250"),
		new BikeStruct("rs-125", "rs_125"),
		new BikeStruct("rs4-125", "rs4_125"),
		new BikeStruct("yzf-125", "yzf_125"),
		new BikeStruct("yzf-250", "yzf_250"),
		new BikeStruct("yzf-r-125", "yzf_r_125"),
		new BikeStruct("yzf-r-250", "yzf_r_250"),
		new BikeStruct("z-250", "z_250"),
		new BikeStruct("cbr-300rr", "cbr_300rr"),
		new BikeStruct("cbr-400rr", "cbr_400rr"),
		new BikeStruct("gsx-r-350", "gsx_r_350"),
		new BikeStruct("gsx-r-400", "gsx_r_400"),
		new BikeStruct("h2-r-black", "h2_r_black"),
		new BikeStruct("ninja-300", "ninja_300"),
		new BikeStruct("ninja-300-abs", "ninja_300_abs"),
		new BikeStruct("nja-300-razor", "ninja_300_razor"),
		new BikeStruct("ninja-350r", "ninja_350r"),
		new BikeStruct("cb-500x", "cb_500x"),
		new BikeStruct("cb-500-abs", "cb_500x_abs"),
		new BikeStruct("cb-600f", "cb_600f"),
		new BikeStruct("cbr-600f4", "cbr_600f4"),
		new BikeStruct("cbr-600rr", "cbr_600rr"),
		new BikeStruct("cbr-600rr-red", "cbr_600rr_red"),
		new BikeStruct("600rr-repsol", "cbr_600rr_repsol"),
		new BikeStruct("ducati-600", "ducati_600"),
		new BikeStruct("gsx-r-600", "gsx_r_600"),
		new BikeStruct("yamaha-r6", "r6"),
		new BikeStruct("r6-blood", "r6_blood"),
		new BikeStruct("r6-night", "r6_night"),
		new BikeStruct("r6-sea", "r6_sea"),
		new BikeStruct("rs-450b", "rs_450b"),
		new BikeStruct("yzf-r6", "yzf_r6"),
		new BikeStruct("cbr-650f", "cbr_650f"),
		new BikeStruct("cbr-954rr", "cbr_954rr"),
		new BikeStruct("ducati-950", "ducati_950"),
		new BikeStruct("gsr-750", "gsr_750"),
		new BikeStruct("ktm-rc-800", "ktm_rc_800"),
		new BikeStruct("nc-700xa", "nc_700xa"),
		new BikeStruct("ninja-650r", "ninja_650r"),
		new BikeStruct("ninja-750r", "ninja_750r"),
		new BikeStruct("cb-1000r", "cb_1000r"),
		new BikeStruct("1000rr-black", "cbr_1000rr_black"),
		new BikeStruct("1000rr-repsol", "cbr_1000rr_repsol"),
		new BikeStruct("1000rr-sporty", "cbr_1000rr_sporty"),
		new BikeStruct("duke-black", "duke_black"),
		new BikeStruct("gsx-r-1000", "gsx_r_1000"),
		new BikeStruct("ktm-1000", "ktm_1000"),
		new BikeStruct("ninja-1000", "ninja_1000"),
		new BikeStruct("panigale-r", "panigale_r"),
		new BikeStruct("yamaha-r1", "r1"),
		new BikeStruct("r1-gray", "r1_gray"),
		new BikeStruct("r1-razor", "r1_razor"),
		new BikeStruct("r1-red", "r1_red"),
		new BikeStruct("r1-zip", "r1_zip"),
		new BikeStruct("gsx-rr-1200", "gsx_rr_1200"),
		new BikeStruct("ktm-1200", "ktm_1200"),
		new BikeStruct("ktm-1290", "ktm_1290"),
		new BikeStruct("rs-gp", "rs_gp"),
		new BikeStruct("rsv-4-black", "rsv_4_black"),
		new BikeStruct("rsv-4-red", "rsv_4_red"),
		new BikeStruct("rsv-4-gp", "rsv_4gp"),
		new BikeStruct("rsv-4-rr", "rsv_4rr"),
		new BikeStruct("rsv-4rr-speed", "rsv_4rr_speed"),
		new BikeStruct("zx-14-toxic", "zx_14_toxic"),
		new BikeStruct("zx-14r", "zx_14r")
	];

	public function new() {
		
	}
	
	public function getBikes():Array<BikeData> {
		var openPrice:Float = 500;
		var upgradePrice:Float = 3;
		var gears:Float = 1;
		var award:Float = 1;
		var speed:Float = 2;
		var awardRate:Float = 1;
		
		for (i in 0...70) {
			bikes.push(new BikeData().init(
				visuals[i].name,
				visuals[i].image,
				false,
				openPrice,
				upgradePrice,
				speed,
				gears,
				award,
				awardRate
			));
			
			/*
			trace("open price: " + openPrice);
			trace("upgr price: " + upgradePrice);
			trace("");
			*/
			
			openPrice *= 1.3;
			gears += 1;
			award += 6;
			speed += 5;
			awardRate += 6;
			upgradePrice += award;
		}
		return bikes;
	}
	
}