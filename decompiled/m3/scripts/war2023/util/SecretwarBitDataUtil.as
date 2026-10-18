package war2023.util
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.events.MouseEvent;
   import war2023.item.SecretWarNodeItem;
   
   public class SecretwarBitDataUtil
   {
      
      private static var _fightFlg:BitmapData;
      
      private static var _scoreBar:BitmapData;
      
      public static var currNodeItem:SecretWarNodeItem;
      
      private static var _qzList:Array = [];
      
      private static var _proBarList:Array = [];
      
      private static var _smapList:Array = [];
      
      private static var _houstList:Array = [];
      
      private static var _moveIconList:Array = [];
      
      private static var _posList:Array = [];
      
      private static var _peaceFlg:Array = [];
      
      private static var _defFlg:Array = [];
      
      private static var _bitDatas:Array = [];
      
      public function SecretwarBitDataUtil()
      {
         super();
      }
      
      public static function setup() : void
      {
         var _loc3_:int = 0;
         var _loc1_:BitmapData = null;
         var _loc2_:int = 0;
         _fightFlg = ComponentFactory.Instance.creatBitmap("asset.secretwar.fightNodeFlg").bitmapData;
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.qz" + _loc3_).bitmapData;
            _qzList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.Probar" + _loc3_).bitmapData;
            _proBarList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 17)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.mapNode" + _loc3_).bitmapData;
            _smapList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = _loc2_;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.house" + _loc3_).bitmapData;
            _houstList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.playicon" + _loc3_).bitmapData;
            _moveIconList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwar.position" + _loc3_).bitmapData;
            _posList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = _loc2_;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwa.peaceFlg" + _loc3_).bitmapData;
            _peaceFlg.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = _loc2_ + 1;
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.secretwa.defFlg" + _loc3_).bitmapData;
            _defFlg.push(_loc1_);
            _loc2_++;
         }
         _scoreBar = ComponentFactory.Instance.creatBitmap("asset.secretwar.scorebar").bitmapData;
         if(_bitDatas.length == 0)
         {
            _bitDatas[0] = ComponentFactory.Instance.creatBitmapData("asset.secretwar.result.selfbg");
            _bitDatas[1] = ComponentFactory.Instance.creatBitmapData("asset.secretwar.result.bulebg");
            _bitDatas[2] = ComponentFactory.Instance.creatBitmapData("asset.secretwar.result.redbg");
         }
         addEvent();
      }
      
      private static function addEvent() : void
      {
         StageReferance.stage.addEventListener("click",stageClickHandler);
      }
      
      private static function removeEvent() : void
      {
         StageReferance.stage.removeEventListener("click",stageClickHandler);
         currNodeItem = null;
      }
      
      private static function stageClickHandler(param1:MouseEvent) : void
      {
         if(currNodeItem)
         {
            currNodeItem.isMenu = false;
         }
      }
      
      public static function get fightFlg() : BitmapData
      {
         return _fightFlg;
      }
      
      public static function get scoreBar() : BitmapData
      {
         return _scoreBar;
      }
      
      public static function getQz(param1:int) : BitmapData
      {
         return _qzList[param1 - 1];
      }
      
      public static function getProBar(param1:int) : BitmapData
      {
         return _proBarList[param1 - 1];
      }
      
      public static function getSmallMap(param1:int) : BitmapData
      {
         return _smapList[param1 - 1];
      }
      
      public static function getHouse(param1:int) : BitmapData
      {
         return _houstList[param1];
      }
      
      public static function getMoveIcon(param1:int) : BitmapData
      {
         return _moveIconList[param1 - 1];
      }
      
      public static function getPosFlg(param1:int) : BitmapData
      {
         return _posList[param1 - 1];
      }
      
      public static function getPeaceFlg(param1:int) : BitmapData
      {
         return _peaceFlg[param1];
      }
      
      public static function getDefFlg(param1:int) : BitmapData
      {
         return _defFlg[param1 - 1];
      }
      
      public static function get bitDatas() : Array
      {
         return _bitDatas;
      }
      
      public static function clearBitDatas() : void
      {
         for each(var _loc1_:BitmapData in _bitDatas)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _bitDatas.length = 0;
      }
      
      public static function clear() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _qzList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _qzList.length = 0;
         for each(_loc1_ in _proBarList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _proBarList.length = 0;
         for each(_loc1_ in _smapList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _smapList.length = 0;
         for each(_loc1_ in _houstList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _houstList.length = 0;
         for each(_loc1_ in _moveIconList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _moveIconList.length = 0;
         for each(_loc1_ in _posList)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _posList.length = 0;
         for each(_loc1_ in _peaceFlg)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _peaceFlg.length = 0;
         for each(_loc1_ in _defFlg)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         _defFlg.length = 0;
         ObjectUtils.disposeObject(_fightFlg);
         _fightFlg = null;
         removeEvent();
      }
   }
}

