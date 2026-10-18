package consortiachess.util
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import consortiachess.board.ChesspvpBoxItem;
   import consortiachess.board.ConsortiaChessBasePiece;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.utils.Dictionary;
   import utils.LogicUtils;
   
   public class ChesspvpResourceUtil
   {
      
      private static var _ins:ChesspvpResourceUtil;
      
      public var whiteBoxData:BitmapData;
      
      public var blackBoxData:BitmapData;
      
      public var teamBoxData:BitmapData;
      
      public var fightEffData:BitmapData;
      
      public var buffDataList:Dictionary;
      
      public var roleDataList:Array;
      
      public var whiteRoleDataList:Array;
      
      public var blackRoleDataList:Array;
      
      public var selfBit:Bitmap;
      
      public var chooseBit:Bitmap;
      
      public var lastChooseItem:ChesspvpBoxItem;
      
      public var selfChess:ConsortiaChessBasePiece;
      
      private var _count:int = 0;
      
      public function ChesspvpResourceUtil()
      {
         super();
      }
      
      public static function get ins() : ChesspvpResourceUtil
      {
         if(_ins == null)
         {
            _ins = new ChesspvpResourceUtil();
         }
         return _ins;
      }
      
      public function initData() : void
      {
         var _loc1_:BitmapData = null;
         var _loc2_:int = 0;
         if(_count == 0)
         {
            whiteBoxData = ComponentFactory.Instance.creatBitmap("asset.chesspvp.box1").bitmapData;
            blackBoxData = ComponentFactory.Instance.creatBitmap("asset.chesspvp.box2").bitmapData;
            teamBoxData = ComponentFactory.Instance.creatBitmap("asset.chesspvp.moreRole").bitmapData;
            fightEffData = ComponentFactory.Instance.creatBitmap("asset.chesspvp.fightState").bitmapData;
            selfBit = ComponentFactory.Instance.creatBitmap("asset.chesspvp.selfState");
            chooseBit = ComponentFactory.Instance.creatBitmap("asset.chesspvp.choooseState");
            buffDataList = new Dictionary();
            roleDataList = [];
            whiteRoleDataList = [];
            blackRoleDataList = [];
            _loc2_ = 1;
            while(_loc2_ <= 6)
            {
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.chesspvp.role" + _loc2_).bitmapData;
               roleDataList[_loc2_] = _loc1_;
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.chesspvp.w" + _loc2_).bitmapData;
               whiteRoleDataList[_loc2_] = _loc1_;
               _loc1_ = ComponentFactory.Instance.creatBitmap("asset.chesspvp.b" + _loc2_).bitmapData;
               blackRoleDataList[_loc2_] = _loc1_;
               _loc2_++;
            }
            buffDataList[10] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff10").bitmapData;
            buffDataList[11] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff11").bitmapData;
            buffDataList[12] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff12").bitmapData;
            buffDataList[20] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff20").bitmapData;
            buffDataList[21] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff21").bitmapData;
            buffDataList[22] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff22").bitmapData;
            buffDataList[30] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff30").bitmapData;
            buffDataList[31] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff31").bitmapData;
            buffDataList[32] = ComponentFactory.Instance.creatBitmap("asset.chesspvp.buff32").bitmapData;
         }
         _count = _count + 1;
      }
      
      public function clean() : void
      {
         _count = _count - 1;
         if(_count == 0)
         {
            ObjectUtils.disposeObject(whiteBoxData);
            whiteBoxData = null;
            ObjectUtils.disposeObject(blackBoxData);
            blackBoxData = null;
            ObjectUtils.disposeObject(teamBoxData);
            teamBoxData = null;
            ObjectUtils.disposeObject(fightEffData);
            fightEffData = null;
            ObjectUtils.disposeObject(selfBit);
            selfBit = null;
            ObjectUtils.disposeObject(chooseBit);
            chooseBit = null;
            LogicUtils.disposeDisplayCollection(buffDataList);
            buffDataList = null;
            LogicUtils.disposeDisplayCollection(roleDataList);
            roleDataList = null;
            LogicUtils.disposeDisplayCollection(whiteRoleDataList);
            whiteRoleDataList = null;
            LogicUtils.disposeDisplayCollection(blackRoleDataList);
            blackRoleDataList = null;
            lastChooseItem = null;
            selfChess = null;
         }
      }
   }
}

