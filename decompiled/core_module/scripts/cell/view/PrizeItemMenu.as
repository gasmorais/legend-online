package cell.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ConsortiaSocketOutManager;
   import yishi.view.community.BaseItemView;
   
   public class PrizeItemMenu extends Sprite implements Disposeable
   {
      
      private var _currentItem:BaseItemView;
      
      private var _allotBtn:TextButton;
      
      private var _vBox:VBox;
      
      public function PrizeItemMenu(param1:BaseItemView)
      {
         super();
         _currentItem = param1;
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _allotBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.AllotButton");
         _allotBtn.text = LanguageMgr.GetTranslation("cell.view.PrizeItemMenu.allot");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("consortia.PrizeItemMenuContain");
         _vBox.addChild(_allotBtn);
         addChild(_vBox);
      }
      
      private function initEvents() : void
      {
         _allotBtn.addEventListener("click",__allotBtnClickHandler);
      }
      
      private function removeEvents() : void
      {
         _allotBtn.removeEventListener("click",__allotBtnClickHandler);
      }
      
      private function __allotBtnClickHandler(param1:MouseEvent) : void
      {
         ConsortiaSocketOutManager.consortiaPrizeAllot(_currentItem.data.templateId);
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         _currentItem = null;
         if(_allotBtn)
         {
            ObjectUtils.disposeObject(_allotBtn);
         }
         _allotBtn = null;
         if(_vBox)
         {
            ObjectUtils.disposeObject(_vBox);
         }
         _vBox = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

