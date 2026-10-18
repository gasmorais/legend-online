package auction.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import flash.display.Sprite;
   import yishi.manager.ArmyManager;
   
   public class AuctionTopBar extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _group:SelectedButtonGroup;
      
      private var _buyBtn:SelectedButton;
      
      private var _sellGoodsBtn:SelectedButton;
      
      private var _sellPetBtn:SelectedButton;
      
      private var _recordBtn:SelectedButton;
      
      private var _limitBtn:SelectedButton;
      
      public function AuctionTopBar()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("auction.TopBarBackBMD.MutipleImage");
         addChild(_back);
         _group = new SelectedButtonGroup();
         _buyBtn = addBtn("auction.bar.buyBtn");
         _sellGoodsBtn = addBtn("auction.bar.sellBtn");
         _recordBtn = addBtn("auction.bar.recordBtn");
         _limitBtn = addBtn("auction.bar.limitBtn");
         _limitBtn.enable = false;
         _sellPetBtn = addBtn("auction.bar.sellPetBtn");
         var _loc1_:int = int(ArmyManager.instance.thane.grades);
         if(_loc1_ < 50)
         {
            _sellPetBtn.enable = false;
         }
      }
      
      private function addBtn(param1:String) : SelectedButton
      {
         var _loc2_:SelectedButton = ComponentFactory.Instance.creatComponentByStylename(param1);
         _group.addSelectItem(_loc2_);
         addChild(_loc2_);
         return _loc2_;
      }
      
      public function initIndex() : void
      {
         _group.selectIndex = 0;
      }
      
      public function getBuyBtn() : BaseButton
      {
         return _buyBtn;
      }
      
      public function getSellGoodsBtn() : BaseButton
      {
         return _sellGoodsBtn;
      }
      
      public function getRecordBtn() : BaseButton
      {
         return _recordBtn;
      }
      
      public function getLimitBtn() : BaseButton
      {
         return _limitBtn;
      }
      
      public function getSellPetBtn() : BaseButton
      {
         return _sellPetBtn;
      }
      
      public function getSelectedBtn() : ISelectable
      {
         return _group.getSelectedItem();
      }
      
      public function dispose() : void
      {
         while(numChildren > 0)
         {
            removeChildAt(0);
         }
         _back.dispose();
         _back = null;
         _group.dispose();
         _group = null;
         _buyBtn.dispose();
         _buyBtn = null;
         _sellGoodsBtn.dispose();
         _sellGoodsBtn = null;
         _recordBtn.dispose();
         _recordBtn = null;
         _limitBtn.dispose();
         _limitBtn = null;
      }
   }
}

