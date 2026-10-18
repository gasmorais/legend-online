package dreamarena.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.DreamArenaManager;
   import mvc.module.dreamarena.DreamArenaModel;
   import yishi.datas.templates.DreamArenaTempInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DreamArenaPetRightItem extends DreamArenaCommonRightItem
   {
      
      private var _skillHbox:HBox;
      
      private var _headBack:Image;
      
      private var _petNameText:FilterFrameText;
      
      private var _petIcon:BaseIconView;
      
      private var _hallowImage:Image;
      
      private var _hallowIcon:BaseIconView;
      
      private var _hallowBack:Image;
      
      private var index:int;
      
      private var _tempInfo:DreamArenaTempInfo;
      
      public function DreamArenaPetRightItem(param1:int)
      {
         param1 = param1;
         super();
         initItemView();
      }
      
      private function initItemView() : void
      {
         _headBack = ComponentFactory.Instance.creatComponentByStylename("DreamArenaPetRightItem.headBack");
         _petNameText = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaPetRightItem.petNameText");
         _petIcon = ComponentFactory.Instance.creatCustomObject("DreamArena.DreamArenaPetRightItem.petIcon");
         _hallowImage = ComponentFactory.Instance.creatComponentByStylename("DreamArena.DreamArenaPetRightItem.hallowImage");
         _skillHbox = ComponentFactory.Instance.creatComponentByStylename("DreamArenaPetRightItem.skillHbox");
         _hallowIcon = ComponentFactory.Instance.creatCustomObject("DreamArenaPetRightItem.hallowIcon");
         _hallowBack = ComponentFactory.Instance.creatComponentByStylename("DreamArenaPetRightItem.hallowBack");
         addChild(_headBack);
         addChild(_petIcon);
         addChild(_petNameText);
         addChild(_skillHbox);
         addChild(_hallowBack);
         addChild(_hallowIcon);
         addChild(_hallowImage);
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
         var _loc7_:PetTemplate = null;
         var _loc1_:BaseIconView = null;
         var _loc6_:SkillTempInfo = null;
         var _loc8_:Bitmap = null;
         var _loc3_:Component = null;
         var _loc5_:int = 0;
         _skillHbox.removeAllChild();
         var _loc2_:Array = [];
         if(tempInfo)
         {
            _loc2_ = tempInfo.Skill1.split(",");
            _loc7_ = tempInfo.typeTempInfo as PetTemplate;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc2_.length)
         {
            _loc6_ = TempleteManager.instance.skillTemplateDic[_loc2_[_loc5_]];
            _loc3_ = new Component();
            _loc8_ = ComponentFactory.Instance.creatBitmap("asset.DreamArenaPetRightItem.skillBack");
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DreamArenaPetRightItem.skillIcon");
            _loc3_.addChild(_loc8_);
            _loc3_.addChild(_loc1_);
            _loc1_.icon = IconFactory.getTecIconByIcon(_loc6_.Icons);
            _loc1_.tipData = _loc6_;
            _skillHbox.addChild(_loc3_);
            _loc5_++;
         }
         var _loc4_:SkillTempInfo = TempleteManager.instance.skillTemplateDic[tempInfo.Skill2.split(",")[0]];
         if(_loc4_)
         {
            _hallowIcon.icon = IconFactory.getTecIconByIcon(_loc4_.Icons);
            _hallowIcon.tipData = _loc4_;
         }
         if(_loc7_)
         {
            _petIcon.icon = IconFactory.getPetHeadSmallIcon(_loc7_.TemplateId);
            _petIcon.tipData = tempInfo;
            _petNameText.text = _loc7_.TemplateName;
         }
      }
      
      public function refreshSkillView() : void
      {
         if(tempInfo && model.selfInfo.heroPetId == tempInfo.TemplateId)
         {
            refreshSelect(true);
            _skillHbox.filters = [];
            _petIcon.filters = [];
            _petNameText.filters = [];
            _hallowImage.filters = [];
            _headBack.filters = [];
            _hallowIcon.filters = [];
            _hallowBack.filters = [];
         }
         else
         {
            refreshSelect(false);
            _skillHbox.filters = [UIFilter.getGrayFilter()];
            _petIcon.filters = [UIFilter.getGrayFilter()];
            _petNameText.filters = [UIFilter.getGrayFilter()];
            _hallowImage.filters = [UIFilter.getGrayFilter()];
            _headBack.filters = [UIFilter.getGrayFilter()];
            _hallowIcon.filters = [UIFilter.getGrayFilter()];
            _hallowBack.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      override protected function _selectBtnClickHandler(param1:MouseEvent) : void
      {
         if(!tempInfo)
         {
            return;
         }
         SoundManager.instance.play("022");
         DreamArenaManager.instance.sendPetOrGoddessSelect(3,tempInfo.TemplateId);
      }
      
      private function get model() : DreamArenaModel
      {
         return DreamArenaManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_headBack);
         _headBack = null;
         ObjectUtils.disposeObject(_petNameText);
         _petNameText = null;
         ObjectUtils.disposeObject(_petIcon);
         _petIcon = null;
         ObjectUtils.disposeObject(_hallowBack);
         _hallowBack = null;
         ObjectUtils.disposeObject(_hallowIcon);
         _hallowIcon = null;
         ObjectUtils.disposeObject(_hallowImage);
         _hallowImage = null;
         ObjectUtils.disposeObject(_skillHbox);
         _skillHbox = null;
         super.dispose();
      }
   }
}

