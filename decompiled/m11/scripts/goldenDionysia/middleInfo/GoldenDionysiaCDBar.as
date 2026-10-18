package goldenDionysia.middleInfo
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.display.Bitmap;
   import utils.LogicUtils;
   import yishi.utils.TimerUtils;
   
   public class GoldenDionysiaCDBar extends Component
   {
      
      private var _curPhase:int = -1;
      
      private var _cdUnitItemList:Vector.<CDUnitItem>;
      
      private var _cdTilteBmpList:Vector.<Bitmap>;
      
      private var _myTimeID:String = "GoldenDionysiaCDBar";
      
      private var _curSecend:uint = 0;
      
      private const UPDATE_THRESHOLD:uint = 5;
      
      public function GoldenDionysiaCDBar()
      {
         var _loc1_:Bitmap = null;
         var _loc3_:* = 0;
         var _loc2_:CDUnitItem = null;
         var _loc5_:* = 0;
         super();
         _cdTilteBmpList = new Vector.<Bitmap>();
         _cdTilteBmpList.push(ComponentFactory.Instance.creatBitmap("asset.goldendionysia.betTitle"),ComponentFactory.Instance.creatBitmap("asset.goldendionysia.lotteryTitle"));
         var _loc4_:uint = 0;
         _loc3_ = 0;
         while(_loc3_ < _cdTilteBmpList.length)
         {
            _loc1_ = _cdTilteBmpList[_loc3_];
            _loc1_.visible = false;
            addChild(_loc1_);
            if(_loc1_.width > _loc4_)
            {
               _loc4_ = _loc1_.width;
            }
            _loc3_++;
         }
         _cdUnitItemList = new Vector.<CDUnitItem>();
         _loc5_ = 0;
         while(_loc5_ < 3)
         {
            _loc2_ = new CDUnitItem(_loc5_);
            _loc2_.x = _loc4_;
            _loc4_ += _loc2_.width;
            _cdUnitItemList.push(_loc2_);
            addChild(_loc2_);
            _loc5_++;
         }
      }
      
      public function startCD(param1:Number) : void
      {
         TimerUtils.removeSecendTimer(_myTimeID);
         updateUI(0,0,0);
         TimerUtils.addSecendTimer(_myTimeID,0,param1,refreshCDNumHandler);
      }
      
      public function set curPhase(param1:int) : void
      {
         for each(var _loc2_:Bitmap in _cdTilteBmpList)
         {
            _loc2_.visible = false;
         }
         _curPhase = param1;
         _cdTilteBmpList[_curPhase].visible = true;
      }
      
      private function updateUI(param1:uint, param2:uint, param3:uint) : void
      {
         var _loc7_:* = 0;
         var _loc5_:* = arguments;
         for each(var _loc6_:CDUnitItem in _cdUnitItemList)
         {
            _loc6_.updateUI(_loc5_[_loc7_]);
            _loc7_++;
         }
      }
      
      private function refreshCDNumHandler() : void
      {
         var _loc3_:int = int(TimerUtils.getTime(_myTimeID));
         var _loc4_:Number = Math.floor(_loc3_ / 86400);
         var _loc2_:int = (_loc3_ - _loc4_ * 24 * 3600) / 3600;
         var _loc1_:int = Math.floor((_loc3_ - _loc4_ * 24 * 3600 - _loc2_ * 3600) / 60);
         if(_loc3_ <= 0)
         {
            TimerUtils.removeSecendTimer(_myTimeID);
            return;
         }
         updateUI(_loc4_,_loc2_,_loc1_);
         _curSecend = _curSecend + 1;
         if(_curSecend >= 5)
         {
            _curSecend = 0;
         }
      }
      
      override public function dispose() : void
      {
         TimerUtils.removeSecendTimer(_myTimeID);
         LogicUtils.disposeDisplayCollection(_cdUnitItemList);
         _cdUnitItemList = null;
         LogicUtils.disposeDisplayCollection(_cdTilteBmpList);
         _cdTilteBmpList = null;
         super.dispose();
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Disposeable;
import com.pickgliss.utils.ObjectUtils;
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Sprite;
import yishi.utils.NumberViewUtils;

class CDUnitItem extends Sprite implements Disposeable
{
   
   public static const DAY_TYPE:uint = 0;
   
   public static const HOUR_TYPE:uint = 1;
   
   public static const MIN_TYPE:uint = 2;
   
   public static const TYPE_COUNT:uint = 3;
   
   private var _curNum:int = -1;
   
   private var _curUnit:uint;
   
   private var _timeUnitBmp:Bitmap;
   
   private var _numBgBmp:Bitmap;
   
   private var _numBmd:BitmapData;
   
   private var _numContainer:Sprite;
   
   public function CDUnitItem(param1:uint)
   {
      var _loc2_:String = null;
      super();
      _curUnit = param1;
      switch(int(_curUnit))
      {
         case 0:
            _loc2_ = "asset.goldendionysia.day";
            break;
         case 1:
            _loc2_ = "asset.goldendionysia.hour";
            break;
         case 2:
            _loc2_ = "asset.goldendionysia.min";
      }
      _numBmd = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.cdNum").bitmapData;
      _numContainer = ComponentFactory.Instance.creatCustomObject("goldenDionysia.CDUnitItem.numContainer");
      _timeUnitBmp = ComponentFactory.Instance.creatBitmap(_loc2_);
      _numBgBmp = ComponentFactory.Instance.creatBitmap("asset.goldendionysia.cdNumBg");
      addChild(_timeUnitBmp);
      addChild(_numBgBmp);
      addChild(_numContainer);
   }
   
   public function updateUI(param1:uint) : void
   {
      if(_curNum != param1)
      {
         NumberViewUtils.getNumberView(param1,_numContainer,_numBmd,17,24,17,17,"0123456789.",2);
      }
   }
   
   public function dispose() : void
   {
      ObjectUtils.disposeObject(_timeUnitBmp);
      _timeUnitBmp = null;
      ObjectUtils.disposeObject(_numBgBmp);
      _numBgBmp = null;
      ObjectUtils.disposeObject(_numBmd);
      _numBmd = null;
      ObjectUtils.disposeObject(_numContainer);
      _numContainer = null;
      if(this.parent)
      {
         this.parent.removeChild(this);
      }
   }
}
