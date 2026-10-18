package farm.newview
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import farm.view.FarmAutoMediator;
   import farm.view.FarmInfoView;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.BuildingSocketOutManager;
   import managers.KingContractManager;
   import mvc.module.kingcontract.KingContractInfo;
   import water.view.FarmFriendListView;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.manager.WaterManager;
   
   public class HomeFrame extends Frame
   {
      
      private var border:ScaleBitmapImage;
      
      private var back:ScaleFrameImage;
      
      private var friendListView:FarmFriendListView;
      
      private var quickHarvestBtn:BaseButton;
      
      private var returnHomeBtn:BaseButton;
      
      private var homeShopBtn:BaseButton;
      
      private var magicMakeBtn:BaseButton;
      
      private var homeStoreBtn:BaseButton;
      
      private var _type:int;
      
      private var farmView:FarmView;
      
      private var pastureView:PastureView;
      
      private var viewContiner:Component;
      
      private var gotoFarmBtn:IconButton;
      
      private var gotoPastureBtn:IconButton;
      
      private var _farmInfoView:FarmInfoView;
      
      private var _pickMediator:FarmAutoMediator;
      
      public function HomeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.border");
         back = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.back");
         friendListView = ComponentFactory.Instance.creatCustomObject("HomeFrame.friendListView");
         quickHarvestBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.quickHarvestBtn");
         returnHomeBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.returnHomeBtn");
         homeShopBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.homeShopBtn");
         magicMakeBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.magicMakeBtn");
         homeStoreBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.homeStoreBtn");
         gotoFarmBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.gotoFarmBtn");
         gotoPastureBtn = ComponentFactory.Instance.creatComponentByStylename("HomeFrame.gotoPastureBtn");
         _farmInfoView = ComponentFactory.Instance.creatCustomObject("HomeFrame.farmInfoView");
         viewContiner = new Component();
         addToContent(border);
         addToContent(back);
         addToContent(viewContiner);
         addToContent(homeShopBtn);
         addToContent(magicMakeBtn);
         addToContent(homeStoreBtn);
         addToContent(_farmInfoView);
         addToContent(gotoFarmBtn);
         addToContent(gotoPastureBtn);
         _pickMediator = new FarmAutoMediator();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         quickHarvestBtn.addEventListener("click",__quickHarvestHandler);
         returnHomeBtn.addEventListener("click",__returnHomeHandler);
         homeShopBtn.addEventListener("click",__homeShopClickHandler);
         magicMakeBtn.addEventListener("click",__magicMakeClickHandler);
         homeStoreBtn.addEventListener("click",__homeStoreClickHandler);
         gotoFarmBtn.addEventListener("click",__gotoFarmClickHandler);
         gotoPastureBtn.addEventListener("click",__gotoPastureClickHandler);
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         quickHarvestBtn.removeEventListener("click",__quickHarvestHandler);
         returnHomeBtn.removeEventListener("click",__returnHomeHandler);
         homeShopBtn.removeEventListener("click",__homeShopClickHandler);
         magicMakeBtn.removeEventListener("click",__magicMakeClickHandler);
         homeStoreBtn.removeEventListener("click",__homeStoreClickHandler);
         gotoFarmBtn.removeEventListener("click",__gotoFarmClickHandler);
         gotoPastureBtn.removeEventListener("click",__gotoPastureClickHandler);
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         if(farmView)
         {
            farmView.data = model.curSelectedFarmInfo;
         }
         if(pastureView)
         {
            pastureView.data = model.curSelectedFarmInfo;
         }
         refreshMyHomeBtn();
      }
      
      private function refreshMyHomeBtn() : void
      {
         if(model.curSelectedFarmInfo.userId == thane.userId)
         {
            returnHomeBtn.visible = false;
            quickHarvestBtn.y = 420;
         }
         else
         {
            returnHomeBtn.visible = true;
            quickHarvestBtn.y = 400;
         }
      }
      
      private function __quickHarvestHandler(param1:MouseEvent) : void
      {
         var _loc2_:Boolean = false;
         SoundManager.instance.play("022");
         var _loc3_:FarmInfo = model.getFarmInfo(model.curSelectedFarmInfo.userId);
         if(type == 1)
         {
            if(_loc3_)
            {
               _loc2_ = false;
               _loc2_ = Boolean(WaterManager.instance.model.currentSelectedTreeInfo.canPick);
               if(_loc2_ && Boolean(_loc3_.isMine))
               {
                  BuildingSocketOutManager.pickFruits(0);
               }
               if(WaterManager.instance.isWatered(model.curSelectedFarmInfo.userId))
               {
                  BuildingSocketOutManager.water(model.curSelectedFarmInfo.userId);
               }
            }
            FarmManager.instance.sendReqAutoPick(25,model.curSelectedFarmInfo.userId);
         }
         else
         {
            FarmManager.instance.sendReqAutoPick(26,model.curSelectedFarmInfo.userId);
         }
      }
      
      private function __alertBackHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            FrameControllerManager.instance.openControllerByInfo("kingcontract");
         }
      }
      
      private function get day() : int
      {
         return (KingContractManager.Instance.model.kingContractInfos[2] as KingContractInfo).template.Duration / 1440;
      }
      
      private function get point() : int
      {
         return int(TempleteManager.instance.getConfigInfoByConfigName("All_KingContract").ConfigValue);
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function __returnHomeHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         model.curSelectedUserInfo = thane;
         FarmManager.instance.model.defaultSelectedUserInfo();
      }
      
      private function __homeShopClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FarmManager.instance.openShopFrame();
      }
      
      private function __magicMakeClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FarmManager.instance.openFarmMakeFrame();
      }
      
      private function __homeStoreClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FarmManager.instance.openBagFrame();
      }
      
      private function __gotoFarmClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         type = 1;
      }
      
      private function __gotoPastureClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         type = 2;
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
      
      public function show(param1:int = 2) : void
      {
         type = param1;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
         FarmManager.instance.model.currentHomeFrameType = param1;
         gotoFarmBtn.visible = false;
         gotoPastureBtn.visible = false;
         if(_type == 1)
         {
            if(pastureView)
            {
               ObjectUtils.disposeObject(pastureView);
            }
            pastureView = null;
            if(!farmView)
            {
               farmView = ComponentFactory.Instance.creatCustomObject("HomeFrame.farmView");
            }
            viewContiner.addChild(farmView);
            gotoPastureBtn.visible = true;
            back.setFrame(1);
            friendListView.type = 2;
            titleText = LanguageMgr.GetTranslation("tasktracetip.view.CanPickTipView.farmTip");
         }
         else
         {
            if(farmView)
            {
               ObjectUtils.disposeObject(farmView);
            }
            farmView = null;
            if(!pastureView)
            {
               pastureView = ComponentFactory.Instance.creatCustomObject("HomeFrame.pastureView");
            }
            viewContiner.addChild(pastureView);
            gotoFarmBtn.visible = true;
            back.setFrame(2);
            friendListView.type = 3;
            titleText = LanguageMgr.GetTranslation("HomeFrame.pastureView.titleText");
         }
         addToContent(friendListView);
         addToContent(quickHarvestBtn);
         addToContent(returnHomeBtn);
         model.defaultSelectedUserInfo();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FarmManager.instance.closeBagFrame();
         if(border)
         {
            ObjectUtils.disposeObject(border);
         }
         border = null;
         if(back)
         {
            ObjectUtils.disposeObject(back);
         }
         back = null;
         if(friendListView)
         {
            ObjectUtils.disposeObject(friendListView);
         }
         friendListView = null;
         if(quickHarvestBtn)
         {
            ObjectUtils.disposeObject(quickHarvestBtn);
         }
         quickHarvestBtn = null;
         if(returnHomeBtn)
         {
            ObjectUtils.disposeObject(returnHomeBtn);
         }
         returnHomeBtn = null;
         if(homeShopBtn)
         {
            ObjectUtils.disposeObject(homeShopBtn);
         }
         homeShopBtn = null;
         if(magicMakeBtn)
         {
            ObjectUtils.disposeObject(magicMakeBtn);
         }
         magicMakeBtn = null;
         if(homeStoreBtn)
         {
            ObjectUtils.disposeObject(homeStoreBtn);
         }
         homeStoreBtn = null;
         if(farmView)
         {
            ObjectUtils.disposeObject(farmView);
         }
         farmView = null;
         if(pastureView)
         {
            ObjectUtils.disposeObject(pastureView);
         }
         pastureView = null;
         if(_farmInfoView)
         {
            ObjectUtils.disposeObject(_farmInfoView);
         }
         _farmInfoView = null;
         if(gotoFarmBtn)
         {
            ObjectUtils.disposeObject(gotoFarmBtn);
         }
         gotoFarmBtn = null;
         if(gotoPastureBtn)
         {
            ObjectUtils.disposeObject(gotoPastureBtn);
         }
         gotoPastureBtn = null;
         if(viewContiner)
         {
            ObjectUtils.disposeObject(viewContiner);
         }
         viewContiner = null;
         super.dispose();
         FarmManager.instance.model.showHomeFarmValue = 0;
         FarmManager.instance.model.currentHomeFrameType = 0;
      }
   }
}

