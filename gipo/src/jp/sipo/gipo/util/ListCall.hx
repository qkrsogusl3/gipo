package jp.sipo.gipo.util;
/**
 * リスト関数の呼び出しショートカット
 * 
 * @author sipo
 */
class ListCall {
	
	/* ハンドラの呼び出しショートカット */
	inline static public function call(funcList:Array<Void -> Void>):Void
	{
		for (i in 0...funcList.length) {
			Reflect.callMethod(null, funcList[i], []);
		}
	}
	
	/* ハンドラの呼び出しショートカット */
	inline static public function withArgument(funcList:Dynamic/*Array<? -> Void>*/, argumentList:Array<Dynamic>):Void
	{
		for (i in 0...funcList.length) {
			Reflect.callMethod(null, funcList[i], argumentList);
		}
	}
}
