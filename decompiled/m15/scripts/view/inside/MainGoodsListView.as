package view.inside
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.module.shop.ShopGoodsInfo;
   import view.GoodsItem;
   import view.GoodsItem1;
   import yishi.manager.FrameControllerManager;
   
   public class MainGoodsListView extends Sprite implements Disposeable
   {
      
      private var _itemList:Vector.<GoodsItem>;
      
      private var _bg:MutipleImage;
      
      private var _pointBg:MutipleImage;
      
      private var _giftBg:MutipleImage;
      
      private var _openState:String;
      
      private var _shopCartBtn:IconButton;
      
      private var _mainRightView:MainRightView;
      
      public function MainGoodsListView(param1:String)
      {
         _openState = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:GoodsItem = null;
         _bg = ComponentFactory.Instance.creatComponentByStylename("shop.GoodsListViewBG2");
         _pointBg = ComponentFactory.Instance.creatComponentByStylename("shop.pointImage");
         _giftBg = ComponentFactory.Instance.creatComponentByStylename("shop.bindDiamond");
         _shopCartBtn = ComponentFactory.Instance.creatComponentByStylename("shop.ShopCartBtn");
         addChild(_bg);
         _mainRightView = new MainRightView();
         _mainRightView.x = 245;
         _mainRightView.y = 5;
         _mainRightView.visible = false;
         addChild(_pointBg);
         _pointBg.x = 221;
         _pointBg.y = 464;
         addChild(_giftBg);
         _giftBg.x = 400;
         _giftBg.y = 464;
         addChild(_shopCartBtn);
         addChild(_mainRightView);
         _itemList = new Vector.<GoodsItem>();
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 9;
         if(_openState == "SHOP_MAIN")
         {
            _loc2_ = 6;
            _mainRightView.visible = true;
            _mainRightView.updateView();
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc5_ = _loc4_ / 3;
            _loc3_ = _loc4_ % 3;
            switch(_openState)
            {
               case "SHOP_MAIN":
                  _loc5_ = _loc4_ / 2;
                  _loc3_ = _loc4_ % 2;
                  _loc1_ = new GoodsItem();
                  _loc1_.x = _loc3_ * (_loc1_.width - 3) + 213;
                  _loc1_.y = _loc5_ * (_loc1_.height - 5) + 36;
                  break;
               case "SHOP_INSIDE":
                  _loc1_ = new GoodsItem1();
                  _loc1_.x = _loc3_ * (_loc1_.width - 3) + 217;
                  _loc1_.y = _loc5_ * _loc1_.height + 36;
                  break;
               default:
                  _loc1_ = new GoodsItem1();
                  _loc1_.x = _loc3_ * (_loc1_.width - 3) + 217;
                  _loc1_.y = _loc5_ * _loc1_.height + 36;
            }
            addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc4_++;
         }
      }
      
      private function initEvent() : void
      {
         if(_shopCartBtn)
         {
            _shopCartBtn.addEventListener("click",__shopCartBtnHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(_shopCartBtn)
         {
            _shopCartBtn.removeEventListener("click",__shopCartBtnHandler);
         }
      }
      
      private function __shopCartBtnHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("shop",200);
      }
      
      public function showList(param1:Array) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _loc2_ = 9;
         if(_openState == "SHOP_MAIN")
         {
            _loc2_ = 6;
         }
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _itemList[_loc4_].data = null;
            _loc4_++;
         }
         var _loc3_:int = int(_loc2_ > param1.length ? _loc2_ : param1.length);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _itemList[_loc4_].data = param1[_loc4_] as ShopGoodsInfo;
            _loc4_++;
         }
      }
      
      public function update() : void
      {
         _mainRightView.updateView();
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:GoodsItem in _itemList)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         _itemList = null;
         ObjectUtils.disposeObject(_mainRightView);
         _mainRightView = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

