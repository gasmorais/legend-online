package theseus.war.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.theseus.AttributeUtils;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   
   public class TheseusWarRefineItem extends Sprite
   {
      
      private var _refreshAttributeSelected:SelectedButton;
      
      private var _refreshAttributeTxt:FilterFrameText;
      
      private var _refreshAttributeNewTxt:FilterFrameText;
      
      private var _baseSkId:int;
      
      private var _preSkId:int;
      
      public function TheseusWarRefineItem()
      {
         super();
         initView();
         initEvent();
         _baseSkId = -1;
         _preSkId = -1;
      }
      
      public function set preSkId(param1:int) : void
      {
         _preSkId = param1;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_preSkId);
         if(_loc2_)
         {
            if(_loc2_.Parameter3 <= 0)
            {
               _refreshAttributeNewTxt.text = _loc2_.TemplateName + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc2_.Grades);
            }
            else
            {
               _refreshAttributeNewTxt.text = _loc2_.TemplateName + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades2",_loc2_.Grades);
            }
         }
         else
         {
            _refreshAttributeNewTxt.text = "";
         }
         if(_baseSkId > 0 || _preSkId > 0)
         {
            _refreshAttributeSelected.visible = true;
         }
         else
         {
            _refreshAttributeSelected.visible = false;
         }
      }
      
      public function openLock(param1:Number) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("theseus.war.lockTag",param1);
         _refreshAttributeTxt.htmlText = AttributeUtils.getColorStr(_loc2_,"#B3B3B3");
      }
      
      public function set baseSkId(param1:int) : void
      {
         _baseSkId = param1;
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(_baseSkId);
         if(_loc2_)
         {
            _refreshAttributeSelected.enable = true;
            if(_loc2_.Parameter3 <= 0)
            {
               _refreshAttributeTxt.text = _loc2_.Description + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc2_.Grades);
            }
            else
            {
               _refreshAttributeTxt.text = _loc2_.Description + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades2",_loc2_.Grades);
            }
         }
         else
         {
            _refreshAttributeTxt.text = "";
            _refreshAttributeSelected.selected = false;
         }
         if(_baseSkId > 0 || _preSkId > 0)
         {
            _refreshAttributeSelected.visible = true;
         }
         else
         {
            _refreshAttributeSelected.visible = false;
         }
      }
      
      private function initView() : void
      {
         _refreshAttributeSelected = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeBtn");
         _refreshAttributeTxt = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeTxt");
         _refreshAttributeNewTxt = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeNewTxt");
         addChild(_refreshAttributeSelected);
         addChild(_refreshAttributeTxt);
         addChild(_refreshAttributeNewTxt);
      }
      
      public function get selected() : Boolean
      {
         return _refreshAttributeSelected.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _refreshAttributeSelected.selected = param1;
         if(_refreshAttributeSelected.selected)
         {
            _refreshAttributeTxt.setFrame(2);
         }
         else
         {
            _refreshAttributeTxt.setFrame(1);
         }
      }
      
      private function initEvent() : void
      {
         _refreshAttributeSelected.addEventListener("select",__selectedHandle);
      }
      
      private function removeEvent() : void
      {
         _refreshAttributeSelected.removeEventListener("select",__selectedHandle);
      }
      
      private function __selectedHandle(param1:Event) : void
      {
         NotificationManager.instance.sendNotification("Event.theseuswar.lockChange");
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_refreshAttributeSelected);
         _refreshAttributeSelected = null;
         ObjectUtils.disposeObject(_refreshAttributeTxt);
         _refreshAttributeTxt = null;
         ObjectUtils.disposeObject(_refreshAttributeNewTxt);
         _refreshAttributeNewTxt = null;
         if(parent)
         {
            removeChild(this);
         }
      }
   }
}

