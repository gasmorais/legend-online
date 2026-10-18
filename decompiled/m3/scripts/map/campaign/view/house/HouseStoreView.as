package map.campaign.view.house
{
   import com.greensock.TweenMax;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.children.FurnitureDecMsg;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import home.HomeSender;
   import manager.LanguageMgr;
   import managers.HomeManager;
   import map.campaign.CampaignManager;
   import mvc.module.home.FurnitureInfo;
   import mvc.module.home.HomeModel;
   import yishi.manager.CursorManagerII;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.WorldBossHelper;
   
   public class HouseStoreView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _hideBtn:IconButton;
      
      private var _allInBtn:IconButton;
      
      private var _saveBtn:IconButton;
      
      private var _buyBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _leaveBtn:IconButton;
      
      private var _bagView:FurnitureBagView;
      
      private var _showState:Boolean = false;
      
      public function HouseStoreView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.house.storeBg");
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.hideBtn");
         _allInBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.allInBtn");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.saveBtn");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.buyBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.cancelBtn");
         _leaveBtn = ComponentFactory.Instance.creatComponentByStylename("HouseStoreView.leaveBtn");
         _bagView = new FurnitureBagView();
         addChild(_bg);
         addChild(_hideBtn);
         addChild(_allInBtn);
         addChild(_saveBtn);
         addChild(_buyBtn);
         addChild(_cancelBtn);
         addChild(_leaveBtn);
         addChild(_bagView);
         _bagView.x = 8;
         _bagView.y = 35;
         _cancelBtn.visible = false;
         showState = true;
      }
      
      private function initEvent() : void
      {
         if(_hideBtn)
         {
            _hideBtn.addEventListener("click",__hideHandler);
         }
         if(_allInBtn)
         {
            _allInBtn.addEventListener("click",__allInHandler);
         }
         if(_saveBtn)
         {
            _saveBtn.addEventListener("click",__saveHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.addEventListener("click",__buyBtnHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.addEventListener("click",__cancelBtnHandler);
         }
         if(_leaveBtn)
         {
            _leaveBtn.addEventListener("click",__leaveHandler);
         }
         this.addEventListener("rollOver",__rollOverHandler);
         this.addEventListener("rollOut",__rollOutHandler);
      }
      
      private function removeEvent() : void
      {
         if(_hideBtn)
         {
            _hideBtn.removeEventListener("click",__hideHandler);
         }
         if(_allInBtn)
         {
            _allInBtn.removeEventListener("click",__allInHandler);
         }
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnHandler);
         }
         if(_cancelBtn)
         {
            _cancelBtn.removeEventListener("click",__cancelBtnHandler);
         }
         if(_leaveBtn)
         {
            _leaveBtn.removeEventListener("click",__leaveHandler);
         }
         this.removeEventListener("rollOver",__rollOverHandler);
         this.removeEventListener("rollOut",__rollOutHandler);
      }
      
      private function __rollOverHandler(param1:MouseEvent) : void
      {
         if(HomeManager.instance.model.selectFurn)
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function __rollOutHandler(param1:MouseEvent) : void
      {
         if(HomeManager.instance.model.selectFurn)
         {
            CursorManagerII.instance.showFurniture(HomeManager.instance.model.selectFurn);
         }
      }
      
      private function __hideHandler(param1:MouseEvent) : void
      {
         showState = !showState;
      }
      
      private function setButState(param1:Boolean) : void
      {
         if(_bagView)
         {
            _bagView.setBuyVisible(param1);
         }
         if(_buyBtn)
         {
            _buyBtn.visible = !param1;
         }
         if(_cancelBtn)
         {
            _cancelBtn.visible = param1;
         }
         model.inBuy = param1;
      }
      
      private function __buyBtnHandler(param1:MouseEvent) : void
      {
         setButState(true);
      }
      
      private function __cancelBtnHandler(param1:MouseEvent) : void
      {
         setButState(false);
      }
      
      public function set showState(param1:Boolean) : void
      {
         if(_showState == param1)
         {
            return;
         }
         _showState = param1;
         if(_showState)
         {
            _height = _bg.height;
            doShow();
         }
         else
         {
            _height = _hideBtn.height + 2;
            doHide();
         }
      }
      
      public function get showState() : Boolean
      {
         return _showState;
      }
      
      private function doShow() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"y":StageReferance.stageHeight - height});
      }
      
      private function doHide() : void
      {
         TweenMax.killTweensOf(this);
         TweenMax.to(this,0.5,{"y":StageReferance.stageHeight - height});
      }
      
      override public function get height() : Number
      {
         return _height;
      }
      
      private function __allInHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         if(furnitureLayer)
         {
            _loc2_ = 0;
            while(_loc2_ < model.fixUpList.length)
            {
               if(!isSpecialType(model.fixUpList[_loc2_].templateInfo.Type))
               {
                  furnitureLayer.removeFurniture(model.fixUpList[_loc2_]);
                  _loc2_ -= 1;
               }
               _loc2_++;
            }
         }
         model.selectFurn = null;
         model.clickFurn = null;
         MsgMan.notifyObserver("ChildEvent.ADD_OR_REMOVE");
      }
      
      private function __saveHandler(param1:MouseEvent) : void
      {
         var _loc3_:FurnitureDecMsg = null;
         var _loc5_:FurnitureInfo = null;
         if(_saveBtn)
         {
            _saveBtn.enable = false;
         }
         HomeManager.instance.model.inFixUp = false;
         var _loc2_:Array = [];
         var _loc6_:Boolean = false;
         var _loc4_:Boolean = false;
         if(model.fixUpList)
         {
            while(model.fixUpList.length > 0)
            {
               _loc5_ = model.fixUpList.pop();
               if(inHouse)
               {
                  if(_loc5_.templateInfo.Type == 1)
                  {
                     if(_loc6_)
                     {
                        continue;
                     }
                     _loc6_ = true;
                  }
                  else if(_loc5_.templateInfo.Type == 2)
                  {
                     if(_loc4_)
                     {
                        continue;
                     }
                     _loc4_ = true;
                  }
               }
               _loc3_ = new FurnitureDecMsg();
               _loc3_.id = _loc5_.furnitureId;
               _loc3_.posX = _loc5_.posX;
               _loc3_.posY = _loc5_.posY;
               _loc3_.rotation = _loc5_.rotation;
               _loc2_.push(_loc3_);
            }
         }
         if(inHouse)
         {
            HomeSender.setFurnitureHouse(_loc2_);
         }
         else if(inHome)
         {
            HomeSender.setFurnitureHome(_loc2_);
         }
         setButState(false);
      }
      
      private function __leaveHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc5_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         HomeManager.instance.model.selectFurn = null;
         if(model.isChange)
         {
            SimpleAlertHelper.instance.data = [leaveCall];
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("view.house.HouseStoreView.leave.noSave");
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
         }
         else
         {
            leaveCall(true,true);
         }
      }
      
      private function leaveCall(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(_leaveBtn)
            {
               _leaveBtn.enable = false;
            }
            HomeManager.instance.model.inFixUp = false;
            MsgMan.notifyObserver("ChildEvent.FIX_CHANGE");
            setButState(false);
         }
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(_saveBtn)
         {
            _saveBtn.enable = param1;
         }
         if(_leaveBtn)
         {
            _leaveBtn.enable = param1;
         }
      }
      
      private function get model() : HomeModel
      {
         return HomeManager.instance.model;
      }
      
      public function get bgWidth() : Number
      {
         if(_bg)
         {
            return _bg.width;
         }
         return 0;
      }
      
      private function get furnitureLayer() : FurnitureLayer
      {
         return CampaignManager.instance.mapView.furnitureLayer;
      }
      
      private function isSpecialType(param1:int) : Boolean
      {
         return (param1 == 1 || param1 == 2) && inHouse;
      }
      
      private function get inHome() : Boolean
      {
         return WorldBossHelper.checkInHome(CampaignManager.instance.mapId);
      }
      
      private function get inHouse() : Boolean
      {
         return WorldBossHelper.checkInHouse(CampaignManager.instance.mapId);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_hideBtn);
         _hideBtn = null;
         ObjectUtils.disposeObject(_allInBtn);
         _allInBtn = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_leaveBtn);
         _leaveBtn = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         super.dispose();
      }
   }
}

