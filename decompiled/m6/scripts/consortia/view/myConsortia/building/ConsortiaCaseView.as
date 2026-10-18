package consortia.view.myConsortia.building
{
   import bag.helper.BagHelper;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.ConsortiaManager;
   import yishi.manager.FrameControllerManager;
   
   public class ConsortiaCaseView extends Sprite implements Disposeable
   {
      
      protected var _buttongroup:SelectedButtonGroup;
      
      protected var _page1:SelectedIconButton;
      
      protected var _page2:SelectedIconButton;
      
      protected var _page3:SelectedIconButton;
      
      protected var _caseBag:ConsortiaCaseBag;
      
      protected var _prizeBag:ConsortiaPrizeBag;
      
      protected var _tidyButton:TextButton;
      
      private var _tip2:Bitmap;
      
      private var _tip3:Bitmap;
      
      public function ConsortiaCaseView()
      {
         super();
         initView();
         initEvents();
      }
      
      protected function initView() : void
      {
         _buttongroup = new SelectedButtonGroup();
         _page1 = ComponentFactory.Instance.creatComponentByStylename("consortia.CaseBagPageButton");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("consortia.AgingBagPageButton1");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("consortia.AgingBagPageButton2");
         _tidyButton = ComponentFactory.Instance.creatComponentByStylename("consortia.TidyButton");
         _tip2 = ComponentFactory.Instance.creatBitmap("asset.consortia.caseTips2");
         _tip3 = ComponentFactory.Instance.creatBitmap("asset.consortia.caseTips3");
         _buttongroup.addSelectItem(_page1);
         _buttongroup.addSelectItem(_page2);
         _buttongroup.addSelectItem(_page3);
         _tidyButton.text = LanguageMgr.GetTranslation("consortia.view.myConsortia.building.ConsortiaBagView.tidyButton.text");
         addChild(_page1);
         addChild(_page2);
         addChild(_page3);
         addChild(_tidyButton);
         addChild(_tip2);
         addChild(_tip3);
         _caseBag = new ConsortiaCaseBag(7,8,1);
         _prizeBag = new ConsortiaPrizeBag(7,8,1);
         addChild(_caseBag);
         addChild(_prizeBag);
         showCaseBagTip();
         _buttongroup.selectIndex = 0;
      }
      
      protected function initEvents() : void
      {
         _buttongroup.addEventListener("change",__pageChangeHandler);
         _tidyButton.addEventListener("click",__tidyHandler);
         model.addEventListener("PRIZE_LIST_UPDATE",__prizeListUpdateHandler);
         model.addEventListener("PRIZE_MEMBER_LIST_UPDATE",__prizeMemberListUpdateHandler);
      }
      
      protected function removeEvents() : void
      {
         _buttongroup.removeEventListener("change",__pageChangeHandler);
         _tidyButton.removeEventListener("click",__tidyHandler);
         model.removeEventListener("PRIZE_LIST_UPDATE",__prizeListUpdateHandler);
         model.removeEventListener("PRIZE_MEMBER_LIST_UPDATE",__prizeMemberListUpdateHandler);
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         switch(_buttongroup.getSelectedItem())
         {
            case _page1:
               _loc2_ = 1;
               break;
            case _page2:
               _loc2_ = 2;
               break;
            case _page3:
               _loc2_ = 3;
         }
         if(_caseBag.visible)
         {
            _caseBag.gotoPage(_loc2_);
         }
         showCaseBagTip();
      }
      
      private function __tidyHandler(param1:MouseEvent) : void
      {
         BagHelper.instance.onTidyHandler(_caseBag);
      }
      
      private function __prizeListUpdateHandler(param1:ConsortiaEvent) : void
      {
         _prizeBag.reFreshAll();
      }
      
      private function __prizeMemberListUpdateHandler(param1:ConsortiaEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("consortia",7);
      }
      
      private function showCaseBagTip(param1:Boolean = true) : void
      {
         model.caseBagCanUse = param1;
         _caseBag.visible = param1;
         _tip2.visible = param1;
         _prizeBag.visible = !param1;
         _tip3.visible = !param1;
      }
      
      private function get model() : ConsortiaModel
      {
         return ConsortiaManager.instance.model;
      }
      
      public function get prizeBag() : ConsortiaPrizeBag
      {
         return _prizeBag;
      }
      
      public function get caseBag() : ConsortiaCaseBag
      {
         return _caseBag;
      }
      
      public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(this);
         if(_buttongroup)
         {
            ObjectUtils.disposeObject(_buttongroup);
         }
         _buttongroup = null;
         if(_page1)
         {
            ObjectUtils.disposeObject(_page1);
         }
         _page1 = null;
         if(_page2)
         {
            ObjectUtils.disposeObject(_page2);
         }
         _page2 = null;
         if(_page3)
         {
            ObjectUtils.disposeObject(_page3);
         }
         _page3 = null;
         if(_caseBag)
         {
            ObjectUtils.disposeObject(_caseBag);
         }
         _caseBag = null;
         if(_prizeBag)
         {
            ObjectUtils.disposeObject(_prizeBag);
         }
         _prizeBag = null;
         if(_tidyButton)
         {
            ObjectUtils.disposeObject(_tidyButton);
         }
         _tidyButton = null;
         if(_tip2)
         {
            ObjectUtils.disposeObject(_tip2);
         }
         _tip2 = null;
         if(_tip3)
         {
            ObjectUtils.disposeObject(_tip3);
         }
         _tip3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

