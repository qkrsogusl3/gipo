package jp.sipo.gipo.core.template;
class GearHolderTemplate extends GearHolderImpl
{
	/** コンストラクタ */
	public function new()
	{
		super();
		gear.addDiffusibleHandler(diffusible);
		gear.addRunHandler(run);
	}
	
	/* 初期化処理 */
	private function diffusible(tool:GearDiffuseTool):Void
	{
		// インスタンスの取得
		gear.absorb;
		
		// インスタンスの拡散
		tool.diffuse;
		
		// 子の追加
		tool.bookChild;
		
		// 解除処理
		gear.disposeTask(function (){
			
		});
	}
	
	/* 開始処理 */
	private function run():Void
	{
		
	}
}
