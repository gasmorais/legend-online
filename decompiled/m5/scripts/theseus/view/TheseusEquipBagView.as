package theseus.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.TheseussoulManager;
   
   public class TheseusEquipBagView extends Sprite
   {
      
      private var _equipBag:TheseusBagView;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _pageGroup:SelectedButtonGroup;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _page3:SelectedIconButton;
      
      private var _page4:SelectedIconButton;
      
      private var _page5:SelectedIconButton;
      
      private var _page6:SelectedIconButton;
      
      private var _tidyBtn:TextButton;
      
      public function TheseusEquipBagView()
      {
         super();
         initView();
         initEvent();
         _pageGroup.selectIndex = 0;
      }
      
      private function initView() : void
      {
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("TheseusEquipBagView.BagBack");
         _pageGroup = new SelectedButtonGroup();
         _page1 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page1Button");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page2Button");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page3Button");
         _page4 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page4Button");
         _page5 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page5Button");
         _page6 = ComponentFactory.Instance.creatComponentByStylename("theseussoul.Page6Button");
         _tidyBtn = ComponentFactory.Instance.creatComponentByStylename("theseussoul.TidyButton");
         _tidyBtn.text = LanguageMgr.GetTranslation("armyII.ArmyFrameII.tidy");
         _pageGroup.addSelectItem(_page1);
         _pageGroup.addSelectItem(_page2);
         _pageGroup.addSelectItem(_page3);
         _pageGroup.addSelectItem(_page4);
         _pageGroup.addSelectItem(_page5);
         _pageGroup.addSelectItem(_page6);
         addChild(_bagBack);
         addChild(_page1);
         addChild(_page2);
         addChild(_page3);
         addChild(_page4);
         addChild(_page5);
         addChild(_page6);
         _equipBag = new TheseusBagView(7,8,6);
         _equipBag.x = 393;
         _equipBag.y = 26;
         addChild(_equipBag);
         addChild(_tidyBtn);
      }
      
      private function initEvent() : void
      {
         _pageGroup.addEventListener("change",__pageChangeHandler);
         _tidyBtn.addEventListener("click",tidyHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__updateEquipViewHandler);
      }
      
      private function removeEvent() : void
      {
         _pageGroup.removeEventListener("change",__pageChangeHandler);
         _tidyBtn.removeEventListener("click",tidyHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__updateEquipViewHandler);
      }
      
      private function tidyHandler(param1:MouseEvent) : void
      {
         TheseussoulManager.Instance.doWarFrameParam(1);
      }
      
      private function __updateEquipViewHandler(param1:String) : void
      {
         _equipBag.updateView();
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _equipBag.gotoPage(_pageGroup.selectIndex + 1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_equipBag);
         _equipBag = null;
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_page1);
         _page1 = null;
         ObjectUtils.disposeObject(_page2);
         _page2 = null;
         ObjectUtils.disposeObject(_page3);
         _page3 = null;
         ObjectUtils.disposeObject(_page4);
         _page4 = null;
         ObjectUtils.disposeObject(_page5);
         _page5 = null;
         ObjectUtils.disposeObject(_page6);
         _page6 = null;
         ObjectUtils.disposeObject(_tidyBtn);
         _tidyBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

