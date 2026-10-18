package dragontalker.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import mvc.module.armyII.SkillInfo;
   import mvc.module.dragontalker.DragonTalkerModel;
   import mvc.module.dragontalker.DragonTalkerSkillInfo;
   import yishi.datas.consant.SkillPriorityType;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.tips.MessageTipManager;
   
   public class DragonTalkerSkillItemViewII extends Component
   {
      
      private var _back:Bitmap;
      
      private var _icon:BaseIconView;
      
      private var _addPointBtn:BaseButton;
      
      private var _passitiveBit:Bitmap;
      
      private var _superSkillBit:Bitmap;
      
      private var _effectBit:Image;
      
      private var _levelBack:Bitmap;
      
      private var _levelTxt:FilterFrameText;
      
      private var _data:SkillInfo;
      
      private var _filter:IFilterFormat;
      
      private var _noSaveBit:Bitmap;
      
      public function DragonTalkerSkillItemViewII()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cIconBack");
         _addPointBtn = ComponentFactory.Instance.creatComponentByStylename("ui.DragonTalker.cAddPointBtn");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("DragonTalkerSkillItemView.NewSkillLevelTxt");
         _passitiveBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.NewPassitive");
         _superSkillBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.NewSuperSkill");
         _effectBit = ComponentFactory.Instance.creatComponentByStylename("ui.DragonTalker.cEffectBit");
         _icon = ComponentFactory.Instance.creatCustomObject("DragonTalkerSkillItemView.NewSkillIconII");
         _levelBack = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cPointBg");
         _noSaveBit = ComponentFactory.Instance.creatBitmap("asset.DragonTalkerSkillItemView.cNoSave");
         _filter = new UIFilter();
         addChild(_back);
         addChild(_icon);
         addChild(_addPointBtn);
         addChild(_noSaveBit);
         addChild(_passitiveBit);
         addChild(_superSkillBit);
         addChild(_levelBack);
         addChild(_levelTxt);
         addChild(_effectBit);
         _effectBit.visible = false;
         _effectBit.mouseEnabled = _effectBit.mouseChildren = false;
         _noSaveBit.visible = false;
         _passitiveBit.x = _passitiveBit.y = 6;
         _superSkillBit.x = _superSkillBit.y = 6;
      }
      
      public function set data(param1:SkillInfo) : void
      {
         _data = param1;
         if(!_data)
         {
            visible = false;
            return;
         }
         refreshView();
      }
      
      public function get data() : SkillInfo
      {
         return _data;
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _icon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icons);
         _passitiveBit.visible = _data.templateInfo.UseWay == 2;
         _superSkillBit.visible = SkillPriorityType.isSuperSkill(_data.templateInfo.Priority);
         checkCondition();
         _icon.tipData = _data;
         _addPointBtn.tipData = _data;
      }
      
      public function checkCondition() : void
      {
         var _loc2_:DragonTalkerLine = null;
         if(!_data)
         {
            return;
         }
         _back.visible = true;
         var _loc3_:int = int(_data.templateInfo.Grades);
         var _loc1_:Dictionary = model.skillLineDic;
         if(_loc1_)
         {
            _loc2_ = _loc1_[_data.templateId];
         }
         _levelTxt.text = "0/" + _loc3_;
         if(_data.grade == 0)
         {
            _filter.setGrayFilter(_icon);
            _filter.setGrayFilter(_passitiveBit);
            _filter.setGrayFilter(_superSkillBit);
            _addPointBtn.visible = false;
            if(_loc2_)
            {
               _loc2_.light = false;
            }
         }
         else
         {
            _icon.visible = true;
            _filter.setNormalFilter(_icon);
            _filter.setNormalFilter(_passitiveBit);
            _filter.setNormalFilter(_superSkillBit);
            if(_loc2_)
            {
               _loc2_.light = true;
            }
            if(_data.grade == 1)
            {
               _addPointBtn.visible = false;
               _levelTxt.text = _loc3_ + "/" + _loc3_;
            }
            else if(_data.grade == 2)
            {
               _addPointBtn.visible = true;
               _back.visible = false;
            }
         }
      }
      
      private function initEvent() : void
      {
         _addPointBtn.addEventListener("click",__addHandler);
         this.addEventListener("rollOver",overHandler);
         this.addEventListener("rollOut",outHandler);
      }
      
      private function removeEvent() : void
      {
         _addPointBtn.removeEventListener("click",__addHandler);
         this.removeEventListener("rollOver",overHandler);
         this.removeEventListener("rollOut",outHandler);
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         _effectBit.visible = true;
      }
      
      private function outHandler(param1:MouseEvent) : void
      {
         _effectBit.visible = false;
      }
      
      private function get model() : DragonTalkerModel
      {
         return DragonTalkerManager.instance.model;
      }
      
      protected function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:DragonTalkerSkillInfo = model.getSkillInfoByIndex(model.skillTabIndex);
         var _loc4_:int = int(data.templateInfo.Grades);
         var _loc3_:int = int(_loc2_.skillPoint);
         if(_loc2_ && _loc3_ < _loc4_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("dragontaler.noSkillPoint"));
            return;
         }
         _loc2_.skillPoint = _loc3_ - _loc4_;
         _noSaveBit.visible = true;
         model.clientLearn(model.skillTabIndex,data.templateId);
      }
      
      public function clearNoSave() : void
      {
         _noSaveBit.visible = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_addPointBtn);
         _addPointBtn = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_superSkillBit);
         _superSkillBit = null;
         ObjectUtils.disposeObject(_passitiveBit);
         _passitiveBit = null;
         ObjectUtils.disposeObject(_levelTxt);
         _levelTxt = null;
         ObjectUtils.disposeObject(_effectBit);
         _effectBit = null;
         ObjectUtils.disposeObject(_levelBack);
         _levelBack = null;
         ObjectUtils.disposeObject(_noSaveBit);
         _noSaveBit = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         _filter = null;
         model.clearSkillLineAndItem();
      }
   }
}

