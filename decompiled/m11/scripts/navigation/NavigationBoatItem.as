package navigation
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationBoatInfo;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   
   public class NavigationBoatItem extends Component implements ISelectable
   {
      
      private var border:Bitmap;
      
      private var boatImage:ScaleFrameImage;
      
      private var stateImage:ScaleFrameImage;
      
      private var activeBtn:IconButton;
      
      private var _selected:Boolean;
      
      private var _boatInfo:NavigationBoatInfo;
      
      private var _activeNeedPoint:int;
      
      private var _type:int;
      
      private var _index:int;
      
      public function NavigationBoatItem(param1:int)
      {
         super();
         _index = param1;
         _activeNeedPoint = ConfigInfoManager.instance.getNavigationBoaActivatePoint();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatBitmap("asset.NavigationBoatItem.borderLight");
         boatImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.boatImage");
         stateImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatItem.stateImage");
         activeBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatItem.activeBtn");
         addChild(boatImage);
         addChild(border);
         border.visible = false;
         addChild(stateImage);
         addChild(activeBtn);
         boatImage.setFrame(1);
         boatImage.x = boatImage.y = 0;
         stateImage.setFrame(1);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__itemClickHandler);
         addEventListener("mouseOver",__itemOverHandler);
         addEventListener("mouseOut",__itemOutHandler);
         activeBtn.addEventListener("click",__activeBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__itemClickHandler);
         removeEventListener("mouseOver",__itemOverHandler);
         removeEventListener("mouseOut",__itemOutHandler);
         if(activeBtn)
         {
            activeBtn.removeEventListener("click",__activeBtnClickHandler);
         }
      }
      
      private function __itemOverHandler(param1:MouseEvent) : void
      {
         if(!data || selected)
         {
            return;
         }
         border.visible = true;
      }
      
      private function __itemOutHandler(param1:MouseEvent) : void
      {
         if(!data || selected)
         {
            return;
         }
         border.visible = false;
      }
      
      protected function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!_boatInfo)
         {
            return;
         }
         if(_type == 1)
         {
            model.selectedBoatInfo = data;
         }
         else
         {
            MsgMan.notifyObserver("NAVIGATION_BOAT_PATROL",_boatInfo);
         }
      }
      
      private function __activeBtnClickHandler(param1:MouseEvent) : void
      {
         SimpleAlertHelper.instance.data = [activeResultHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("navigation.NavigationBoatItem.activeContent",_activeNeedPoint);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert");
      }
      
      private function activeResultHandler(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1)
         {
            if(param2)
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            }
            else
            {
               _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
            }
            if(_loc3_ >= _activeNeedPoint)
            {
               _loc4_ = param2 ? 0 : 1;
               NavigationManager.instance.sendNavigationOperate(0,"","",_loc4_);
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      public function set data(param1:NavigationBoatInfo) : void
      {
         _boatInfo = param1;
         if(_boatInfo)
         {
            this.buttonMode = true;
            boatImage.setFrame(_boatInfo.grade);
            stateImage.setFrame(_boatInfo.state + 1);
            activeBtn.visible = false;
            activeBtn.enable = false;
         }
         else
         {
            this.buttonMode = false;
            boatImage.setFrame(1);
            stateImage.setFrame(1);
            activeBtn.visible = true;
            activeBtn.enable = true;
         }
         if(_type == 2)
         {
            activeBtn.visible = activeBtn.enable = false;
         }
         if(_index > model.boatList.length)
         {
            stateImage.setFrame(6);
            activeBtn.visible = activeBtn.enable = false;
         }
      }
      
      public function get data() : NavigationBoatInfo
      {
         return _boatInfo;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selected = param1;
         border.visible = _selected;
      }
      
      public function set autoSelect(param1:Boolean) : void
      {
      }
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(boatImage);
         boatImage = null;
         ObjectUtils.disposeObject(stateImage);
         stateImage = null;
         ObjectUtils.disposeObject(activeBtn);
         activeBtn = null;
         super.dispose();
      }
   }
}

