package buildings.transferbuilding.view.planesbag
{
   import cell.view.bag.BaseBagCell;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   
   public class PlanesBagCell extends BaseBagCell
   {
      
      public static const NAME:String = "buildings.transferbuilding.view.planesbag.";
      
      protected var _mediatorKey:String;
      
      protected var _registed:Boolean;
      
      public function PlanesBagCell()
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
         var _loc1_:Array = [PlanesBagCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"buildings.transferbuilding.view.planesbag.");
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

