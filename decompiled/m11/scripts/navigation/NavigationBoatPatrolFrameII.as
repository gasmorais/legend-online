package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   
   public class NavigationBoatPatrolFrameII extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var patrolText:FilterFrameText;
      
      private var confirmBtn:SelectedCheckButton;
      
      private var cancelBtn:SelectedCheckButton;
      
      private var boatHbox:HBox;
      
      private var _itemList:Vector.<NavigationBoatItemII>;
      
      private var _selectBoatArr:Array = [];
      
      private var _selectedTxt:FilterFrameText;
      
      private var _pointTxt:FilterFrameText;
      
      private var _pointIcon:Image;
      
      private var _point:int;
      
      public function NavigationBoatPatrolFrameII()
      {
         super();
         initView();
         initBoatHbox();
         addEvent();
         refreshBoatHbox();
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.border2");
         back = ComponentFactory.Instance.creatBitmap("asset.NavigationBoatPreviewFrame.back2");
         patrolText = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.patrolText2");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.confirmBtn2");
         cancelBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.cancelBtn2");
         boatHbox = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.boatHbox");
         _selectedTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.selectedTxt");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationPortFrame.pointTxt2");
         _pointIcon = ComponentFactory.Instance.creatComponentByStylename("NavigationShopGoodsItem.pointIcon");
         addToContent(border);
         addToContent(back);
         addToContent(patrolText);
         addToContent(boatHbox);
         addToContent(confirmBtn);
         addToContent(cancelBtn);
         addToContent(_selectedTxt);
         addToContent(_pointTxt);
         addToContent(_pointIcon);
         _pointIcon.x = 339;
         _pointIcon.y = 183;
         patrolText.text = LanguageMgr.GetTranslation("NavigationBoatPreviewFrame.patrolText.text2");
      }
      
      private function initBoatHbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationBoatItemII = null;
         _itemList = new Vector.<NavigationBoatItemII>();
         var _loc3_:Array = [235,185,130,70,20];
         _loc2_ = 0;
         while(_loc2_ < model.boatList.length)
         {
            _loc1_ = new NavigationBoatItemII(_loc2_);
            _loc1_.data = model.boatList[_loc2_];
            boatHbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         boatHbox.x = _loc3_[model.boatList.length - 1];
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         confirmBtn.addEventListener("click",__confirmClickHandler);
         cancelBtn.addEventListener("click",__cancelClickHandler);
         MsgMan.addObserver("NAVIGATION_DATA_CHANGE",this,__updateBoatDataHandler);
         MsgMan.addObserver("NAVIGATION_BOAT_PATROL",this,__updateBoatSelectHandler);
         MsgMan.addObserver("NAVIGATION_PATROL_CLOSE",this,__updateFrameHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         confirmBtn.removeEventListener("click",__confirmClickHandler);
         cancelBtn.removeEventListener("click",__cancelClickHandler);
         MsgMan.removeObserver("NAVIGATION_DATA_CHANGE",this,__updateBoatDataHandler);
         MsgMan.removeObserver("NAVIGATION_BOAT_PATROL",this,__updateBoatSelectHandler);
         MsgMan.removeObserver("NAVIGATION_PATROL_CLOSE",this,__updateFrameHandler);
      }
      
      private function __updateFrameHandler(param1:String, param2:Object) : void
      {
         dispose();
      }
      
      private function __updateBoatSelectHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         var _loc7_:NavigationBoatInfo = null;
         var _loc6_:NavigationBoatInfo = param2 as NavigationBoatInfo;
         var _loc5_:Array = [];
         var _loc4_:Boolean = true;
         _loc3_ = 0;
         while(_loc3_ < _selectBoatArr.length)
         {
            _loc7_ = _selectBoatArr[_loc3_];
            if(_loc7_.boatId != _loc6_.boatId)
            {
               _loc5_.push(_loc7_);
            }
            else
            {
               _loc4_ = false;
            }
            _loc3_++;
         }
         if(_loc4_)
         {
            _loc5_.push(_loc6_);
         }
         _selectBoatArr = _loc5_;
         refreshBoatHbox();
      }
      
      private function __updateBoatDataHandler(param1:String, param2:Object) : void
      {
         refreshBoatHbox();
      }
      
      private function __confirmClickHandler(param1:MouseEvent) : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint < _point)
         {
            RechargeAlertMannager.show();
            return;
         }
         var _loc2_:Array = [];
         for each(var _loc3_:NavigationBoatInfo in _selectBoatArr)
         {
            _loc2_.push(_loc3_.boatId);
         }
         NavigationManager.instance.sendNavigationOperate(16,"",_loc2_.join());
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function refreshBoatHbox() : void
      {
         if(_selectBoatArr.length > 0)
         {
            confirmBtn.enable = true;
         }
         else
         {
            confirmBtn.enable = false;
         }
         _selectedTxt.text = LanguageMgr.GetTranslation("NavigationBoatPatrolFrameII.selectedTxt.text",_selectBoatArr.length);
         var _loc1_:Array = ConfigInfoManager.instance.navigationShipConsumption;
         _point = _loc1_[_selectBoatArr.length - 1] ? _loc1_[_selectBoatArr.length - 1] : 0;
         _pointTxt.text = _point.toString();
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object) : void
      {
         titleText = LanguageMgr.GetTranslation("navigation.NavigationBoatPatrolFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(patrolText);
         patrolText = null;
         ObjectUtils.disposeObject(confirmBtn);
         confirmBtn = null;
         ObjectUtils.disposeObject(cancelBtn);
         cancelBtn = null;
         ObjectUtils.disposeObject(boatHbox);
         boatHbox = null;
         if(_itemList)
         {
            for(var _loc1_:String in _itemList)
            {
               ObjectUtils.disposeObject(_itemList[_loc1_]);
               _itemList[_loc1_] = null;
            }
            _itemList = null;
         }
         super.dispose();
      }
   }
}

