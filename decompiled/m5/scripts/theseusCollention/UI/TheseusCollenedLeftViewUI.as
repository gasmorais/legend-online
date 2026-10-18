package theseusCollention.UI
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import managers.TheseussoulManager;
   import utils.LogicUtils;
   
   public class TheseusCollenedLeftViewUI extends Sprite
   {
      
      protected var _CollenedSuit:VBox;
      
      private var _itemList:Vector.<TheseusCollenedBigItemUI> = new Vector.<TheseusCollenedBigItemUI>();
      
      public function TheseusCollenedLeftViewUI()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initEvent() : void
      {
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",updateView);
      }
      
      private function removeEvent() : void
      {
         TheseussoulManager.Instance.removeEventListener("EVENT_COLLECTION_UPDATE",updateView);
      }
      
      protected function initView() : void
      {
         var _loc1_:TheseusCollenedBigItemUI = null;
         var _loc2_:int = 0;
         _CollenedSuit = ComponentFactory.Instance.creatCustomObject("ui.TheseusCollention.CollenedSuit");
         addChild(_CollenedSuit);
         _CollenedSuit.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc1_ = new TheseusCollenedBigItemUI();
            _itemList[_loc2_] = _loc1_;
            _CollenedSuit.addChild(_loc1_);
            _loc2_++;
         }
         _CollenedSuit.commitChanges();
         updateView();
      }
      
      public function updateView(param1:Event = null) : void
      {
         var _loc3_:Array = null;
         var _loc2_:int = 0;
         if(!_itemList)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < 3)
         {
            _loc3_ = TheseussoulManager.Instance.modelCollenTion.byProGetCollection(_loc2_ + 1);
            _itemList[_loc2_].refreshView(_loc3_);
            _loc2_++;
         }
      }
      
      public function dispose() : void
      {
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_CollenedSuit);
         _CollenedSuit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

