package cell.view.fashionbag
{
   import cell.mediator.fashionbag.FashionBagCellClickMediator;
   import cell.mediator.fashionbag.FashionBagCellDropMediator;
   import cell.view.storebag.StoreBagCell;
   import com.pickgliss.ui.text.FilterFrameText;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class FashionBagCell extends StoreBagCell
   {
      
      public static const NAME:String = "cell.view.fashionbag.FashionBagCell";
      
      public var moveType:String;
      
      protected var _sonType:int;
      
      public var unRegister:int;
      
      public function FashionBagCell()
      {
         super();
      }
      
      public function set sonType(param1:int) : void
      {
         _sonType = param1;
      }
      
      public function get sonType() : int
      {
         return _sonType;
      }
      
      public function get countText() : FilterFrameText
      {
         return _itemText;
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(_fashionImage)
         {
            _fashionImage.x = 2;
         }
      }
      
      override protected function registerMediator() : void
      {
         if(unRegister)
         {
            return;
         }
         _registed = true;
         var _loc1_:Array = [FashionBagCellClickMediator,FashionBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.fashionbag.FashionBagCell");
      }
   }
}

