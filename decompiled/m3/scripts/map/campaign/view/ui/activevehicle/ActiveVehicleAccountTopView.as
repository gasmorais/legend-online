package map.campaign.view.ui.activevehicle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import map.campaign.data.ActiveVehicleAccountInfo;
   
   public class ActiveVehicleAccountTopView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _title:MutipleImage;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _vBox:VBox;
      
      private var _bg:ScaleBitmapImage;
      
      private var _failedFlg:Bitmap;
      
      private var _victoryFlg:Bitmap;
      
      private var _itemList:Array = [];
      
      private var _data:ActiveVehicleAccountInfo;
      
      public function ActiveVehicleAccountTopView(param1:ActiveVehicleAccountInfo)
      {
         _data = param1;
         super();
         refreshView();
      }
      
      override protected function init() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveVehicleAccountItemView = null;
         _back = ComponentFactory.Instance.creat("asset.vehiclemap.AccountTopBack");
         _bg = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListBg");
         _title = ComponentFactory.Instance.creatComponentByStylename("vehicle.SortListTitle");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("vehicle.sortlist.ScrollPanel");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("pvpmap.sortlist.Vbox");
         _failedFlg = ComponentFactory.Instance.creatBitmap("asset.core.FailedBitmapAsset");
         _victoryFlg = ComponentFactory.Instance.creatBitmap("asset.core.VictoryBitmapAsset");
         addChild(_bg);
         addChild(_back);
         addChild(_title);
         addChild(_scrollPanel);
         addChild(_failedFlg);
         addChild(_victoryFlg);
         _scrollPanel.setView(_vBox);
         _vBox.spacing = 4;
         _scrollPanel.x = -3;
         _scrollPanel.y = 36;
         _back.x = 2;
         _back.y = 2;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new ActiveVehicleAccountItemView(_loc2_ + 1,_data);
            _itemList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveVehicleAccountItemView = null;
         var _loc3_:Array = _data.playerList;
         _loc3_.sortOn("activeScore",0x10 | 2);
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            _loc1_.data = _loc3_[_loc2_];
            _loc2_++;
         }
         if(_data.isWin)
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
      
      override public function dispose() : void
      {
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_back)
         {
            ObjectUtils.disposeObject(_back);
         }
         _back = null;
         if(_title)
         {
            ObjectUtils.disposeObject(_title);
         }
         _title = null;
         if(_failedFlg)
         {
            ObjectUtils.disposeObject(_failedFlg);
         }
         _failedFlg = null;
         if(_victoryFlg)
         {
            ObjectUtils.disposeObject(_victoryFlg);
         }
         _victoryFlg = null;
         if(_scrollPanel)
         {
            ObjectUtils.disposeObject(_scrollPanel);
         }
         _scrollPanel = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_victoryFlg);
         }
         _vBox = null;
         _itemList = null;
         _data = null;
         super.dispose();
      }
   }
}

