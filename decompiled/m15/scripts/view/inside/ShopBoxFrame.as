package view.inside
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   
   public class ShopBoxFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _openBtn:IconButton;
      
      private var _btn:IconButton;
      
      private var _sprite:Sprite;
      
      private var _itemList:Array;
      
      private var _showList:Array;
      
      public function ShopBoxFrame(param1:Array)
      {
         super();
         _showList = param1;
         initView();
         addEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,789,314);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.shopBoxFrame.bg");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("shopBoxFrame.openBtn");
         _btn = ComponentFactory.Instance.creatComponentByStylename("shopBoxFrame.btn");
         addToContent(_bg);
         initItem();
         addToContent(_btn);
         addToContent(_openBtn);
      }
      
      private function initItem() : void
      {
         var _loc1_:ShopBoxCardItem = null;
         var _loc6_:GoodsInfo = null;
         var _loc4_:int = 0;
         _sprite = new Sprite();
         _itemList = [];
         addToContent(_sprite);
         var _loc2_:int = int(_showList.length);
         var _loc3_:int = _loc2_ / 2;
         var _loc5_:int = _loc2_ == 10 ? 145 : 255;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc1_ = new ShopBoxCardItem(_loc4_);
            _loc1_.x = _loc5_ + int(_loc4_ % _loc3_) * 110;
            _loc1_.y = 53 + int(_loc4_ / _loc3_) * 100;
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _showList[_loc4_].itemId;
            _loc6_.count = _showList[_loc4_].itemCount;
            _loc1_.data = _loc6_;
            _sprite.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
         play();
      }
      
      public function play(param1:int = 0) : void
      {
         var _loc2_:ShopBoxCardItem = null;
         var _loc4_:Boolean = false;
         var _loc3_:int = 0;
         if(_itemList[param1])
         {
            if(!_openBtn.visible)
            {
               return;
            }
            _loc2_ = _itemList[param1] as ShopBoxCardItem;
            _loc2_.play(play);
         }
         else
         {
            _loc4_ = true;
            _loc3_ = 0;
            while(_loc3_ < _itemList.length)
            {
               _loc2_ = _itemList[_loc3_] as ShopBoxCardItem;
               if(!_loc2_.playOver)
               {
                  _loc4_ = false;
               }
               _loc2_.setClick(refreshOpenBtn);
               _loc3_++;
            }
            _openBtn.visible = !_loc4_;
         }
      }
      
      public function refreshOpenBtn() : void
      {
         var _loc1_:ShopBoxCardItem = null;
         var _loc2_:int = 0;
         var _loc3_:Boolean = true;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_] as ShopBoxCardItem;
            if(!_loc1_.playOver)
            {
               _loc3_ = false;
            }
            _loc2_++;
         }
         _openBtn.visible = !_loc3_;
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
         _openBtn.addEventListener("click",__openBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHandler);
         _openBtn.removeEventListener("click",__openBtnClickHandler);
      }
      
      private function __openBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:ShopBoxCardItem = null;
         var _loc3_:int = 0;
         _openBtn.visible = false;
         _loc3_ = 0;
         while(_loc3_ < _itemList.length)
         {
            _loc2_ = _itemList[_loc3_] as ShopBoxCardItem;
            _loc2_.allPlay();
            _loc3_++;
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      public function refreshView() : void
      {
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_sprite);
         _sprite = null;
         for each(var _loc1_:ShopBoxCardItem in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         super.dispose();
      }
   }
}

