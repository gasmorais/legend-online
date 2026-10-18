package farm.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import farm.FarmManager;
   import farm.FarmModel;
   import farm.data.FarmInfo;
   import farm.event.FarmEvent;
   import farm.net.FarmSocketSendManager;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.PlayerEvent;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tips.WaterTreeTipInfo;
   
   public class FarmBuildLayer extends Sprite implements Disposeable
   {
      
      private var _shopBtn:BaseButton;
      
      private var _makeBtn:BaseButton;
      
      private var _processingBtn:BaseButton;
      
      private var _shopNameBg:ScaleBitmapImage;
      
      private var _shopNameTxt:FilterFrameText;
      
      private var _landUpBtn:BaseButton;
      
      private var _landUpNameBg:MutipleImage;
      
      private var _landUpNameTxt:FilterFrameText;
      
      private var _landUpLevelTxt:FilterFrameText;
      
      private var _bagBtn:BaseButton;
      
      private var _bagNameBg:ScaleBitmapImage;
      
      private var _bagNameTxt:FilterFrameText;
      
      private var _makeNameBg:ScaleBitmapImage;
      
      private var _makeNameTxt:FilterFrameText;
      
      private var _buildingFilter:SimpleBuildingFilter;
      
      private var _shopTip:WaterTreeTipInfo;
      
      private var _bagTip:WaterTreeTipInfo;
      
      private var _curSelectedFarm:FarmInfo;
      
      private var _animalTipsImg0:CustomBitmap;
      
      private var _animalContent0:Component;
      
      private var _animalTipsImg1:CustomBitmap;
      
      private var _animalContent1:Component;
      
      private var _tipsImgBg0:ScaleBitmapImage;
      
      private var _tipsImgBg1:ScaleBitmapImage;
      
      private var _animalNameTxt0:FilterFrameText;
      
      private var _animalNameTxt1:FilterFrameText;
      
      public function FarmBuildLayer()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         mouseEnabled = false;
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBuildLayerShopBtn");
         _shopNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameBg2");
         _shopNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameTxt2");
         _makeBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBuildLayerMakeBtn");
         _makeBtn.tipData = LanguageMgr.GetTranslation("farm.FarmMakeFrame.title");
         _landUpBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBuildLayerLandUpBtn");
         _landUpNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameBg1");
         _landUpNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameTxt1");
         _landUpLevelTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildLevelTxt");
         _bagBtn = ComponentFactory.Instance.creatComponentByStylename("farm.FarmBuildLayerBagBtn");
         _bagNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameBg3");
         _bagNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameTxt3");
         _buildingFilter = new SimpleBuildingFilter();
         _shopTip = new WaterTreeTipInfo();
         _bagTip = new WaterTreeTipInfo();
         _bagTip.title = LanguageMgr.GetTranslation("farm.FarmBagFrame.title");
         _bagTip.content = LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.FarmBagHelp");
         _shopBtn.tipData = LanguageMgr.GetTranslation("farm.FarmShopFrame.title");
         _bagBtn.tipData = _bagTip;
         _shopNameTxt.text = LanguageMgr.GetTranslation("farm.FarmShopFrame.title");
         _landUpNameTxt.text = LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.landUp");
         _bagNameTxt.text = LanguageMgr.GetTranslation("farm.FarmBagFrame.title");
         _shopNameBg.mouseEnabled = _shopNameBg.mouseChildren = false;
         _landUpNameBg.mouseEnabled = _landUpNameBg.mouseChildren = false;
         _bagNameBg.mouseEnabled = _bagNameBg.mouseChildren = false;
         _animalTipsImg0 = ComponentFactory.Instance.creatCustomObject("farm.FarmBuildLayer.AnimalTipsImg0");
         _animalContent0 = ComponentFactory.Instance.creatComponentByStylename("farm.mount.animalTipsImgContent0");
         _animalTipsImg1 = ComponentFactory.Instance.creatCustomObject("farm.FarmBuildLayer.AnimalTipsImg1");
         _animalContent1 = ComponentFactory.Instance.creatComponentByStylename("farm.mount.animalTipsImgContent1");
         _tipsImgBg0 = ComponentFactory.Instance.creatComponentByStylename("farm.animalTips.bg0");
         _tipsImgBg1 = ComponentFactory.Instance.creatComponentByStylename("farm.animalTips.bg1");
         _animalNameTxt0 = ComponentFactory.Instance.creatComponentByStylename("farm.animalAreaNameTxt0");
         _animalNameTxt1 = ComponentFactory.Instance.creatComponentByStylename("farm.animalAreaNameTxt1");
         _animalNameTxt0.text = LanguageMgr.GetTranslation("farm.anima.animalName");
         _animalNameTxt1.text = LanguageMgr.GetTranslation("farm.anima.animalName");
         _makeNameBg = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameBg4");
         _makeNameTxt = ComponentFactory.Instance.creatComponentByStylename("farm.BuildNameTxt4");
         _makeNameTxt.text = LanguageMgr.GetTranslation("farm.FarmMakeFrame.title");
         addChild(_shopBtn);
         addChild(_landUpBtn);
         addChild(_bagBtn);
         addChild(_shopNameBg);
         addChild(_shopNameTxt);
         addChild(_landUpNameBg);
         addChild(_landUpNameTxt);
         addChild(_landUpLevelTxt);
         addChild(_bagNameBg);
         addChild(_bagNameTxt);
         addChild(_makeBtn);
         addChild(_animalContent0);
         _animalContent0.addChild(_animalTipsImg0);
         addChild(_animalContent1);
         _animalContent1.addChild(_animalTipsImg1);
         addChild(_tipsImgBg0);
         addChild(_tipsImgBg1);
         addChild(_animalNameTxt0);
         addChild(_animalNameTxt1);
         addChild(_makeNameBg);
         addChild(_makeNameTxt);
      }
      
      private function addEvent() : void
      {
         _shopBtn.addEventListener("click",__onShopClick);
         _shopBtn.addEventListener("rollOver",__onBuildingOver);
         _shopBtn.addEventListener("rollOut",__onBuildingOut);
         _landUpBtn.addEventListener("click",__onLandUpClick);
         _landUpBtn.addEventListener("rollOver",__onBuildingOver);
         _landUpBtn.addEventListener("rollOut",__onBuildingOut);
         _bagBtn.addEventListener("click",__onBagClick);
         _bagBtn.addEventListener("rollOver",__onBuildingOver);
         _bagBtn.addEventListener("rollOut",__onBuildingOut);
         model.addEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         _makeBtn.addEventListener("click",onMakeClick);
         _makeBtn.addEventListener("rollOver",__onBuildingOver);
         _makeBtn.addEventListener("rollOut",__onBuildingOut);
         PlayerManager.instance.currentPlayerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         _shopBtn.removeEventListener("click",__onShopClick);
         _shopBtn.removeEventListener("rollOver",__onBuildingOver);
         _shopBtn.removeEventListener("rollOut",__onBuildingOut);
         _landUpBtn.removeEventListener("click",__onLandUpClick);
         _landUpBtn.removeEventListener("rollOver",__onBuildingOver);
         _landUpBtn.removeEventListener("rollOut",__onBuildingOut);
         _bagBtn.removeEventListener("click",__onBagClick);
         _bagBtn.removeEventListener("rollOver",__onBuildingOver);
         _bagBtn.removeEventListener("rollOut",__onBuildingOut);
         model.removeEventListener("SELECTED_CHANGE",__selectedFarmChangeHandler);
         _makeBtn.removeEventListener("click",onMakeClick);
         _makeBtn.removeEventListener("rollOver",__onBuildingOver);
         _makeBtn.removeEventListener("rollOut",__onBuildingOut);
         PlayerManager.instance.currentPlayerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__timeUpdateHandler);
      }
      
      private function __timeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc2_:int = int(FarmManager.instance.model.curSelectedFarmInfo.animalCount);
         var _loc3_:int = int(FarmManager.instance.model.curSelectedFarmInfo.animalPosCount);
         if(_curSelectedFarm.grade >= 5)
         {
            _animalContent0.tipData = LanguageMgr.GetTranslation("farm.anima.animalContentTips",_loc2_,_loc3_);
            _animalNameTxt0.htmlText = LanguageMgr.GetTranslation("farm.anima.animalName") + "\n" + _loc2_ + "/<font color=\'#00aa00\'>" + _loc3_ + "</font>";
         }
         else
         {
            _animalContent0.tipData = LanguageMgr.GetTranslation("farm.anima.animalContentTips","-","-");
            _animalNameTxt0.htmlText = LanguageMgr.GetTranslation("farm.anima.animalName") + "\n<font color=\'#aa0000\'>-/-</font>";
         }
         _animalContent1.tipData = LanguageMgr.GetTranslation("public.unopen");
      }
      
      private function onMakeClick(param1:MouseEvent) : void
      {
         FarmManager.instance.openFarmMakeFrame();
      }
      
      private function onProcessingClick(param1:MouseEvent) : void
      {
         FarmManager.instance.openFarmProcessingFrame();
      }
      
      private function __onBuildingOver(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOverFilter(param1.currentTarget as DisplayObject);
      }
      
      private function __onBuildingOut(param1:MouseEvent) : void
      {
         _buildingFilter.setBuildingOutFilter(param1.currentTarget as DisplayObject);
      }
      
      private function __selectedFarmChangeHandler(param1:FarmEvent) : void
      {
         curSelectedFarm = param1.data as FarmInfo;
      }
      
      private function __onShopClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FarmManager.instance.openShopFrame();
      }
      
      private function __onLandUpClick(param1:MouseEvent) : void
      {
         if(_curSelectedFarm)
         {
            if(_curSelectedFarm.grade < 30)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.landUpOpenTip"));
               return;
            }
            if(_curSelectedFarm.landGrade >= 10)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("farm.view.FarmBuildLayer.maxLandLevelTip"));
               return;
            }
            FarmSocketSendManager.sendLandUp(_curSelectedFarm.landGrade);
         }
      }
      
      private function __onBagClick(param1:MouseEvent) : void
      {
         FarmManager.instance.openBagFrame();
      }
      
      private function addFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.addEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
         }
      }
      
      private function removeFarmListener(param1:FarmInfo) : void
      {
         if(param1)
         {
            param1.removeEventListener("LAND_GRADE_CHANGE",__farmInfoUpdateHandler);
         }
      }
      
      private function __farmInfoUpdateHandler(param1:FarmEvent) : void
      {
         refreshView();
      }
      
      public function set curSelectedFarm(param1:FarmInfo) : void
      {
         if(_curSelectedFarm == param1)
         {
            return;
         }
         removeFarmListener(_curSelectedFarm);
         _curSelectedFarm = param1;
         addFarmListener(_curSelectedFarm);
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_curSelectedFarm)
         {
            if(_curSelectedFarm.userId == thane.userId)
            {
               _shopBtn.mouseEnabled = _shopBtn.mouseChildren = true;
               _landUpBtn.mouseEnabled = _landUpBtn.mouseChildren = true;
               _makeBtn.mouseChildren = _makeBtn.mouseEnabled = true;
               _bagBtn.mouseEnabled = _bagBtn.mouseChildren = true;
               _animalContent0.mouseEnabled = _animalContent0.mouseChildren = true;
               _animalContent1.mouseEnabled = _animalContent1.mouseChildren = true;
            }
            else
            {
               _shopBtn.mouseEnabled = _shopBtn.mouseChildren = false;
               _landUpBtn.mouseEnabled = _landUpBtn.mouseChildren = false;
               _makeBtn.mouseChildren = _makeBtn.mouseEnabled = false;
               _bagBtn.mouseEnabled = _bagBtn.mouseChildren = false;
               _animalContent0.mouseEnabled = _animalContent0.mouseChildren = false;
               _animalContent1.mouseEnabled = _animalContent1.mouseChildren = false;
            }
            _landUpLevelTxt.text = _curSelectedFarm.landGrade.toString();
            _landUpBtn.tipData = _curSelectedFarm;
         }
      }
      
      private function get model() : FarmModel
      {
         return FarmManager.instance.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function dispose() : void
      {
         removeFarmListener(_curSelectedFarm);
         removeEvent();
         if(_shopBtn)
         {
            _shopBtn.dispose();
         }
         _shopBtn = null;
         if(_landUpBtn)
         {
            _landUpBtn.dispose();
         }
         _landUpBtn = null;
         if(_bagBtn)
         {
            _bagBtn.dispose();
         }
         _bagBtn = null;
         if(_shopNameBg)
         {
            _shopNameBg.dispose();
         }
         _shopNameBg = null;
         if(_shopNameTxt)
         {
            _shopNameTxt.dispose();
         }
         _shopNameTxt = null;
         if(_bagNameBg)
         {
            _bagNameBg.dispose();
         }
         _bagNameBg = null;
         if(_bagNameTxt)
         {
            _bagNameTxt.dispose();
         }
         _bagNameTxt = null;
         if(_landUpNameBg)
         {
            _landUpNameBg.dispose();
         }
         _landUpNameBg = null;
         if(_landUpNameTxt)
         {
            _landUpNameTxt.dispose();
         }
         _landUpNameTxt = null;
         if(_landUpLevelTxt)
         {
            _landUpLevelTxt.dispose();
         }
         _landUpLevelTxt = null;
         _buildingFilter = null;
         _shopTip = null;
         _bagTip = null;
         _curSelectedFarm = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

