package goddess
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import goddess.view.GoddessAvaterView;
   import manager.LanguageMgr;
   import mvc.module.goddess.GoddessInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class GodDessInfoCheckFrame extends Frame
   {
      
      private var _avaterView:GoddessAvaterView;
      
      private var _skillNameBg:MutipleImage;
      
      private var _guardSkillIcon:BaseIconView;
      
      private var _dancingSkillIcon:BaseIconView;
      
      private var _propText:FilterFrameText;
      
      private var _propContiner:Component;
      
      protected var _data:GoddessInfo;
      
      public function GodDessInfoCheckFrame()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _avaterView = ComponentFactory.Instance.creatComponentByStylename("GodDessInfoCheckFrame.GoddessAvaterView",[2]);
         _skillNameBg = ComponentFactory.Instance.creatComponentByStylename("GodDessInfoCheckFrame.skillNameBg");
         _guardSkillIcon = ComponentFactory.Instance.creatCustomObject("GodDessInfoCheckFrame.guardSkillIcon");
         _dancingSkillIcon = ComponentFactory.Instance.creatCustomObject("GodDessInfoCheckFrame.dancingSkillIcon");
         _propText = ComponentFactory.Instance.creatComponentByStylename("GodDessInfoCheckFrame.propText");
         _propContiner = ComponentFactory.Instance.creatComponentByStylename("GodDessInfoCheckFrame.propContiner");
         addToContent(_avaterView);
         addToContent(_dancingSkillIcon);
         addToContent(_guardSkillIcon);
         addToContent(_skillNameBg);
         addToContent(_propContiner);
         _propContiner.addChild(_propText);
         _propText.text = LanguageMgr.GetTranslation("GodDessInfoCheckFrame.propText.text");
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _avaterView.data = _data;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_data.dedicationTempInfo.SkillId);
         _guardSkillIcon.icon = IconFactory.getTecIconByIcon(_loc2_.Icons);
         _guardSkillIcon.tipData = _loc2_;
         var _loc1_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_data.advanceTempInfo.SkillId);
         _dancingSkillIcon.icon = IconFactory.getTecIconByIcon(_loc1_.Icons);
         _dancingSkillIcon.tipData = _loc1_;
         _propContiner.tipData = LanguageMgr.GetTranslation("playerinfo.propContiner.tipdata",_data.attack,_data.defance,_data.magicDefance,_data.live);
      }
      
      public function set data(param1:GoddessInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_avaterView);
         _avaterView = null;
         ObjectUtils.disposeObject(_dancingSkillIcon);
         _dancingSkillIcon = null;
         ObjectUtils.disposeObject(_guardSkillIcon);
         _guardSkillIcon = null;
         ObjectUtils.disposeObject(_skillNameBg);
         _skillNameBg = null;
         ObjectUtils.disposeObject(_propContiner);
         _propContiner = null;
         ObjectUtils.disposeObject(_propText);
         _propText = null;
         super.dispose();
      }
   }
}

