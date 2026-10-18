package theseusCollention.view
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
   import yishi.view.community.BaseItemView;
   
   public class TheseusCollectShowBoxFrame extends Frame implements IManualSize
   {
      
      private var _bg:Bitmap;
      
      private var _btn:IconButton;
      
      private var _sprite:Sprite;
      
      private var _itemList:Array;
      
      private var _showList:Array;
      
      public function TheseusCollectShowBoxFrame(param1:Array)
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
         _btn = ComponentFactory.Instance.creatComponentByStylename("shopBoxFrame.btn");
         addToContent(_bg);
         initItem();
         addToContent(_btn);
      }
      
      private function initItem() : void
      {
         var _loc1_:BaseItemView = null;
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
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TheseusCollectShowBoxFrame.getItem1");
            _loc1_.x = _loc5_ + int(_loc4_ % _loc3_) * 110;
            _loc1_.y = 53 + int(_loc4_ / _loc3_) * 100;
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = _showList[_loc4_].itemId;
            _loc6_.count = _showList[_loc4_].num;
            _loc1_.data = _loc6_;
            _sprite.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      private function removeEvent() : void
      {
         _btn.removeEventListener("click",__clickHandler);
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
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeViolentMc(_sprite);
         _sprite = null;
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemList = null;
         _showList = null;
         super.dispose();
      }
   }
}

