package auction.view.buy
{
   import auction.view.common.TimeLimitButton;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import mvc.module.auction.CategoryVO;
   
   public class AuctionCategorySubItem extends Sprite
   {
      
      private var _selectedBtn:TimeLimitButton;
      
      private var _arrow:DisplayObject;
      
      private var _data:CategoryVO;
      
      public function AuctionCategorySubItem()
      {
         super();
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("auction.categorySubBtn");
         addChild(_selectedBtn);
         _arrow = ComponentFactory.Instance.creatBitmap("asset.auction.CategorySmallItemArrow");
         addChild(_arrow);
      }
      
      public function setData(param1:CategoryVO) : void
      {
         _data = param1;
         _selectedBtn.setText(param1.MenuName);
      }
      
      public function getData() : CategoryVO
      {
         return _data;
      }
      
      public function get selected() : Boolean
      {
         return _selectedBtn.selected;
      }
      
      public function set selected(param1:Boolean) : void
      {
         _selectedBtn.selected = param1;
      }
      
      override public function get height() : Number
      {
         return 27;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

