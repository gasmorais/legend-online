package child.nursingspirit
{
   import child.skill.ChildBattleSkillItemView;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ChildManager;
   import mvc.module.children.ChildNursingSpiritModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.DragManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.GameDrag;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class ChildNSSkillItemView extends Component
   {
      
      private var back:ScaleFrameImage;
      
      private var skillItem:BaseIconView;
      
      private var lvlText:FilterFrameText;
      
      private var typeText:FilterFrameText;
      
      private var addBtn:BaseButton;
      
      private var showType:int;
      
      private var _data:SkillTempInfo;
      
      private var curLearnSkill:SkillTempInfo;
      
      public function ChildNSSkillItemView(param1:int)
      {
         super();
         showType = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         back = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.back");
         skillItem = ComponentFactory.Instance.creatCustomObject("ChildNSSkillItemView.skillItem");
         lvlText = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.lvlText");
         typeText = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.typeText");
         addBtn = ComponentFactory.Instance.creatComponentByStylename("ChildNSSkillItemView.addBtn");
         addChild(back);
         addChild(skillItem);
         addChild(lvlText);
         addChild(typeText);
         addChild(addBtn);
         back.setFrame(showType);
      }
      
      private function addEvent() : void
      {
         skillItem.addEventListener("mouseDown",__itemClickHandler);
         addBtn.addEventListener("click",__addSkillClickHandler);
      }
      
      private function removeEvent() : void
      {
         if(skillItem)
         {
            skillItem.removeEventListener("mouseDown",__itemClickHandler);
         }
         if(addBtn)
         {
            addBtn.removeEventListener("click",__addSkillClickHandler);
         }
      }
      
      private function __addSkillClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:Object = {};
         var _loc3_:int = showType;
         var _loc4_:SkillTempInfo = curLearnSkill ? curLearnSkill : data;
         _loc2_.frameType = _loc3_;
         _loc2_.skillTempData = _loc4_;
         FrameControllerManager.instance.openControllerByInfo("childnursingspirit","SKILL_LEARN",_loc2_);
      }
      
      private function __itemClickHandler(param1:MouseEvent) : void
      {
         if(!checkIsCanDrag())
         {
            return;
         }
         var _loc3_:DisplayObject = getDragIconObj();
         if(!_loc3_)
         {
            return;
         }
         var _loc2_:GameDrag = DragManager.getInstance().starDrag(this,{
            "icon":_loc3_,
            "type":"down"
         });
         _loc2_.onDrop = onDragStop;
         _loc2_.dropChecks = [ChildBattleSkillItemView,Frame,stage];
      }
      
      private function checkIsCanDrag() : Boolean
      {
         if(showType == 1 || showType == 2 || showType == 3)
         {
            return false;
         }
         if(!_data || _data.UseWay == 2)
         {
            return false;
         }
         if(!curLearnSkill)
         {
            return false;
         }
         return true;
      }
      
      private function getDragIconObj() : DisplayObject
      {
         if(skillItem.iconWidth == 0)
         {
            return new Bitmap(new BitmapData(30,30,true,285212672));
         }
         var _loc1_:BitmapData = new BitmapData(skillItem.iconWidth / skillItem.scaleX,skillItem.iconHeight / skillItem.scaleY,true,0);
         _loc1_.draw(skillItem);
         var _loc3_:Bitmap = new Bitmap(_loc1_);
         var _loc2_:Sprite = new Sprite();
         _loc2_.addChild(_loc3_);
         return _loc2_;
      }
      
      private function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:ChildBattleSkillItemView = null;
         if(param1.dropTarget != this)
         {
            if(param1.dropTarget is ChildBattleSkillItemView)
            {
               _loc2_ = param1.dropTarget as ChildBattleSkillItemView;
               _loc2_.data = _data;
               _loc2_.refreshView();
               NotificationManager.instance.sendNotification("REFRESHCHILDBATTLESKILL");
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
      }
      
      public function get data() : SkillTempInfo
      {
         return _data;
      }
      
      public function set data(param1:SkillTempInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         curLearnSkill = nsModel.getIsLearnSkillTempInfo(_data,nsModel.getHasLearnSkillStrByType(showType));
         if(curLearnSkill)
         {
            lvlText.text = curLearnSkill.Grades + "/" + getMaxGrade(_data);
            skillItem.icon = IconFactory.getTecIconByIcon(curLearnSkill.Icons);
            skillItem.tipData = curLearnSkill;
         }
         else
         {
            lvlText.text = "0/" + getMaxGrade(_data);
            skillItem.icon = IconFactory.getTecIconByIcon(data.Icons);
            skillItem.tipData = param1;
         }
         if(showType == 1 || showType == 2)
         {
            typeText.text = LanguageMgr.GetTranslation("ChildNSSkillItemView.typeText.text" + showType);
         }
         else
         {
            typeText.text = _data.TemplateName;
         }
         if(showType == 1 || showType == 2 || showType == 3)
         {
            addBtn.visible = !(curLearnSkill && curLearnSkill.Grades >= getMaxGrade(_data));
         }
         else if(curLearnSkill && curLearnSkill.Grades >= 8 && curLearnSkill.Grades < getMaxGrade(_data) && nsModel.getChildSkillIsMaxByIndex(curLearnSkill.Index))
         {
            addBtn.visible = true;
         }
         else
         {
            addBtn.visible = false;
         }
      }
      
      private function getMaxGrade(param1:SkillTempInfo) : int
      {
         var _loc2_:Array = TempleteManager.instance.getChildSkillsByMasterTypeAndSonType(param1.MasterType,param1.SonType);
         return _loc2_[_loc2_.length - 1].Grades;
      }
      
      public function setLvlText(param1:String) : void
      {
         lvlText.text = param1;
      }
      
      private function get nsModel() : ChildNursingSpiritModel
      {
         return ChildManager.instance.nsModel;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(back);
         back = null;
         ObjectUtils.disposeObject(skillItem);
         skillItem = null;
         ObjectUtils.disposeObject(lvlText);
         lvlText = null;
         ObjectUtils.disposeObject(typeText);
         typeText = null;
         ObjectUtils.disposeObject(addBtn);
         addBtn = null;
         super.dispose();
      }
   }
}

