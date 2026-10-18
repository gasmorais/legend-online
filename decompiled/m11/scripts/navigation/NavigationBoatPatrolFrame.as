package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import mvc.module.navigation.NavigationPortInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   
   public class NavigationBoatPatrolFrame extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:Bitmap;
      
      private var patrolText:FilterFrameText;
      
      private var confirmBtn:SelectedCheckButton;
      
      private var cancelBtn:SelectedCheckButton;
      
      private var boatHbox:HBox;
      
      private var _itemList:Vector.<NavigationBoatItem>;
      
      private var _selectBoatInfo:NavigationBoatInfo;
      
      private var patrolData:Object;
      
      public function NavigationBoatPatrolFrame()
      {
         super();
         initView();
         initBoatHbox();
         addEvent();
         refreshBoatHbox();
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.border");
         back = ComponentFactory.Instance.creatBitmap("asset.NavigationBoatPreviewFrame.back");
         patrolText = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.patrolText");
         confirmBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.confirmBtn");
         cancelBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.cancelBtn");
         boatHbox = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatPatrolFrame.boatHbox");
         addToContent(border);
         addToContent(back);
         addToContent(patrolText);
         addToContent(boatHbox);
         addToContent(confirmBtn);
         addToContent(cancelBtn);
         patrolText.text = LanguageMgr.GetTranslation("NavigationBoatPreviewFrame.patrolText.text");
      }
      
      private function initBoatHbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationBoatItem = null;
         _itemList = new Vector.<NavigationBoatItem>();
         var _loc3_:Array = [235,185,130,70,20];
         _loc2_ = 0;
         while(_loc2_ < model.boatList.length)
         {
            _loc1_ = new NavigationBoatItem(_loc2_);
            _loc1_.type = 2;
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
         _selectBoatInfo = param2 as NavigationBoatInfo;
         refreshBoatHbox();
      }
      
      private function __updateBoatDataHandler(param1:String, param2:Object) : void
      {
         refreshBoatHbox();
      }
      
      private function __confirmClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:NavigationPortInfo = null;
         var _loc3_:Array = null;
         var _loc5_:Array = null;
         if(!patrolData || !_selectBoatInfo)
         {
            return;
         }
         var _loc2_:int = int(patrolData.type);
         if(_loc2_ == 11)
         {
            _loc4_ = patrolData.data;
            _loc3_ = patrolData.taskList;
            _loc5_ = patrolData.numList;
            if(_loc4_ && _loc3_ && _loc3_.length > 0)
            {
               NavigationManager.instance.sendNavigationOperate(11,_loc4_.portId,_selectBoatInfo.boatId,0,0,_loc3_,_loc5_);
            }
         }
         else if(_loc2_ == 16)
         {
            NavigationManager.instance.sendNavigationOperate(16,"",_selectBoatInfo.boatId);
         }
      }
      
      private function __cancelClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function refreshBoatHbox() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].data = model.boatList[_loc1_] ? model.boatList[_loc1_] : null;
            if(_itemList[_loc1_].data && _selectBoatInfo && _itemList[_loc1_].data.boatId == _selectBoatInfo.boatId)
            {
               _selectBoatInfo = _itemList[_loc1_].data;
               _itemList[_loc1_].selected = true;
            }
            else
            {
               _itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
         if(!_selectBoatInfo || _selectBoatInfo.state != 0)
         {
            confirmBtn.enable = false;
         }
         else
         {
            confirmBtn.enable = true;
         }
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
         patrolData = param1;
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

