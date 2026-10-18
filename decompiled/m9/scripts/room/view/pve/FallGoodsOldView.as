package room.view.pve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class FallGoodsOldView extends Sprite implements Disposeable
   {
      
      private var _data:String;
      
      private var _bg:ScaleBitmapImage;
      
      private var _list:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _isOVer:Boolean;
      
      public function FallGoodsOldView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("room.fallGoodsOldBG");
         _list = ComponentFactory.Instance.creatCustomObject("core.fallGoodsList",[4]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("room.fallGoodsOldPanel");
         _panel.beginChanges();
         _panel.setView(_list);
         _panel.commitChanges();
         _panel.invalidateViewport();
         addChild(_bg);
         addChild(_panel);
         _itemList = new Vector.<BaseItemView>();
      }
      
      private function initEvents() : void
      {
         addEventListener("rollOver",_over);
         addEventListener("rollOut",_out);
      }
      
      private function removeEvents() : void
      {
         removeEventListener("rollOver",_over);
         removeEventListener("rollOut",_out);
      }
      
      private function _over(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _isOVer = true;
         data = _data;
      }
      
      private function _out(param1:MouseEvent) : void
      {
         if(!_data || param1.buttonDown)
         {
            return;
         }
         _isOVer = false;
         data = _data;
      }
      
      public function set data(param1:String) : void
      {
         _data = param1;
         removeItems();
         if(StringHelper.isNullOrEmpty(param1))
         {
            return;
         }
         initList();
         setPanelHeight();
      }
      
      private function setPanelHeight() : void
      {
         _panel.beginChanges();
         if(_isOVer && _itemList.length > 4)
         {
            _bg.height = 139;
            _bg.y = -55;
            _panel.y = -28;
            _panel.height = 105;
         }
         else
         {
            _bg.height = 84;
            _bg.y = 0;
            _panel.y = 27;
            _panel.height = 50;
         }
         _panel.commitChanges();
         _panel.invalidateViewport();
         if(_panel.vScrollbar.visible)
         {
            _panel.x = 10;
         }
         else
         {
            _panel.x = 17;
         }
      }
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc6_:GoodsInfo = null;
         var _loc1_:Array = _data.split(",");
         var _loc4_:int = int(_loc1_.length);
         if(_loc4_ > 4)
         {
            _loc3_ = int(_loc4_ > 8 ? _loc4_ : 8);
         }
         else
         {
            _loc3_ = 4;
         }
         if(_isOVer)
         {
            _loc3_ = int(_loc3_ % 4 == 0 ? _loc3_ : _loc3_ + 4 - _loc3_ % 4);
         }
         else
         {
            _loc3_ = 4;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
            _itemList.push(_loc2_);
            _list.addChild(_loc2_);
            _loc6_ = new GoodsInfo();
            if(_loc5_ < _loc4_)
            {
               _loc6_.templateId = int(_loc1_[_loc5_]);
               _itemList[_loc5_].data = _loc6_;
            }
            _loc5_++;
         }
      }
      
      private function removeItems() : void
      {
         var _loc1_:BaseItemView = null;
         while(_itemList.length > 0)
         {
            _loc1_ = _itemList.pop();
            _loc1_.dispose();
            _loc1_ = null;
         }
         _list.refreshChildPos();
         _panel.invalidateViewport();
      }
      
      public function dispose() : void
      {
         removeEvents();
         removeItems();
         _itemList = null;
         if(_bg)
         {
            ObjectUtils.disposeObject(_bg);
         }
         _bg = null;
         if(_list)
         {
            ObjectUtils.disposeObject(_list);
         }
         _list = null;
         if(_panel)
         {
            ObjectUtils.disposeObject(_panel);
         }
         _panel = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

