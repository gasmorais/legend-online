package cell.view.consortiabag
{
   import cell.mediator.consortiabag.ConsortiaPrizeCellClickMediator;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.MediatorMananger;
   import yishi.view.community.BaseItemView;
   
   public class ConsortiaPrizeCell extends BaseItemView
   {
      
      public static const NAME:String = "cell.view.consortiabag.ConsortiaPrizeCell";
      
      private var _mediatorKey:String;
      
      public var _registed:Boolean;
      
      public function ConsortiaPrizeCell()
      {
         super();
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         mouseEnabled = true;
         mouseChildren = true;
         setNormalFilter();
         if(!_registed)
         {
            registerMediator();
         }
      }
      
      private function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [ConsortiaPrizeCellClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"cell.view.consortiabag.ConsortiaPrizeCell");
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
   }
}

