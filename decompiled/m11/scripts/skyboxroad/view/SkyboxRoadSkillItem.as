package skyboxroad.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SkyboxRoadManager;
   import mvc.module.skyboxroad.SkyboxRoadModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class SkyboxRoadSkillItem extends Component
   {
      
      private var _icon:BaseIconView;
      
      private var _bugBtn:BaseButton;
      
      private var _tempId:int;
      
      private var _txt:FilterFrameText;
      
      public function SkyboxRoadSkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("skyboxroad.SkillItemIcon");
         _icon.scaleX = _icon.scaleY = 0.6;
         _bugBtn = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.BuySkillBtn");
         _txt = ComponentFactory.Instance.creatComponentByStylename("skyboxroad.skillCountTxt");
         addChild(_icon);
         addChild(_bugBtn);
         addChild(_txt);
      }
      
      private function initEvent() : void
      {
         NotificationManager.instance.addEventListener("SKYBOX_ROAD_INFO_UPDATE",onUpdate);
         _bugBtn.addEventListener("click",onBuyClick);
      }
      
      private function removeEvent() : void
      {
         NotificationManager.instance.removeEventListener("SKYBOX_ROAD_INFO_UPDATE",onUpdate);
         _bugBtn.removeEventListener("click",onBuyClick);
      }
      
      private function onBuyClick(param1:MouseEvent) : void
      {
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("skytrial_buy_skill_cost");
         var _loc4_:Array = _loc3_.ConfigValue.split(",");
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc5_:String = LanguageMgr.GetTranslation("skyboxroad.view.SkyboxRoadSkillItem.txt1",_loc4_[0]);
         SharedManagerHelper.ins.needAlert("skyboxroad.view.SkyboxRoadSkillItem.onBuyClick",buyCallBack,_loc2_,_loc5_);
      }
      
      private function buyCallBack() : void
      {
         SkyboxRoadManager.instance.buySkill(_tempId);
      }
      
      public function data(param1:int) : void
      {
         _tempId = param1;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_tempId);
         _icon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
         _icon.tipData = _loc2_;
         onUpdate();
      }
      
      private function onUpdate(param1:Event = null) : void
      {
         var _loc2_:Object = model.skyTrialInfo.skillCountList;
         _txt.text = _loc2_[_tempId];
      }
      
      private function get model() : SkyboxRoadModel
      {
         return SkyboxRoadManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_bugBtn);
         _bugBtn = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

