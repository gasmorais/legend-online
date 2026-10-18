package farm
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import home.HomeSender;
   import manager.LanguageMgr;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class FarmEnterNewFrame extends Frame
   {
      
      private var back:Bitmap;
      
      private var nameBack:MutipleImage;
      
      private var farmBtn:BaseButton;
      
      private var pastureBtn:BaseButton;
      
      private var boatBtn:BaseButton;
      
      private var homeBtn:BaseButton;
      
      private var farmText:GradientText;
      
      private var pastureText:GradientText;
      
      private var boatText:GradientText;
      
      private var homeText:GradientText;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      public function FarmEnterNewFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatBitmap("asset.FarmEnterNewFrame.back");
         nameBack = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.nameBack");
         farmBtn = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.farmBtn");
         pastureBtn = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.pastureBtn");
         boatBtn = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.boatBtn");
         homeBtn = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.homeBtn");
         farmText = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.farmText");
         pastureText = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.pastureText");
         boatText = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.boatText");
         homeText = ComponentFactory.Instance.creatComponentByStylename("FarmEnterNewFrame.homeText");
         _buildingFilter = new SimpleBuildingFilter();
         addToContent(back);
         addToContent(nameBack);
         addToContent(farmText);
         addToContent(pastureText);
         addToContent(boatText);
         addToContent(homeText);
         addToContent(farmBtn);
         addToContent(pastureBtn);
         addToContent(boatBtn);
         addToContent(homeBtn);
         farmText.text = LanguageMgr.GetTranslation("tasktracetip.view.CanPickTipView.farmTip");
         pastureText.text = LanguageMgr.GetTranslation("HomeFrame.pastureView.titleText");
         boatText.text = LanguageMgr.GetTranslation("navigation.NavigationFrame.titleText");
         homeText.text = LanguageMgr.GetTranslation("FarmEnterNewFrame.homeText.text");
         farmText.cacheAsBitmap = pastureText.cacheAsBitmap = boatText.cacheAsBitmap = homeText.cacheAsBitmap = true;
         farmText.mouseEnabled = pastureText.mouseEnabled = boatText.mouseEnabled = homeText.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         farmBtn.addEventListener("click",__onFarmBtnClick);
         farmBtn.addEventListener("rollOver",__onBuildingOver);
         farmBtn.addEventListener("rollOut",__onBuildingOut);
         pastureBtn.addEventListener("click",__onPastureBtnClick);
         pastureBtn.addEventListener("rollOver",__onBuildingOver);
         pastureBtn.addEventListener("rollOut",__onBuildingOut);
         boatBtn.addEventListener("click",__onBoatBtnClick);
         boatBtn.addEventListener("rollOver",__onBuildingOver);
         boatBtn.addEventListener("rollOut",__onBuildingOut);
         homeBtn.addEventListener("click",__onHomeBtnClick);
         homeBtn.addEventListener("rollOver",__onBuildingOver);
         homeBtn.addEventListener("rollOut",__onBuildingOut);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(farmBtn)
         {
            farmBtn.removeEventListener("click",__onFarmBtnClick);
            farmBtn.removeEventListener("rollOver",__onBuildingOver);
            farmBtn.removeEventListener("rollOut",__onBuildingOut);
         }
         if(pastureBtn)
         {
            pastureBtn.removeEventListener("click",__onPastureBtnClick);
            pastureBtn.removeEventListener("rollOver",__onBuildingOver);
            pastureBtn.removeEventListener("rollOut",__onBuildingOut);
         }
         if(boatBtn)
         {
            boatBtn.removeEventListener("click",__onBoatBtnClick);
            boatBtn.removeEventListener("rollOver",__onBuildingOver);
            boatBtn.removeEventListener("rollOut",__onBuildingOut);
         }
         if(homeBtn)
         {
            homeBtn.removeEventListener("click",__onHomeBtnClick);
            homeBtn.removeEventListener("rollOver",__onBuildingOver);
            homeBtn.removeEventListener("rollOut",__onBuildingOut);
         }
      }
      
      private function __onFarmBtnClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("farm","HOME_NEW_FRAME",1);
      }
      
      private function __onPastureBtnClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("farm","HOME_NEW_FRAME",2);
      }
      
      private function __onCatBtnClick(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("cathouse");
      }
      
      private function __onBoatBtnClick(param1:MouseEvent) : void
      {
         if(!VersionSwitch.NAVIGATION)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationFrame.switchNotOpen"));
            return;
         }
         if(thane.grades < 80)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("store.view.StoreFrame.command01",80));
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("navigation",1);
      }
      
      private function __onHomeBtnClick(param1:MouseEvent) : void
      {
         HomeSender.enterHouse(thane.userId);
      }
      
      private function __onBuildingOver(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(param1.currentTarget as DisplayObject);
      }
      
      private function __onBuildingOut(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(param1.currentTarget as DisplayObject);
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
      
      protected function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("castle.view.CastleBuildingView.command071");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         _buildingFilter = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(nameBack);
         nameBack = null;
         ObjectUtils.disposeObject(farmBtn);
         farmBtn = null;
         ObjectUtils.disposeObject(pastureBtn);
         pastureBtn = null;
         ObjectUtils.disposeObject(boatBtn);
         boatBtn = null;
         ObjectUtils.disposeObject(homeBtn);
         homeBtn = null;
         ObjectUtils.disposeObject(farmText);
         farmText = null;
         ObjectUtils.disposeObject(pastureText);
         pastureText = null;
         ObjectUtils.disposeObject(boatText);
         boatText = null;
         ObjectUtils.disposeObject(homeText);
         homeText = null;
         super.dispose();
      }
   }
}

