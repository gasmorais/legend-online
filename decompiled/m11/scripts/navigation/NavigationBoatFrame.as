package navigation
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.NavigationManager;
   import mvc.module.navigation.NavigationModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.templates.UpgradeTemplateInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.TimeDownView;
   import yishi.view.tips.MessageTipManager;
   
   public class NavigationBoatFrame extends Frame
   {
      
      private static const MAX_BOAT_COUNT:int = 5;
      
      private var border:ScaleBitmapImage;
      
      private var back:MutipleImage;
      
      private var boatImage:ScaleFrameImage;
      
      private var assistBtn:IconButton;
      
      private var upgradeBtn:IconButton;
      
      private var upgradeTimeImage:ScaleFrameImage;
      
      private var upgradeTime:TimeDownView;
      
      private var gradeViewText:FilterFrameText;
      
      private var pointsShow:MutipleImage;
      
      private var pointsShowTxt:FilterFrameText;
      
      private var needPointText:FilterFrameText;
      
      private var curAffectView:NavigationBoadUpgradeView;
      
      private var nextAffectView:NavigationBoadUpgradeView;
      
      private var fullAffectView:NavigationBoadUpgradeView;
      
      private var boatHbox:HBox;
      
      private var _itemList:Vector.<NavigationBoatItem>;
      
      private var curUpgradeTempInfo:UpgradeTemplateInfo;
      
      private var nextUpgradeTempInfo:UpgradeTemplateInfo;
      
      private var costTime:int;
      
      public function NavigationBoatFrame()
      {
         super();
         costTime = ConfigInfoManager.instance.getNavigationBoatUpgradeCd() / 60;
         initView();
         initBoatHbox();
         addEvent();
         model.selectedBoatInfo = _itemList[0].data;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         border = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.border");
         back = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.back");
         boatImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.boatImage");
         curAffectView = ComponentFactory.Instance.creatCustomObject("NavigationBoatFrame.curAffectView");
         nextAffectView = ComponentFactory.Instance.creatCustomObject("NavigationBoatFrame.nextAffectView");
         fullAffectView = ComponentFactory.Instance.creatCustomObject("NavigationBoatFrame.fullAffectView");
         upgradeTime = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.downUpdateTime");
         upgradeTimeImage = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.upgradeTimeImage");
         gradeViewText = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.gradeViewText");
         assistBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.assistBtn");
         upgradeBtn = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.upgradeBtn");
         pointsShow = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.displayShowPoints");
         pointsShowTxt = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.displayShowTxt");
         needPointText = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.needPointText");
         boatHbox = ComponentFactory.Instance.creatComponentByStylename("NavigationBoatFrame.boatHbox");
         addToContent(border);
         addToContent(back);
         addToContent(boatImage);
         boatImage.setFrame(1);
         addToContent(curAffectView);
         curAffectView.visible = false;
         addToContent(nextAffectView);
         nextAffectView.visible = false;
         addToContent(fullAffectView);
         fullAffectView.visible = false;
         addToContent(upgradeTimeImage);
         upgradeTimeImage.visible = false;
         addToContent(upgradeTime);
         addToContent(gradeViewText);
         addToContent(needPointText);
         addToContent(pointsShow);
         addToContent(pointsShowTxt);
         addToContent(assistBtn);
         addToContent(upgradeBtn);
         addToContent(boatHbox);
         gradeViewText.mouseEnabled = true;
         gradeViewText.htmlText = LanguageMgr.GetTranslation("NavigationBoatFrame.gradeViewText.text");
      }
      
      private function initBoatHbox() : void
      {
         var _loc2_:int = 0;
         var _loc1_:NavigationBoatItem = null;
         _itemList = new Vector.<NavigationBoatItem>();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc1_ = new NavigationBoatItem(_loc2_);
            _loc1_.type = 1;
            _loc1_.data = model.boatList[_loc2_];
            boatHbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         upgradeTime.addEventListener("timerDown_complete",__timeCompleteHandler);
         gradeViewText.addEventListener("click",__gradeViewTextClickHandler);
         upgradeBtn.addEventListener("click",__upgradeBtnClickHandler);
         assistBtn.addEventListener("click",__assistBtnClickHandler);
         MsgMan.addObserver("NAVIGATION_DATA_CHANGE",this,__updateBoatDataHandler);
         MsgMan.addObserver("NAVIGATION_BOAT_CHANGE",this,__updateBoatSelectHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         upgradeTime.removeEventListener("timerDown_complete",__timeCompleteHandler);
         gradeViewText.removeEventListener("click",__gradeViewTextClickHandler);
         upgradeBtn.removeEventListener("click",__upgradeBtnClickHandler);
         assistBtn.removeEventListener("click",__assistBtnClickHandler);
         MsgMan.removeObserver("NAVIGATION_DATA_CHANGE",this,__updateBoatDataHandler);
         MsgMan.removeObserver("NAVIGATION_BOAT_CHANGE",this,__updateBoatSelectHandler);
      }
      
      private function __gradeViewTextClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("navigation",5);
      }
      
      private function __upgradeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(!nextUpgradeTempInfo || !model.selectedBoatInfo)
         {
            return;
         }
         if(model.currency < nextUpgradeTempInfo.Data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("navigation.NavigationBoatFrame.upgrade.noCurrencyAlert"));
            return;
         }
         SimpleAlertHelper.instance.data = [upgradeResultHandler];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("navigation.NavigationBoatFrame.updateContent",nextUpgradeTempInfo.Data,costTime);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT");
      }
      
      private function upgradeResultHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            NavigationManager.instance.sendNavigationOperate(3,model.selectedBoatInfo.boatId,"");
         }
      }
      
      private function __assistBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(model.selectedBoatInfo.state != 3)
         {
            return;
         }
         FrameControllerManager.instance.openControllerByInfo("navigation",4,model.selectedBoatInfo);
      }
      
      private function __timeCompleteHandler(param1:Event) : void
      {
         upgradeTime.timeCount = 0;
         upgradeTime.visible = false;
         upgradeTimeImage.visible = false;
         assistBtn.enable = false;
         upgradeBtn.enable = true;
         if(nextUpgradeTempInfo)
         {
            needPointText.text = LanguageMgr.GetTranslation("NavigationBoatFrame.needPointText.text",nextUpgradeTempInfo.Data);
         }
      }
      
      private function __updateBoatSelectHandler(param1:String, param2:Object) : void
      {
         refreshBoatHbox();
         refreshView();
      }
      
      private function __updateBoatDataHandler(param1:String, param2:Object) : void
      {
         refreshBoatHbox();
         refreshView();
      }
      
      private function refreshView() : void
      {
         curAffectView.visible = false;
         nextAffectView.visible = false;
         fullAffectView.visible = false;
         if(!model.selectedBoatInfo)
         {
            return;
         }
         boatImage.setFrame(model.selectedBoatInfo.grade);
         curAffectView.levelType = fullAffectView.levelType = 1;
         nextAffectView.levelType = 2;
         assistBtn.enable = model.selectedBoatInfo.state == 3;
         upgradeBtn.enable = model.selectedBoatInfo.state == 0;
         pointsShowTxt.text = model.currency + "";
         needPointText.text = "";
         curUpgradeTempInfo = TempleteManager.instance.getTemplateByLevelAndType(model.selectedBoatInfo.grade,118);
         nextUpgradeTempInfo = TempleteManager.instance.getTemplateByLevelAndType(model.selectedBoatInfo.grade + 1,118);
         if(!nextUpgradeTempInfo)
         {
            fullAffectView.visible = true;
            fullAffectView.grade = model.selectedBoatInfo.grade;
            upgradeBtn.enable = false;
            assistBtn.enable = false;
         }
         else
         {
            curAffectView.visible = true;
            nextAffectView.visible = true;
            curAffectView.grade = model.selectedBoatInfo.grade;
            nextAffectView.grade = model.selectedBoatInfo.grade + 1;
         }
         if(model.selectedBoatInfo.state == 2 || model.selectedBoatInfo.state == 3)
         {
            upgradeTime.visible = true;
            upgradeTimeImage.visible = true;
            upgradeTimeImage.setFrame(model.selectedBoatInfo.state - 1);
            upgradeTime.timeCount = model.selectedBoatInfo.boatCd - PlayerManager.instance.currentPlayerModel.sysSecond;
         }
         else
         {
            upgradeTime.timeCount = 0;
            upgradeTime.visible = false;
            upgradeTimeImage.visible = false;
            if(nextUpgradeTempInfo)
            {
               needPointText.text = LanguageMgr.GetTranslation("NavigationBoatFrame.needPointText.text",nextUpgradeTempInfo.Data);
            }
         }
      }
      
      private function refreshBoatHbox() : void
      {
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _itemList[_loc1_].data = model.boatList[_loc1_] ? model.boatList[_loc1_] : null;
            if(_itemList[_loc1_].data && _itemList[_loc1_].data.boatId == model.selectedBoatInfo.boatId)
            {
               model.selectedBoatInfo = _itemList[_loc1_].data;
               _itemList[_loc1_].selected = true;
            }
            else
            {
               _itemList[_loc1_].selected = false;
            }
            _loc1_++;
         }
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
      
      private function get model() : NavigationModel
      {
         return NavigationManager.instance.model;
      }
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("navigation.NavigationBoatFrame.titleText");
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(border);
         border = null;
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(boatImage);
         boatImage = null;
         ObjectUtils.disposeObject(curAffectView);
         curAffectView = null;
         ObjectUtils.disposeObject(nextAffectView);
         nextAffectView = null;
         ObjectUtils.disposeObject(fullAffectView);
         fullAffectView = null;
         ObjectUtils.disposeObject(assistBtn);
         assistBtn = null;
         ObjectUtils.disposeObject(upgradeBtn);
         upgradeBtn = null;
         ObjectUtils.disposeObject(upgradeTime);
         upgradeTime = null;
         ObjectUtils.disposeObject(upgradeTimeImage);
         upgradeTimeImage = null;
         ObjectUtils.disposeObject(gradeViewText);
         gradeViewText = null;
         ObjectUtils.disposeObject(boatHbox);
         boatHbox = null;
         ObjectUtils.disposeObject(pointsShow);
         pointsShow = null;
         ObjectUtils.disposeObject(pointsShowTxt);
         pointsShowTxt = null;
         ObjectUtils.disposeObject(needPointText);
         needPointText = null;
         if(_itemList)
         {
            for(var _loc1_:String in _itemList)
            {
               ObjectUtils.disposeObject(_itemList[_loc1_]);
               _itemList[_loc1_] = null;
            }
            _itemList = null;
         }
         model.selectedBoatInfo = null;
         super.dispose();
      }
   }
}

