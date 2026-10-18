package theseus.war.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class TheseusWarEquipBagView extends Sprite
   {
      
      private var _equipBag:TheseusWarsoulBagView;
      
      private var _bagBack:Scale9CornerImage;
      
      private var _pageGroup:SelectedButtonGroup;
      
      private var _page1:SelectedIconButton;
      
      private var _page2:SelectedIconButton;
      
      private var _page3:SelectedIconButton;
      
      public function TheseusWarEquipBagView()
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
         _page1 = ComponentFactory.Instance.creatComponentByStylename("asset.theseus.warBagS1IBtn");
         _page2 = ComponentFactory.Instance.creatComponentByStylename("asset.theseus.warBagS2IBtn");
         _page3 = ComponentFactory.Instance.creatComponentByStylename("asset.theseus.warBagS3IBtn");
         _pageGroup.addSelectItem(_page1);
         _pageGroup.addSelectItem(_page2);
         _pageGroup.addSelectItem(_page3);
         addChild(_bagBack);
         addChild(_page1);
         addChild(_page2);
         addChild(_page3);
         _equipBag = new TheseusWarsoulBagView(7,9,0);
         _equipBag.x = 393;
         _equipBag.y = 26;
         addChild(_equipBag);
      }
      
      private function initEvent() : void
      {
         _pageGroup.addEventListener("change",__pageChangeHandler);
      }
      
      private function removeEvent() : void
      {
         _pageGroup.removeEventListener("change",__pageChangeHandler);
      }
      
      private function __pageChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _equipBag.mainType = _pageGroup.selectIndex + 1;
         _equipBag.updateView();
      }
      
      public function updateView() : void
      {
         _equipBag.updateView();
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
         ObjectUtils.disposeObject(_pageGroup);
         _pageGroup = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

