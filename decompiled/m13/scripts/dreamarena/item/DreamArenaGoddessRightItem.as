package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.GoddessTempInfo;
   import yishi.datas.templates.SkillPropertyTempInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.base.TextAddBitmap;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaGoddessRightItem extends DreamArenaCommonRightItem
   {
      
      private var _headBack:Bitmap;
      
      private var _goddessIcon:BaseIconView;
      
      private var _gradeText:FilterFrameText;
      
      private var _nameTxt:FilterFrameText;
      
      private var _dedicationLv:TextAddBitmap;
      
      private var _skillHbox:HBox;
      
      private var index:int;
      
      private var _tempInfo:DreamArenaTempInfo;
      
      public function DreamArenaGoddessRightItem(param1:int)
      {
         param1 = param1;
         super();
         initItemView();
      }
      
      private function initItemView() : void
      {
         _headBack = ComponentFactory.Instance.creatBitmap("asset.DreamArenaGoddessRightItem.headBack");
         _goddessIcon = ComponentFactory.Instance.creatCustomObject("DreamArenaGoddessRightItem.goddessIcon");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("DreamArenaGoddessRightItem.NameText");
         _gradeText = ComponentFactory.Instance.creatComponentByStylename("DreamArenaGoddessRightItem.gradeText");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaGoddessRightItem.skillHbox");
         _dedicationLv = ComponentFactory.Instance.creatCustomObject("DreamArenaGoddessRightItem.dedicationLv");
         _dedicationLv.initView("ui.goddess.dedicationLvTxt","asset.DreamArenaGoddessRightItem.dedicationFt","right");
         addChild(_headBack);
         addChild(_goddessIcon);
         addChild(_nameTxt);
         addChild(_gradeText);
         addChild(_dedicationLv);
         addChild(_skillHbox);
         _heroBack.height = 85;
         _line2.y = 78;
      }
      
      public function get tempInfo() : DreamArenaTempInfo
      {
         return _tempInfo;
      }
      
      public function set tempInfo(param1:DreamArenaTempInfo) : void
      {
         _tempInfo = param1;
         initSkillView();
      }
      
      private function initSkillView() : void
      {
         var _loc8_:GoddessTempInfo = null;
         var _loc1_:BaseIconView = null;
         var _loc5_:SkillTempInfo = null;
         var _loc7_:Bitmap = null;
         var _loc3_:Component = null;
         var _loc4_:int = 0;
         var _loc6_:SkillPropertyTempInfo = null;
         _skillHbox.removeAllChild();
         var _loc2_:Array = [];
         if(tempInfo)
         {
            _loc2_ = tempInfo.Skill1.split(",");
            _loc8_ = tempInfo.typeTempInfo as GoddessTempInfo;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc5_ = TempleteManager.instance.skillTemplateDic[_loc2_[_loc4_]];
            _loc3_ = new Component();
            _loc7_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaGoddessRightItem.skillBack");
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DreamArenaGoddessRightItem.skillIcon");
            _loc3_.addChild(_loc7_);
            _loc3_.addChild(_loc1_);
            _loc1_.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            _loc1_.tipData = _loc5_;
            _skillHbox.addChild(_loc3_);
            _loc4_++;
         }
         if(_loc8_)
         {
            _goddessIcon.icon = PathManager.getGoddessHeadIcon(_loc8_.Pic);
            _nameTxt.text = _loc8_.TemplateName;
            _gradeText.text = LanguageMgr.GetTranslation("public.level2",_loc8_.MaxGrade);
            _dedicationLv.setText("+" + _loc8_.MaxDevote);
            _loc6_ = TempleteManager.instance.skillPropertyTemplateCate.getTemplateByID(tempInfo.PropertyId);
            _goddessIcon.tipData = LanguageMgr.GetTranslation("playerinfo.propContiner.tipdata",_loc6_.Attack,_loc6_.Defence,_loc6_.MagicDefence,_loc6_.Live);
         }
      }
      
      public function refreshSkillView() : void
      {
         if(tempInfo && model.selfInfo.goddessId == tempInfo.TemplateId)
         {
            refreshSelect(true);
            _headBack.filters = [];
            _goddessIcon.filters = [];
            _nameTxt.filters = [];
            _gradeText.filters = [];
            _dedicationLv.filters = [];
            _skillHbox.filters = [];
         }
         else
         {
            refreshSelect(false);
            _headBack.filters = [UIFilter.getGrayFilter()];
            _goddessIcon.filters = [UIFilter.getGrayFilter()];
            _nameTxt.filters = [UIFilter.getGrayFilter()];
            _gradeText.filters = [UIFilter.getGrayFilter()];
            _dedicationLv.filters = [UIFilter.getGrayFilter()];
            _skillHbox.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      override protected function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         if(!tempInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         DreamArenaManager.instance.sendPetOrGoddessSelect(5,tempInfo.TemplateId);
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_goddessIcon);
         _goddessIcon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_gradeText);
         _gradeText = null;
         ObjectUtils.disposeObject(_dedicationLv);
         _dedicationLv = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         super.dispose();
      }
   }
}

