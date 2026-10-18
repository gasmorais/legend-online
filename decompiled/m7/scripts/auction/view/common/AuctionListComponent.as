package auction.view.common
{
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.module.auction.AuctionListItemData;
   
   [Event(name="select",type="flash.events.Event")]
   public class AuctionListComponent extends Sprite
   {
      
      private var _vbox:VBox;
      
      private var _selectItem:AuctionListItemBase;
      
      private var _itemClass:Class;
      
      private var _length:int;
      
      private var _gap:Number;
      
      private var _callBack:Function;
      
      public function AuctionListComponent(param1:Class, param2:int, param3:Number)
      {
         _itemClass = param1;
         _length = param2;
         _gap = param3;
         initView();
         super();
      }
      
      public function get callBack() : Function
      {
         return _callBack;
      }
      
      public function set callBack(param1:Function) : void
      {
         _callBack = param1;
      }
      
      private function initView() : void
      {
         _vbox = new VBox();
         _vbox.spacing = _gap;
         addChild(_vbox);
      }
      
      public function setData(param1:Array) : void
      {
         var _loc2_:int = 0;
         clear();
         _loc2_ = 0;
         while(_loc2_ < _length)
         {
            if(param1 && _loc2_ < param1.length)
            {
               addItem(param1[_loc2_]);
            }
            else
            {
               addItem(null);
            }
            _loc2_++;
         }
      }
      
      private function addItem(param1:AuctionListItemData) : void
      {
         var _loc2_:AuctionListItemBase = new _itemClass();
         _loc2_.setData(param1);
         _loc2_.doubleClickEnabled = true;
         _loc2_.addEventListener("click",onItemClick);
         _loc2_.addEventListener("doubleClick",onItemDoubleClick);
         _vbox.addChild(_loc2_);
      }
      
      private function onItemDoubleClick(param1:MouseEvent) : void
      {
         if(_callBack != null)
         {
            _callBack();
         }
      }
      
      private function onItemClick(param1:MouseEvent) : void
      {
         if(_selectItem == param1.currentTarget)
         {
            return;
         }
         setSelectItem(param1.currentTarget as AuctionListItemBase);
         dispatchEvent(new Event("select"));
      }
      
      private function setSelectItem(param1:AuctionListItemBase) : void
      {
         if(_selectItem)
         {
            _selectItem.selected = false;
         }
         _selectItem = param1;
         _selectItem.selected = true;
      }
      
      private function clear() : void
      {
         var _loc1_:AuctionListItemBase = null;
         while(_vbox.numChildren > 0)
         {
            _loc1_ = _vbox.getChildAt(0) as AuctionListItemBase;
            _loc1_.removeEventListener("click",onItemClick);
            _loc1_.removeEventListener("doubleClick",onItemDoubleClick);
            _vbox.removeChild(_loc1_);
            _loc1_.dispose();
            _loc1_ = null;
         }
         _selectItem = null;
      }
      
      public function getSelectedItemData() : AuctionListItemData
      {
         if(_selectItem)
         {
            return _selectItem.getData();
         }
         return null;
      }
      
      public function dispose() : void
      {
         clear();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

