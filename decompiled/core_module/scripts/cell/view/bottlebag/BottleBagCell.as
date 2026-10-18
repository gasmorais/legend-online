package cell.view.bottlebag
{
   import cell.mediator.bottlebag.BottleBagCellClickMediator;
   import cell.view.bag.BaseBagCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class BottleBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "cell.view.bottlebag.BottleBagCell";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      public function BottleBagCell()
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
         _registed = true;
         var _loc1_:Array = [BottleBagCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.bottlebag.BottleBagCell");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      override public function dispose() : void
      {
         unregisterMediator();
         super.dispose();
      }
   }
}

