package store.treasure
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.StoreEvent;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.templates.SkillTempInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleAlertHelper;
   
   public class TreasureRefreshAttriItem extends Sprite implements Disposeable
   {
      
      private var _refreshAttributeSelected:SelectedButton;
      
      private var _refreshAttributebg:BaseButton;
      
      private var _refreshAttributebgNew:BaseButton;
      
      private var _refreshAttributeTxt:FilterFrameText;
      
      private var _refreshAttributeNewTxt:FilterFrameText;
      
      private var _skillTempId:int;
      
      public function TreasureRefreshAttriItem()
      {
         super();
         initView();
         initEvent();
         randomSkill = -1;
         randomNewSkill = -1;
      }
      
      private function initView() : void
      {
         _refreshAttributeSelected = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeBtn");
         _refreshAttributebg = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributebg");
         _refreshAttributebgNew = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributebg");
         _refreshAttributeTxt = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeTxt.treasure");
         _refreshAttributeNewTxt = ComponentFactory.Instance.creatComponentByStylename("store.RefreshAttributeNewTxt.treasure");
         _refreshAttributebg.mouseEnabled = false;
         _refreshAttributebgNew.mouseEnabled = false;
         _refreshAttributebgNew.x = 200;
         _refreshAttributeTxt.text = "";
         _refreshAttributeNewTxt.text = "";
         addChild(_refreshAttributeSelected);
         addChild(_refreshAttributebg);
         addChild(_refreshAttributebgNew);
         addChild(_refreshAttributeTxt);
         addChild(_refreshAttributeNewTxt);
      }
      
      public function set randomSkill(param1:int) : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc2_)
         {
            _refreshAttributeTxt.text = _loc2_.Description;
            _refreshAttributeTxt.setFrame(_loc2_.ProperType);
            _refreshAttributebg.enable = true;
            _refreshAttributebgNew.enable = true;
            _refreshAttributeSelected.enable = true;
            _refreshAttributebg.mouseEnabled = false;
            _refreshAttributebgNew.mouseEnabled = false;
            if(_skillTempId != param1)
            {
               _refreshAttributeSelected.selected = false;
               storeModel.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
            }
         }
         else
         {
            _refreshAttributeTxt.text = "";
            _refreshAttributeSelected.selected = false;
            _refreshAttributebg.enable = false;
            _refreshAttributebgNew.enable = false;
            _refreshAttributeSelected.enable = false;
            storeModel.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
         }
         _skillTempId = param1;
      }
      
      public function set randomNewSkill(param1:int) : void
      {
         var _loc2_:SkillTempInfo = TempleteManager.instance.getSkillTemplateInfoById(param1);
         if(_loc2_)
         {
            _refreshAttributeNewTxt.text = _loc2_.Description;
            _refreshAttributeNewTxt.setFrame(_loc2_.ProperType);
         }
         else
         {
            _refreshAttributeNewTxt.text = "";
         }
      }
      
      private function initEvent() : void
      {
         _refreshAttributeSelected.addEventListener("click",__selectedHandle);
      }
      
      private function removeEvent() : void
      {
         _refreshAttributeSelected.removeEventListener("click",__selectedHandle);
      }
      
      private function __selectedHandle(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc5_:String = null;
         if(!control.clcikLockFirst && _refreshAttributeSelected.selected == true)
         {
            _refreshAttributeSelected.selected = false;
            SimpleAlertHelper.instance.data = [_confirmLockFirst];
            _loc2_ = LanguageMgr.GetTranslation("public.confirm");
            _loc3_ = LanguageMgr.GetTranslation("public.cancel");
            _loc4_ = LanguageMgr.GetTranslation("public.prompt");
            _loc5_ = LanguageMgr.GetTranslation("store.view.refresh.TreasureRefreshAttriItem.content");
            SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,false,false,2,"SIMPLE_ALERT",0,"",null,"SimpleAlert");
            return;
         }
         storeModel.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
      }
      
      private function _confirmLockFirst(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            control.clcikLockFirst = true;
         }
         _refreshAttributeSelected.selected = param1;
         storeModel.dispatchEvent(new StoreEvent("REFRESH_LOCK_CHANGE"));
      }
      
      private function get storeModel() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      public function get selected() : Boolean
      {
         return _refreshAttributeSelected.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _refreshAttributeSelected.selected = param1;
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
      
      public function get refreshAttributeNewTxt() : FilterFrameText
      {
         return _refreshAttributeNewTxt;
      }
      
      public function set refreshAttributeNewTxt(param1:FilterFrameText) : void
      {
         _refreshAttributeNewTxt = param1;
      }
   }
}

