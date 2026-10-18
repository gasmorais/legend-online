package com.map.vehicle.view
{
   import com.map.vehicle.data.PlayerVehicleInfo;
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import yishi.manager.PlayerManager;
   import yishi.utils.NumberViewUtils;
   
   public class VehicleAccountBottomView extends Component
   {
      
      private static const MINRANK:int = 200;
      
      private var _back:ScaleBitmapImage;
      
      private var _bg:Scale9CornerImage;
      
      private var _award1:Bitmap;
      
      private var _award2:Bitmap;
      
      private var _icon1:Image;
      
      private var _icon2:Image;
      
      private var _numberAsset:BitmapData;
      
      private var _symbolBit1:Bitmap;
      
      private var _symbolBit2:Bitmap;
      
      private var _symbolBit3:Bitmap;
      
      private var _value1:Sprite;
      
      private var _value2:Sprite;
      
      private var _value3:Sprite;
      
      private var _templateId1:int = 2060067;
      
      private var _templateId3:int = 3020010;
      
      private var _numStr:String = "0123456789.";
      
      private var _spline:Bitmap;
      
      private var _giftBox:ScaleFrameImage;
      
      private var _vehicleInfo:VehicleAccountInfo;
      
      public function VehicleAccountBottomView(param1:VehicleAccountInfo)
      {
         _vehicleInfo = param1;
         super();
         NumberViewUtils.getNumberView(param1.reward1,_value1,_numberAsset,20,23,13,20,_numStr,1);
         NumberViewUtils.getNumberView(param1.reward2,_value2,_numberAsset,20,23,13,20,_numStr,1);
         NumberViewUtils.getNumberView(param1.reward3,_value3,_numberAsset,20,23,13,20,_numStr,1);
      }
      
      override public function dispose() : void
      {
         if(_numberAsset)
         {
            _numberAsset.dispose();
            _numberAsset = null;
         }
         super.dispose();
      }
      
      override protected function init() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListBg");
         _back.height = 81;
         _bg = ComponentFactory.Instance.creatComponentByStylename("vehicle.sortBg");
         _bg.x = 4;
         _bg.y = 5;
         _award1 = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.Image1");
         _award2 = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.Image2");
         _icon1 = ComponentFactory.Instance.creatComponentByStylename("vehicle.Image5");
         _icon2 = ComponentFactory.Instance.creatComponentByStylename("vehicle.Image4");
         _giftBox = ComponentFactory.Instance.creatComponentByStylename("vehicle.giftBoxImg");
         _giftBox.setFrame(1);
         _award1.x = 20;
         _award1.y = -6;
         _award2.x = 300;
         _award2.y = -6;
         _symbolBit1 = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         _symbolBit2 = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         _symbolBit3 = ComponentFactory.Instance.creatBitmap("asset.pvpmap.SymbolAsset");
         _symbolBit1.x = 67;
         _symbolBit1.y = 40;
         _symbolBit2.x = 213;
         _symbolBit2.y = 40;
         _symbolBit3.x = 347;
         _symbolBit3.y = 40;
         _numberAsset = ComponentFactory.Instance.creatBitmapData("worldboss.river.NumberAsset");
         _value1 = new Sprite();
         _value2 = new Sprite();
         _value3 = new Sprite();
         _value1.x = 82;
         _value1.y = 38;
         _value2.x = 227;
         _value2.y = 38;
         _value3.x = 363;
         _value3.y = 38;
         _spline = ComponentFactory.Instance.creatBitmap("asset.vehiclemap.AccountViewSpline");
         _spline.x = 280;
         _spline.y = 5;
         addChild(_back);
         addChild(_bg);
         addChild(_award1);
         addChild(_award2);
         addChild(_icon1);
         addChild(_icon2);
         addChild(_giftBox);
         addChild(_symbolBit1);
         addChild(_symbolBit2);
         addChild(_symbolBit3);
         addChild(_value1);
         addChild(_value2);
         addChild(_value3);
         addChild(_spline);
         _giftBox.setFrame(getRunking);
         if(_vehicleInfo.isWin)
         {
            _icon1.tipData = LanguageMgr.GetTranslation("vehicle.AccountBottomView.chest.success");
         }
         else
         {
            _icon1.tipData = LanguageMgr.GetTranslation("vehicle.AccountBottomView.chest.fail");
         }
         _icon2.tipData = LanguageMgr.GetTranslation("vehicle.scoreTip2");
         _giftBox.tipData = runkingTipText;
      }
      
      private function get runkingTipText() : String
      {
         var _loc1_:String = null;
         switch(getRunking - 1)
         {
            case 0:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.giftBox1");
               break;
            case 1:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.giftBox2");
               break;
            case 2:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.giftBox3");
               break;
            case 3:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.giftBox4");
               break;
            case 4:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.giftBox5");
               break;
            case 5:
            case 6:
            case 7:
               _loc1_ = LanguageMgr.GetTranslation("vehicle.AccountBottomView.rune");
         }
         return _loc1_;
      }
      
      private function get getRunking() : int
      {
         var _loc4_:PlayerVehicleInfo = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:Array = _vehicleInfo.playerList;
         _loc3_.sortOn("score",0x10 | 2);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = _loc3_[_loc2_] as PlayerVehicleInfo;
            if(playerSelfId == _loc4_.playerId)
            {
               if(_loc4_.score < 200)
               {
                  _loc1_ = 8;
                  break;
               }
               _loc1_ = _loc2_ + 1;
               break;
            }
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function get playerSelfId() : int
      {
         return PlayerManager.instance.currentPlayerModel.userInfo.userId;
      }
   }
}

