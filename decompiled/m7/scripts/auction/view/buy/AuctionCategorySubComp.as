package auction.view.buy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   [Event(name="select",type="flash.events.Event")]
   public class AuctionCategorySubComp extends Sprite implements Disposeable
   {
      
      private var _data:Array;
      
      private var _items:Array;
      
      private var _selectedItem:AuctionCategorySubItem;
      
      private var _vBox:VBox;
      
      public function AuctionCategorySubComp()
      {
         super();
      }
      
      public function setData(param1:Array) : void
      {
         _data = param1;
         buildView();
      }
      
      private function buildView() : void
      {
         var _loc1_:AuctionCategorySubItem = null;
         var _loc2_:int = 0;
         if(_data && _data.length > 0)
         {
            _items = [];
            _vBox = new VBox();
            addChild(_vBox);
            _loc2_ = 0;
            while(_loc2_ < _data.length)
            {
               _loc1_ = new AuctionCategorySubItem();
               _loc1_.setData(_data[_loc2_]);
               _vBox.addChild(_loc1_);
               _items.push(_loc1_);
               _loc1_.addEventListener("click",onItemClick);
               if(_loc2_ < _data.length - 1)
               {
                  _vBox.addChild(createLine());
               }
               _loc2_++;
            }
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         if(_selectedItem == param1.currentTarget)
         {
            _selectedItem.selected = true;
            dispatchEvent(new Event("select"));
            return;
         }
         setSelectItem(param1.currentTarget as AuctionCategorySubItem);
         dispatchEvent(new Event("select"));
      }
      
      private function createLine() : DisplayObject
      {
         return ComponentFactory.Instance.creatBitmap("asset.auction.CategorySmallItemLine");
      }
      
      public function setSelectByIndex(param1:int) : void
      {
         var _loc2_:AuctionCategorySubItem = null;
         if(_items && _items.length > param1)
         {
            _loc2_ = _items[param1];
            setSelectItem(_loc2_);
         }
      }
      
      private function setSelectItem(param1:AuctionCategorySubItem) : void
      {
         if(!param1)
         {
            return;
         }
         if(_selectedItem)
         {
            _selectedItem.selected = false;
         }
         _selectedItem = param1;
         _selectedItem.selected = true;
      }
      
      public function getLength() : int
      {
         if(_items)
         {
            return _items.length;
         }
         return 0;
      }
      
      public function getSelectItem() : AuctionCategorySubItem
      {
         return _selectedItem;
      }
      
      private function clear() : void
      {
         for each(var _loc1_:AuctionCategorySubItem in _items)
         {
            if(_loc1_.parent)
            {
               _loc1_.parent.removeChild(_loc1_);
            }
            _loc1_.dispose();
            _loc1_ = null;
         }
         _items = null;
      }
      
      public function dispose() : void
      {
         clear();
         ObjectUtils.disposeObject(_selectedItem);
         _selectedItem = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         _data = null;
      }
   }
}

