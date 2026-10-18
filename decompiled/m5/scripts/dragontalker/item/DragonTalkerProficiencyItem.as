package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.DragonTalkerManager;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerProficiencyInfo;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class DragonTalkerProficiencyItem extends Component
   {
      
      private var _back:ScaleBitmapImage;
      
      private var _overBg:Image;
      
      private var _gradeBack:Image;
      
      private var _gradeImage:ScaleFrameImage;
      
      private var _skillContiner:Component;
      
      private var _activeSkill:BaseIconView;
      
      private var _starHbox:HBox;
      
      private var _skillName:FilterFrameText;
      
      private var _skillDesc:FilterFrameText;
      
      private var _changeBtn:IconButton;
      
      private var _skillHBox:HBox;
      
      private var index:int;
      
      private var _data:DragonTalkerProficiencyInfo;
      
      public function DragonTalkerProficiencyItem(param1:int)
      {
         super();
         index = param1;
         initView();
         initNoActiveSkillView();
         addEvent();
      }
      
      private function initView() : void
      {
         _skillDesc = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a_n8_b4rj");
         _skillName = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a_n7_b4rj");
         _skillContiner = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n6_b4rj.skillContiner");
         _skillHBox = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.n4_b4rj.skillHBox");
         _overBg = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a.overBg");
         _gradeBack = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a.gradeBack");
         _back = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a.back");
         _changeBtn = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a.changeBtn");
         _gradeImage = ComponentFactory.Instance.creatComponentByStylename("DragonTalker.b4rj4a.gradeImage");
         _starHbox = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyItem.starHbox");
         _activeSkill = ComponentFactory.Instance.creatCustomObject("DragonTalkerProficiencyItem.activeSkill");
         addChild(_back);
         addChild(_overBg);
         addChild(_gradeBack);
         addChild(_gradeImage);
         addChild(_skillHBox);
         addChild(_skillContiner);
         _skillContiner.addChild(_skillDesc);
         _skillContiner.addChild(_skillName);
         _skillContiner.addChild(_changeBtn);
         _skillContiner.addChild(_activeSkill);
         _skillContiner.addChild(_starHbox);
         _gradeImage.setFrame(index);
         _overBg.visible = false;
         _skillContiner.mouseEnabled = _skillHBox.mouseEnabled = _starHbox.mouseEnabled = false;
      }
      
      private function initNoActiveSkillView() : void
      {
         var _loc2_:int = 0;
         var _loc7_:Component = null;
         var _loc3_:ScaleBitmapImage = null;
         var _loc1_:BaseIconView = null;
         var _loc6_:FilterFrameText = null;
         var _loc4_:int = 0;
         var _loc5_:SkillTempInfo = null;
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc7_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyItem.skillItem");
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyItem.skillBack");
            _loc1_ = ComponentFactory.Instance.creatCustomObject("DragonTalkerProficiencyItem.skillIcon");
            _loc6_ = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerProficiencyItem.nameText");
            _loc4_ = 3 * index - (2 - _loc2_);
            _loc5_ = model.profiencySkillTempDic[_loc4_ + "_" + 1];
            _loc7_.addChild(_loc3_);
            _loc7_.addChild(_loc1_);
            _loc7_.addChild(_loc6_);
            _loc1_.icon = IconFactory.getTecIconByIcon(_loc5_.Icons);
            _loc1_.tipData = _loc5_;
            _loc6_.text = _loc5_.TemplateName;
            _skillHBox.addChild(_loc7_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _changeBtn.addEventListener("click",_changeBtnClickHandler);
         addEventListener("mouseOver",__onOverHandler);
         addEventListener("mouseOut",__onOutHandler);
         addEventListener("click",__onClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(_changeBtn)
         {
            _changeBtn.removeEventListener("click",_changeBtnClickHandler);
         }
         removeEventListener("mouseOver",__onOverHandler);
         removeEventListener("mouseOut",__onOutHandler);
         removeEventListener("click",__onClickHandler);
      }
      
      private function __onOverHandler(param1:MouseEvent) : void
      {
         _overBg.visible = true;
      }
      
      private function __onOutHandler(param1:MouseEvent) : void
      {
         _overBg.visible = false;
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(!data.isActive || data.skillTemp)
         {
            return;
         }
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("dragontalker","PROFICIENCY_CHANGE_FRAME",index);
      }
      
      private function _changeBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("dragontalker","PROFICIENCY_CHANGE_FRAME",index);
         param1.stopPropagation();
      }
      
      public function get data() : DragonTalkerProficiencyInfo
      {
         return _data;
      }
      
      public function set data(param1:DragonTalkerProficiencyInfo) : void
      {
         _data = param1;
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         if(!data)
         {
            return;
         }
         _starHbox.removeAllChild();
         if(data.isActive)
         {
            this.filters = [];
            if(data.skillTemp)
            {
               _skillContiner.visible = true;
               _skillHBox.visible = false;
               _activeSkill.icon = IconFactory.getTecIconByIcon(data.skillTemp.Icons);
               _activeSkill.tipData = data.skillTemp;
               _skillName.text = data.skillTemp.TemplateName;
               _skillDesc.text = data.skillTemp.Description;
               _loc2_ = 0;
               while(_loc2_ < data.skillTemp.Grades)
               {
                  _loc1_ = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerProficiencyFrame.startBitmap");
                  _starHbox.addChild(_loc1_);
                  _loc2_++;
               }
               _starHbox.x = 10 * (4 - data.skillTemp.Grades);
               this.buttonMode = false;
            }
            else
            {
               _skillContiner.visible = false;
               _skillHBox.visible = true;
               this.buttonMode = true;
            }
         }
         else
         {
            this.buttonMode = false;
            _skillContiner.visible = false;
            _skillHBox.visible = true;
            this.filters = [UIFilter.getGrayFilter()];
         }
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_skillDesc);
         _skillDesc = null;
         ObjectUtils.disposeObject(_skillName);
         _skillName = null;
         ObjectUtils.disposeObject(_skillContiner);
         _skillContiner = null;
         ObjectUtils.disposeObject(_skillHBox);
         _skillHBox = null;
         ObjectUtils.disposeObject(_overBg);
         _overBg = null;
         ObjectUtils.disposeObject(_gradeBack);
         _gradeBack = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_changeBtn);
         _changeBtn = null;
         ObjectUtils.disposeObject(_gradeImage);
         _gradeImage = null;
         ObjectUtils.disposeObject(_activeSkill);
         _activeSkill = null;
         ObjectUtils.disposeObject(_starHbox);
         _starHbox = null;
         super.dispose();
      }
   }
}

