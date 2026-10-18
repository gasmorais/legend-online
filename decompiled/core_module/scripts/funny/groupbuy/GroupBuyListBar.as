package funny.groupbuy
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   import mvc.module.shop.MainShopInfo;
   
   public class GroupBuyListBar extends Component
   {
      
      private var _bg:DisplayObject;
      
      private var _vbox:VBox;
      
      private var _scroll:ScrollPanel;
      
      private var _selectedItem:GroupBuyListItem;
      
      private var _groupBuyArr:Array;
      
      public function GroupBuyListBar(param1:Array)
      {
         _groupBuyArr = param1;
         super();
         initUI();
         addEvents();
      }
      
      private function initUI() : void
      {
         var _loc1_:GroupBuyListItem = null;
         var _loc4_:MainShopInfo = null;
         var _loc3_:int = 0;
         _bg = ComponentFactory.Instance.creat("asset.groupbuy.listbg");
         this.addChild(_bg);
         _vbox = new VBox();
         _vbox.spacing = 1;
         _scroll = ComponentFactory.Instance.creatComponentByStylename("groupbuy.scrollPanel");
         _scroll.beginChanges();
         _scroll.setView(_vbox);
         _scroll.commitChanges();
         addChild(_scroll);
         var _loc2_:int = int(_groupBuyArr.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc4_ = _groupBuyArr[_loc3_];
            if(_loc2_ <= 6)
            {
               _loc1_ = new GroupBuyListItem(_loc4_,2);
            }
            else
            {
               _loc1_ = new GroupBuyListItem(_loc4_,1);
            }
            _vbox.addChild(_loc1_);
            if(_loc3_ == 0)
            {
               _loc1_.isSelected = true;
               _selectedItem = _loc1_;
            }
            _loc3_++;
         }
         _vbox.refreshChildPos();
         _scroll.invalidateViewport();
         if(_groupBuyArr.length > 6)
         {
            _scroll.vScrollbar.visible = true;
         }
         else
         {
            _scroll.vScrollbar.visible = false;
         }
         if(_groupBuyArr.length <= 2)
         {
            _scroll.height = 55;
            _bg.height = 55;
         }
         else if(_groupBuyArr.length > 2 && _groupBuyArr.length <= 4)
         {
            _scroll.height = 113;
            _bg.height = 113;
         }
         else if(_groupBuyArr.length > 4)
         {
            _scroll.height = 168;
            _bg.height = 168;
         }
      }
      
      private function addEvents() : void
      {
         _vbox.addEventListener("click",vboxClickHandler);
      }
      
      private function removeEvents() : void
      {
         _vbox.removeEventListener("click",vboxClickHandler);
      }
      
      protected function vboxClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(!(param1.target.parent as GroupBuyListItem))
         {
            return;
         }
         var _loc3_:GroupBuyListItem = param1.target.parent as GroupBuyListItem;
         if(_selectedItem)
         {
            _selectedItem.isSelected = false;
         }
         _selectedItem = _loc3_;
         _selectedItem.isSelected = true;
      }
      
      override public function dispose() : void
      {
         removeEvents();
         ObjectUtils.disposeAllChildren(_vbox);
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_scroll);
         _scroll = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_selectedItem)
         {
            ObjectUtils.disposeObject(_selectedItem);
            _selectedItem = null;
         }
         _groupBuyArr = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

