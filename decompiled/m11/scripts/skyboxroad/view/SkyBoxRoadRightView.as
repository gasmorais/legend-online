package skyboxroad.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.GameHeroTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class SkyBoxRoadRightView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _addEffectTxt:FilterFrameText;
      
      private var _bugResetTxt:FilterFrameText;
      
      private var _buySkillImg:Bitmap;
      
      private var _pointImg:Bitmap;
      
      private var _callImg:Bitmap;
      
      private var _pointTxt:FilterFrameText;
      
      private var _buySkillItemArr:Array;
      
      private var _selectedHelperBtn:SelectedButton;
      
      private var _icon:BaseIconView;
      
      private var _buffTxtVbox:VBox;
      
      private var _buffTxtArr:Array;
      
      private var _helpBtn:BaseButton;
      
      private var _container:Component;
      
      public function SkyBoxRoadRightView()
      {
         super();
         _buySkillItemArr = [];
         _buffTxtArr = [];
         initView();
         initEvent();
         updateView();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:SkyboxRoadSkillItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.rightBg");
         _addEffectTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.rightframe.addEffectTxt");
         _bugResetTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.rightframe.bugResetTxt");
         _buySkillImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.rightBuySkillImg");
         _pointImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.rightPointImg");
         _callImg = ComponentFactory.Instance.creatBitmap("asset.skyboxroad.rightCallImg");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.rightframe.pointTxt");
         _selectedHelperBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.helperSelectedBtn");
         _icon = ComponentFactory.Instance.creatCustomObject("skyboxroad.HelperIcon");
         _buffTxtVbox = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.bufftxtVBox");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.helpBtn");
         _helpBtn.tipData = [LanguageMgr.GetTranslation("skyboxroad.helpBtnTips")];
         _container = new Component();
         addChild(_bg);
         addChild(_addEffectTxt);
         addChild(_bugResetTxt);
         addChild(_buySkillImg);
         addChild(_container);
         _container.addChild(_pointImg);
         _container.addChild(_pointTxt);
         _container.y = 289;
         addChild(_callImg);
         addChild(_selectedHelperBtn);
         addChild(_icon);
         _icon.tipData = LanguageMgr.GetTranslation("SkyBoxRoadRightView.callHelp");
         _container.tipStyle = "yishi.view.tips.OneLineTip";
         _container.isFollowMouse = false;
         _container.tipDirctions = "5";
         _container.tipData = LanguageMgr.GetTranslation("SkyBoxRoadRightView.pointsDesc");
         addChild(_buffTxtVbox);
         addChild(_helpBtn);
         var _loc3_:Array = [801080,801081,801082];
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_skill");
         _loc3_ = _loc1_.ConfigValue.split(",");
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkyboxRoadSkillItem" + _loc2_);
            _loc4_.data(_loc3_[_loc2_]);
            addChild(_loc4_);
            _buySkillItemArr.push(_loc4_);
            _loc2_++;
         }
      }
      
      public function updateView() : void
      {
         var _loc4_:int = 0;
         var _loc1_:FilterFrameText = null;
         var _loc5_:SkillTempInfo = null;
         _addEffectTxt.text = LanguageMgr.GetTranslation("skyboxroad.view.SkyBoxRoadRightView.txt1");
         _bugResetTxt.text = LanguageMgr.GetTranslation("skyboxroad.view.SkyBoxRoadRightView.txt2");
         _pointTxt.htmlText = model.skyTrialInfo.searchPoint.toString();
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_max_search_point");
         var _loc6_:int = 1000;
         if(_loc3_ != null)
         {
            _loc6_ = int(_loc3_.ConfigValue);
         }
         if(model.skyTrialInfo.searchPoint >= _loc6_)
         {
            _pointTxt.htmlText += "<font color=\'#ff0000\'>(Max)</font>";
         }
         var _loc7_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_helper_tempid");
         var _loc2_:GameHeroTempInfo = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(int(_loc7_.ConfigValue));
         _icon.icon = IconFactory.getCommonIconPath(_loc2_.Icon);
         if(_buffTxtArr != null)
         {
            _loc4_ = 0;
            while(_loc4_ < _buffTxtArr.length)
            {
               ObjectUtils.disposeObject(_buffTxtArr[_loc4_]);
               _buffTxtArr[_loc4_] = null;
               _loc4_++;
            }
         }
         _buffTxtArr = [];
         _loc4_ = 0;
         while(_loc4_ < model.skyTrialInfo.buffList.length)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.bufftxt");
            _loc5_ = TempleteManager.instance.getSkillTemplateInfoById(model.skyTrialInfo.buffList[_loc4_]);
            if(_loc5_ != null)
            {
               _loc1_.htmlText = _loc5_.Description;
               _buffTxtVbox.addChild(_loc1_);
               _buffTxtArr.push(_loc1_);
               if(_loc5_.NextTemplateId == 0)
               {
                  _loc1_.htmlText += "<font color=\'#ff0000\'>(Max)</font>";
               }
            }
            _loc4_++;
         }
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      private function onInfoUpdate(param1:Event) : void
      {
         updateView();
      }
      
      private function onHelpClick(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.helpFrame");
         _loc2_.show();
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         _selectedHelperBtn.addEventListener("click",onHelperBtnClick);
         _helpBtn.addEventListener("click",onHelpClick);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO_UPDATE",onInfoUpdate);
         _selectedHelperBtn.removeEventListener("click",onHelperBtnClick);
         _helpBtn.removeEventListener("click",onHelpClick);
      }
      
      private function onHelperBtnClick(param1:MouseEvent) : void
      {
         var _loc3_:ConfigInfosTempInfo = null;
         var _loc2_:String = null;
         var _loc4_:String = null;
         if(_selectedHelperBtn.selected)
         {
            _selectedHelperBtn.selected = false;
            _loc3_ = TempleteManager.instance.getConfigInfoByConfigName("skytrial_helper_cost");
            if(model.skyTrialInfo.searchPoint < int(_loc3_.ConfigValue))
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("skyboxroad.view.lessPoint.text",_loc3_.ConfigValue));
               return;
            }
            _loc2_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
            _loc4_ = LanguageMgr.GetTranslation("skyboxroad.view.callHelp",_loc3_.ConfigValue);
            SharedManagerHelper.ins.needAlert("skyboxroad.view.SkyBoxRoadRightView.onHelperBtnClick",callHelpBack,_loc2_,_loc4_);
         }
         else
         {
            model.callHelper = _selectedHelperBtn.selected;
         }
      }
      
      private function callHelpBack() : void
      {
         _selectedHelperBtn.selected = true;
         model.callHelper = _selectedHelperBtn.selected;
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_addEffectTxt);
         _addEffectTxt = null;
         ObjectUtils.disposeObject(_bugResetTxt);
         _bugResetTxt = null;
         ObjectUtils.disposeObject(_buySkillImg);
         _buySkillImg = null;
         ObjectUtils.disposeObject(_pointImg);
         _pointImg = null;
         ObjectUtils.disposeObject(_callImg);
         _callImg = null;
         ObjectUtils.disposeObject(_selectedHelperBtn);
         _selectedHelperBtn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_buffTxtVbox);
         _buffTxtVbox = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         _loc1_ = 0;
         while(_loc1_ < _buySkillItemArr.length)
         {
            ObjectUtils.disposeObject(_buySkillItemArr[_loc1_]);
            _buySkillItemArr[_loc1_] = null;
            _loc1_++;
         }
         _buySkillItemArr = null;
         _loc1_ = 0;
         while(_loc1_ < _buffTxtArr.length)
         {
            ObjectUtils.disposeObject(_buffTxtArr[_loc1_]);
            _buffTxtArr[_loc1_] = null;
            _loc1_++;
         }
         _buffTxtArr = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

