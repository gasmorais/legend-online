package com.map.vehicle.view
{
   import com.map.vehicle.data.VehicleAccountInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   
   public class VehicleAccountTopView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _title:MutipleImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _failedFlg:Bitmap;
      
      private var _victoryFlg:Bitmap;
      
      private var _itemList:Array = [];
      
      private var _data:VehicleAccountInfo;
      
      public function VehicleAccountTopView(param1:VehicleAccountInfo)
      {
         var _loc3_:int = 0;
         var _loc2_:VehicleAccountItemView = null;
         _data = param1;
         super();
         var _loc4_:Array = param1.playerList;
         _loc4_.sortOn("score",0x10 | 2);
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_];
            _loc2_.data = _loc4_[_loc3_];
            _loc3_++;
         }
         if(param1.isWin)
         {
            _victoryFlg.visible = true;
            _failedFlg.visible = false;
         }
         else
         {
            _failedFlg.visible = true;
            _victoryFlg.visible = false;
         }
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:VehicleAccountItemView = null;
         _back = ComponentFactory.Instance.creat("asset.vehiclemap.AccountTopBack");
         _back.x = 2;
         _back.y = 2;
         _bg = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListTitle");
         addChild(_bg);
         addChild(_back);
         addChild(_title);
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("vehicle.sortlist.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortlist.Vbox");
         _vBox.spacing = 4;
         addChild(_scrollPanel);
         _scrollPanel.setView(_vBox);
         _scrollPanel.x = -3;
         _scrollPanel.y = 36;
         _failedFlg = ComponentFactory.Instance.creatBitmap("asset.core.FailedBitmapAsset");
         _victoryFlg = ComponentFactory.Instance.creatBitmap("asset.core.VictoryBitmapAsset");
         addChild(_failedFlg);
         addChild(_victoryFlg);
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new VehicleAccountItemView(_loc2_ + 1,_data);
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      override public function dispose() : void
      {
         _back = null;
         _itemList = null;
         _data = null;
         super.dispose();
      }
   }
}

