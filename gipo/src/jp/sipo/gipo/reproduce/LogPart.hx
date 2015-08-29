package jp.sipo.gipo.reproduce;
/**
 * Logの1単位
 * ReadOnlyにしたいところだが、データ構造が深く、処理速度の関係で断念。
 * ファイル単位で２つ作れば問題ない
 * 
 * @author sipo
 */
import haxe.PosInfos;
class LogPart<TUpdateKind>
{
	/* 再現フェーズ */
	private var phase:ReproducePhase<TUpdateKind>;
	/** 発生フレーム */
	public var frame(default, null):Int;
	/** ログ情報 */
	public var logway(default, null):LogwayKind;
	/** 要因となったコードの場所情報 */
	public var factorPos(default, null):PosInfos;
	/* 通し番号 */
	private var id:Int = -1; // MEMO:Optionを使用したいところだが速度優先で、無しは-1に
	
	/** コンストラクタ */
	public function new(phase:ReproducePhase<TUpdateKind>, frame:Int, logway:LogwayKind, factorPos:PosInfos) 
	{
		this.phase = phase;
		this.frame = frame;
		this.logway = logway;
		this.factorPos = factorPos;
	}
	
	/**
	 * デバッグのためのIDを追加
	 */
	public function setId(id:Int):Void
	{
		this.id = id;
	}
	
	/**
	 * 同じログかどうかをチェックする。１度ファイル化されていることを考慮して、参照比較は出来ない場合に使用する。
	 * 比較するのはphaseとlogwayで、違うframeとidでも、内容が同じであれば同じものと判断する。
	 */
	public function isSame(target:LogPart<TUpdateKind>):Bool
	{
		return Type.enumEq(this.phase, target.phase) && Type.enumEq(this.logway, target.logway);
	}
	
	/**
	 * 対象のLogwayがReadyかどうか判別する
	 */
	public function isReadyLogway():Bool
	{
		return switch(logway)
		{
			case LogwayKind.Ready(_) : true;
			case LogwayKind.Instant(_), LogwayKind.Snapshot(_): false;
		}
	}
	
	/**
	 * 対象のPhaseがフレーム外かどうか判別する
	 */
	public function isOutFramePhase<TUpdateKind>():Bool
	{
		return switch(phase)
		{
			case ReproducePhase.OutFrame : true;
			case ReproducePhase.InFrame(_): false;
		}
	}
	
	/**
	 * 対象と同じフェーズかどうかチェック
	 */
	public function equalPhase(phase:ReproducePhase<TUpdateKind>):Bool
	{
		return Type.enumEq(this.phase, phase);
	}
	
	/**
	 * 文字列表現
	 */
	public function toString():String
	{
		return '[LogPart $frame logway=$logway phase=$phase id=$id]';
	}
}
/**
 * 再現のタイミングの種類
 * 
 * @auther sipo
 */
enum ReproducePhase<TUpdateKind>
{
	/** フレームとフレームの間で発生する。ユーザー入力やロード待ちなどほとんどがこれ */
	OutFrame;
	/** Updateタイミングで発生するもの。ドラッグなど */
	InFrame(kind:TUpdateKind);
}
/**
 * Logの記録と再生方法の種類
 */
enum LogwayKind
{
	/** 対象タイミングで実行 */
	Instant(command:EnumValue);
	/** 対象タイミングで準備が整うまで全体を待たせる（再現時に、ダミーの値だけではなく、実際にリソースを用意したりする必要がある場合） */
	Ready(command:EnumValue);
	/** Logicを生成するのに必要。再生の最初のほか、途中再開にも使用できる */
	Snapshot(value:Snapshot);
}
