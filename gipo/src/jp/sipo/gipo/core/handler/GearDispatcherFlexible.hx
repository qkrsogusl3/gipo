package jp.sipo.gipo.core.handler;
/**
 * 実行時に自由な動作を選べるDispatcher
 * 
 * @auther sipo
 */
import haxe.PosInfos;
import jp.sipo.gipo.core.handler.GenericGearDispatcher;
class GearDispatcherFlexible<TFunc> extends GenericGearDispatcher<TFunc>
{
	public function new(addBehavior:GearDispatcherAddBehavior<TFunc>, once:Bool, ?pos:PosInfos)
	{
		super(addBehavior, once, pos);
	}
	
	/**
	 * ハンドラを登録する
	 */
	public function add(func:TFunc, ?addPos:PosInfos):CancelKey
	{
		return genericAdd(func, addPos);
	}
	
	/**
	 * 登録されたハンドラを実行する
	 */
	public function execute(trat:GearDispatcherHandler<TFunc> -> Void):Void
	{
		genericExecute(trat);
	}
}
