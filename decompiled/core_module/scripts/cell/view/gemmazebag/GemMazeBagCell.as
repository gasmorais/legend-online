package cell.view.gemmazebag
{
   import cell.view.bag.BaseBagCell;
   import yishi.datas.goods.GoodsInfo;
   
   public class GemMazeBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "cell.view.bottlebag.BottleBagCell";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      public function GemMazeBagCell()
      {
         super();
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         if(data != param1)
         {
            setNormalFilter();
         }
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      protected function registerMediator() : void
      {
      }
      
      protected function unregisterMediator() : void
      {
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         super.dispose();
      }
   }
}

