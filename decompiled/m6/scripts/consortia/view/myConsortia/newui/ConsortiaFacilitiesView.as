package consortia.view.myConsortia.newui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaInfo;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class ConsortiaFacilitiesView extends Component
   {
      
      private var _facilitiesBg:Image;
      
      private var _mineBtn:SimpleButton;
      
      private var _loggingCampBtn:SimpleButton;
      
      private var _masterChurchBtn:SimpleButton;
      
      private var _assassinCampBtn:SimpleButton;
      
      private var _hunterCampBtn:SimpleButton;
      
      private var _warriorCampBtn:SimpleButton;
      
      private var _mineText:GradientText;
      
      private var _loggingCampText:GradientText;
      
      private var _masterChurchText:GradientText;
      
      private var _assassinCampText:GradientText;
      
      private var _hunterCampText:GradientText;
      
      private var _warriorCampText:GradientText;
      
      private var _infoTipMc:MovieClip;
      
      public function ConsortiaFacilitiesView()
      {
         super();
         initView();
         showRedNumTip(model.taskCanRewardCount);
         addEvent();
      }
      
      private function initView() : void
      {
         _facilitiesBg = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.facilitiesBg");
         _mineBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.mineBtn");
         _loggingCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.loggingCampBtn");
         _masterChurchBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.masterChurchBtn");
         _assassinCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.assassinCampBtn");
         _hunterCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.hunterCampBtn");
         _warriorCampBtn = ComponentFactory.Instance.creatCustomObject("ConsortiaFacilitiesView.warriorCampBtn");
         _mineText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.mineText");
         _loggingCampText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.loggingCampText");
         _masterChurchText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.masterChurchText");
         _assassinCampText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.assassinCampText");
         _hunterCampText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.hunterCampText");
         _warriorCampText = ComponentFactory.Instance.creatComponentByStylename("ConsortiaFacilitiesView.warriorCampText");
         addChild(_facilitiesBg);
         addChild(_mineBtn);
         addChild(_loggingCampBtn);
         addChild(_masterChurchBtn);
         addChild(_assassinCampBtn);
         addChild(_hunterCampBtn);
         addChild(_warriorCampBtn);
         addChild(_mineText);
         addChild(_loggingCampText);
         addChild(_masterChurchText);
         addChild(_assassinCampText);
         addChild(_hunterCampText);
         addChild(_warriorCampText);
         _mineText.text = "";
         _loggingCampText.text = "";
         _hunterCampText.text = "";
         _assassinCampText.text = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.assassinCampText.text");
         _warriorCampText.text = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.warriorCampText.text");
         __onConsortiaInfoUpdateHandler(null);
      }
      
      private function addEvent() : void
      {
         _mineBtn.addEventListener("click",__mineBtnClickHandler);
         _loggingCampBtn.addEventListener("click",__loggingCampBtnClickHandler);
         _masterChurchBtn.addEventListener("click",___masterChurchBtnClickHandler);
         _assassinCampBtn.addEventListener("click",__assassinCampBtnClickHandler);
         _hunterCampBtn.addEventListener("click",__hunterCampBtnClickHandler);
         _warriorCampBtn.addEventListener("click",__warriorCampBtnClickHandler);
         model.addEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_mineBtn)
         {
            _mineBtn.removeEventListener("click",__mineBtnClickHandler);
         }
         if(_loggingCampBtn)
         {
            _loggingCampBtn.removeEventListener("click",__loggingCampBtnClickHandler);
         }
         if(_masterChurchBtn)
         {
            _masterChurchBtn.removeEventListener("click",___masterChurchBtnClickHandler);
         }
         if(_assassinCampBtn)
         {
            _assassinCampBtn.removeEventListener("click",__assassinCampBtnClickHandler);
         }
         if(_hunterCampBtn)
         {
            _hunterCampBtn.removeEventListener("click",__hunterCampBtnClickHandler);
         }
         if(_warriorCampBtn)
         {
            _warriorCampBtn.removeEventListener("click",__warriorCampBtnClickHandler);
         }
         model.removeEventListener("UPDA_CONSORTIA_INFO",__onConsortiaInfoUpdateHandler);
      }
      
      private function __onConsortiaInfoUpdateHandler(param1:ConsortiaEvent) : void
      {
         var _loc3_:int = int(consortiaInfo.buildBtnLevelAry[5]);
         var _loc2_:String = _loc3_ > 0 ? LanguageMgr.GetTranslation("public.level2",_loc3_) : "";
         _masterChurchText.text = LanguageMgr.GetTranslation("ConsortiaFacilitiesView.masterChurchText.text",_loc2_);
         showRedNumTip(model.taskCanRewardCount);
      }
      
      private function __mineBtnClickHandler(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.unopen"));
      }
      
      private function __loggingCampBtnClickHandler(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.unopen"));
      }
      
      private function __hunterCampBtnClickHandler(param1:MouseEvent) : void
      {
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("public.unopen"));
      }
      
      private function ___masterChurchBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showMasterSkillFrame(4);
      }
      
      private function __assassinCampBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showBusinessFrame(5);
      }
      
      private function __warriorCampBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.consortiaController.showTaskSchoolFrame(6);
      }
      
      private function showRedNumTip(param1:int) : void
      {
         if(param1 > 0 && _infoTipMc == null)
         {
            _infoTipMc = ComponentFactory.Instance.creatCustomObject("core.InfoTipsMc");
            addChild(_infoTipMc);
            _infoTipMc.mouseChildren = false;
            _infoTipMc.mouseEnabled = false;
            _infoTipMc.x = 885;
            _infoTipMc.y = 150;
         }
         if(_infoTipMc != null)
         {
            _infoTipMc.txt.text = param1 + "";
         }
      }
      
      private function get consortiaInfo() : ConsortiaInfo
      {
         return model.consortiaInfo;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_facilitiesBg);
         _facilitiesBg = null;
         ObjectUtils.disposeObject(_mineBtn);
         _mineBtn = null;
         ObjectUtils.disposeObject(_loggingCampBtn);
         _loggingCampBtn = null;
         ObjectUtils.disposeObject(_masterChurchBtn);
         _masterChurchBtn = null;
         ObjectUtils.disposeObject(_assassinCampBtn);
         _assassinCampBtn = null;
         ObjectUtils.disposeObject(_hunterCampBtn);
         _hunterCampBtn = null;
         ObjectUtils.disposeObject(_warriorCampBtn);
         _warriorCampBtn = null;
         ObjectUtils.disposeObject(_mineText);
         _mineText = null;
         ObjectUtils.disposeObject(_loggingCampText);
         _loggingCampText = null;
         ObjectUtils.disposeObject(_masterChurchText);
         _masterChurchText = null;
         ObjectUtils.disposeObject(_assassinCampText);
         _assassinCampText = null;
         ObjectUtils.disposeObject(_hunterCampText);
         _hunterCampText = null;
         ObjectUtils.disposeObject(_warriorCampText);
         _warriorCampText = null;
         ObjectUtils.disposeObject(_infoTipMc);
         _infoTipMc = null;
         super.dispose();
      }
   }
}

