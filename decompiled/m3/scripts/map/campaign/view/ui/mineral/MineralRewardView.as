package map.campaign.view.ui.mineral
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import mvc.controler.ShopControler;
   import yishi.manager.FrameControllerManager;
   
   public class MineralRewardView extends Sprite implements Disposeable
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _vBox:VBox;
      
      private var _closeBtn:BaseButton;
      
      private var _goodsList:Array;
      
      public function MineralRewardView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.commonTipBg");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
         _vBox = new VBox();
         _vBox.x = _vBox.y = 10;
         addChild(_bg);
         addChild(_closeBtn);
         addChild(_vBox);
         initData();
      }
      
      private function initData() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MineralRewardItem = null;
         _goodsList = goodsList;
         _goodsList.sort(shopControl.mineralShopGoodsSort);
         _loc2_ = 0;
         while(_loc2_ < _goodsList.length)
         {
            _loc1_ = new MineralRewardItem();
            _loc1_.data = _goodsList[_loc2_];
            _vBox.addChild(_loc1_);
            _loc2_++;
         }
         _bg.width = _vBox.width + 20;
         _bg.height = _vBox.height + 20;
         _closeBtn.x = _bg.width - 15;
         _closeBtn.y = -15;
      }
      
      private function get goodsList() : Array
      {
         return shopControl.mineralShopGoods;
      }
      
      private function get shopControl() : ShopControler
      {
         return FrameControllerManager.instance.shopController;
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__closeHandler);
      }
      
      protected function __closeHandler(param1:MouseEvent) : void
      {
         visible = false;
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeHandler);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_closeBtn)
         {
            _closeBtn.dispose();
         }
         _closeBtn = null;
         _goodsList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

