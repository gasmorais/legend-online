package lordtrial
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class LordTrialRightGoodsView extends Sprite implements Disposeable
   {
      
      private var _data:String;
      
      private var _bg:ScaleBitmapImage;
      
      private var _mayImge:Image;
      
      private var _list:SimpleTileList;
      
      private var _panel:ScrollPanel;
      
      private var _itemList:Vector.<BaseItemView>;
      
      private var _isOVer:Boolean;
      
      public function LordTrialRightGoodsView()
      {
         super();
         initView();
         initEvents();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("lordtrial.fallGoodsOldBG");
         _mayImge = ComponentFactory.Instance.creatComponentByStylename("lordtrial.mayImage");
         _list = ComponentFactory.Instance.creatCustomObject("core.fallGoodsList",[4]);
         _panel = ComponentFactory.Instance.creatComponentByStylename("room.fallGoodsOldPanel");
         _panel.beginChanges();
         _panel.setView(_list);
         _panel.commitChanges();
         _panel.invalidateViewport();
         addChild(_bg);
         addChild(_mayImge);
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
            _mayImge.y = -51;
            _panel.y = -28;
            _panel.height = 105;
         }
         else
         {
            _bg.height = 84;
            _mayImge.y = 4;
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
         var _loc6_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:BaseItemView = null;
         var _loc9_:GoodsInfo = null;
         var _loc1_:String = _data.split("|")[0];
         if(StringHelper.isNullOrEmpty(_loc1_))
         {
            return;
         }
         var _loc2_:Array = _loc1_.split(",");
         var _loc4_:String = _data.split("|")[1];
         var _loc3_:Array = _loc4_.split(",");
         var _loc7_:int = int(_loc2_.length);
         if(_loc7_ > 4)
         {
            _loc6_ = int(_loc7_ > 8 ? _loc7_ : 8);
         }
         else
         {
            _loc6_ = 4;
         }
         if(_isOVer)
         {
            _loc6_ = int(_loc6_ % 4 == 0 ? _loc6_ : _loc6_ + 4 - _loc6_ % 4);
         }
         else
         {
            _loc6_ = 4;
         }
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            _loc5_ = ComponentFactory.Instance.creatCustomObject("core.fallGoods.BaseItemView");
            _itemList.push(_loc5_);
            _list.addChild(_loc5_);
            _loc9_ = new GoodsInfo();
            if(_loc8_ < _loc7_)
            {
               _loc9_.templateId = int(_loc2_[_loc8_]);
               _loc9_.count = int(_loc3_[_loc8_]);
               _itemList[_loc8_].data = _loc9_;
            }
            _loc8_++;
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
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_list);
         _list = null;
         ObjectUtils.disposeObject(_panel);
         _panel = null;
         ObjectUtils.disposeObject(_mayImge);
         _mayImge = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

