package armyII.viewII.talent
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.controler.ArmyControler;
   import mvc.module.armyII.SkillInfo;
   import yishi.datas.playerinfo.TalentData;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.filter.UIFilter;
   import yishi.interfaces.IFilterFormat;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class TalentItemView extends Sprite implements Disposeable
   {
      
      private var _selectBack:ScaleFrameImage;
      
      private var _icon:BaseIconView;
      
      private var _levelTxtback:ScaleFrameImage;
      
      private var _levelTxt:FilterFrameText;
      
      private var _addBtn:BaseButton;
      
      private var _data:SkillInfo;
      
      private var _filter:IFilterFormat;
      
      private var _isOpen:Boolean;
      
      private var _canAdd:Boolean;
      
      private var _star:Bitmap;
      
      public function TalentItemView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selectBack = ComponentFactory.Instance.creatComponentByStylename("army.skill.TalentSelectBack");
         _selectBack.setFrame(4);
         _levelTxtback = ComponentFactory.Instance.creatComponentByStylename("army.skill.TalentGradeBack");
         _levelTxtback.setFrame(1);
         _icon = ComponentFactory.Instance.creatCustomObject("army.talent.TalentIcon");
         _levelTxt = ComponentFactory.Instance.creatComponentByStylename("army.talent.TalentGradeFullTxt");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("army.skill.TalentAddBtn");
         addChild(_icon);
         addChild(_selectBack);
         addChild(_levelTxtback);
         addChild(_levelTxt);
         _selectBack.mouseChildren = _selectBack.mouseEnabled = false;
         addChild(_addBtn);
         _addBtn.doubleClickEnabled = false;
         _filter = new UIFilter();
         _star = ComponentFactory.Instance.creatBitmap("army.talent.FullGradeStar");
         addChild(_star);
      }
      
      private function initEvent() : void
      {
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
         _addBtn.addEventListener("click",__addHandler);
         _addBtn.addEventListener("mouseOver",__addBtnOverHandler);
         _addBtn.addEventListener("mouseDown",__addBtnOverHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(_data.grade == 0)
         {
            _selectBack.setFrame(1);
         }
         else if(_data.grade >= _data.maxGrade && _data.maxGrade)
         {
            _selectBack.setFrame(3);
         }
         else
         {
            _selectBack.setFrame(2);
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectBack.setFrame(4);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
         _addBtn.removeEventListener("click",__addHandler);
         _addBtn.removeEventListener("mouseOver",__addBtnOverHandler);
         _addBtn.removeEventListener("mouseDown",__addBtnOverHandler);
      }
      
      private function __addBtnOverHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         param1.stopImmediatePropagation();
      }
      
      private function __addHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(_data)
         {
            if(TalentData.isAdvTalent(_data.templateInfo.MasterType))
            {
               control.sendAddTalentSkillPoint(_data.nextTemplateInfo.TemplateId,1,1);
            }
            else
            {
               control.sendAddTalentSkillPoint(_data.nextTemplateInfo.TemplateId,1);
            }
         }
      }
      
      private function refreshView() : void
      {
         if(!_data)
         {
            return;
         }
         _levelTxt.text = _data.grade + "";
         _icon.icon = IconFactory.getTecIconByIcon(_data.templateInfo.Icons);
         if(_data.grade == 0)
         {
            if(_levelTxt.visible)
            {
               _levelTxt.visible = false;
            }
            if(_levelTxtback.visible)
            {
               _levelTxtback.visible = false;
            }
            if(_star.visible)
            {
               _star.visible = false;
            }
         }
         else
         {
            if(!_levelTxt.visible)
            {
               _levelTxt.visible = true;
            }
            if(!_levelTxtback.visible)
            {
               _levelTxtback.visible = true;
            }
            if(_data.grade >= _data.talentMaxGrade)
            {
               _levelTxtback.setFrame(2);
               if(!_star.visible)
               {
                  _star.visible = true;
               }
            }
            else
            {
               if(_star.visible)
               {
                  _star.visible = false;
               }
               _levelTxtback.setFrame(1);
            }
         }
         checkCondition();
         _icon.tipData = _data;
      }
      
      public function checkCondition() : void
      {
         if(!_data)
         {
            return;
         }
         _isOpen = false;
         _canAdd = false;
         if(checkCanAdd())
         {
            _filter.setNormalFilter(_icon);
            _addBtn.visible = true;
            _canAdd = true;
         }
         else
         {
            _filter.setGrayFilter(_icon);
            _addBtn.visible = false;
         }
         if(_data.grade > 0)
         {
            _filter.setNormalFilter(_icon);
            _canAdd = true;
         }
      }
      
      private function checkCanAdd() : Boolean
      {
         if(!_data.nextTemplateInfo)
         {
            return false;
         }
         if(TalentData.isAdvTalent(_data.nextTemplateInfo.MasterType))
         {
            if(thane.talentData.advTalentPoint <= 0)
            {
               return false;
            }
         }
         else if(thane.talentData.talentPoint <= 0)
         {
            return false;
         }
         if(_data.checkTalentUpgradeCondition(_data.nextTemplateInfo).length > 0)
         {
            return false;
         }
         return true;
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
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

