package pet.equipstore.refinery
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.StoreEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.PetEquipManager;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class PetEquipRefinerySkillItem extends Sprite implements Disposeable
   {
      
      protected var _refineryAttributeSelected:SelectedButton;
      
      protected var _refineryAttributeTxt:FilterFrameText;
      
      protected var _refineryAttributeNewTxt:FilterFrameText;
      
      protected var _skillTempId:int;
      
      public function PetEquipRefinerySkillItem()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _refineryAttributeSelected = ComponentFactory.Instance.creatComponentByStylename("petEquipRefineryView.selectedButton");
         _refineryAttributeTxt = ComponentFactory.Instance.creatComponentByStylename("pet.refineryAttributeTxt");
         _refineryAttributeNewTxt = ComponentFactory.Instance.creatComponentByStylename("pet.refineryAttributeNewTxt");
         addChild(_refineryAttributeSelected);
         _refineryAttributeSelected.selected = false;
         addChild(_refineryAttributeTxt);
         _refineryAttributeTxt.text = "物攻 9999(10{invalid_utf8=230}{invalid_utf8=152}?)";
         addChild(_refineryAttributeNewTxt);
         _refineryAttributeNewTxt.text = "魔攻 9999(10{invalid_utf8=230}{invalid_utf8=152}?)";
      }
      
      private function initEvent() : void
      {
         _refineryAttributeSelected.addEventListener("click",__selectedHandle);
      }
      
      private function removeEvent() : void
      {
         _refineryAttributeSelected.removeEventListener("click",__selectedHandle);
      }
      
      public function get skillTempId() : int
      {
         return _skillTempId;
      }
      
      public function set randomSkill(param1:int) : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc2_)
         {
            _refineryAttributeTxt.text = _loc2_.TemplateName + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc2_.Grades);
            _refineryAttributeSelected.visible = true;
            if(_skillTempId != param1)
            {
               _refineryAttributeSelected.selected = false;
               NotificationManager.instance.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
            }
         }
         else
         {
            _refineryAttributeTxt.text = "";
            _refineryAttributeSelected.selected = false;
            _refineryAttributeSelected.visible = false;
            NotificationManager.instance.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
         }
         _skillTempId = param1;
         if(_refineryAttributeSelected.selected)
         {
            _refineryAttributeTxt.setFrame(2);
         }
         else
         {
            _refineryAttributeTxt.setFrame(1);
         }
      }
      
      public function set randomNewSkill(param1:int) : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc2_)
         {
            _refineryAttributeNewTxt.text = _loc2_.TemplateName + LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.Grades1",_loc2_.Grades);
         }
         else
         {
            _refineryAttributeNewTxt.text = "";
         }
      }
      
      private function __selectedHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(PetEquipManager.isFirstClick && _refineryAttributeSelected.selected == true)
         {
            SimpleAlertHelper.instance.data = [_confirmLockFirst];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("store.view.refresh.RefreshAttriItem.content");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2);
            return;
         }
         if(_refineryAttributeSelected.selected)
         {
            _refineryAttributeTxt.setFrame(2);
         }
         else
         {
            _refineryAttributeTxt.setFrame(1);
         }
         NotificationManager.instance.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
      }
      
      private function _confirmLockFirst(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            PetEquipManager.isFirstClick = false;
            PetEquipManager.refineryUseBind = param2;
            _refineryAttributeSelected.selected = true;
            _refineryAttributeTxt.setFrame(2);
            NotificationManager.instance.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
         }
         else
         {
            _refineryAttributeSelected.selected = false;
            _refineryAttributeTxt.setFrame(1);
         }
      }
      
      public function set selected(param1:Boolean) : void
      {
         _refineryAttributeSelected.selected = param1;
         if(_refineryAttributeSelected.selected)
         {
            _refineryAttributeTxt.setFrame(2);
         }
         else
         {
            _refineryAttributeTxt.setFrame(1);
         }
      }
      
      public function get selected() : Boolean
      {
         return _refineryAttributeSelected && _refineryAttributeSelected.selected;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function get refineryAttributeNewTxt() : FilterFrameText
      {
         return _refineryAttributeNewTxt;
      }
      
      public function set refineryAttributeNewTxt(param1:FilterFrameText) : void
      {
         _refineryAttributeNewTxt = param1;
      }
   }
}

