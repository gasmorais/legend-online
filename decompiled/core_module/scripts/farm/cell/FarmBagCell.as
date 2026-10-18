package farm.cell
{
   import cell.view.playerbag.PlayerBagCell;
   import yishi.manager.MediatorMananger;
   
   public class FarmBagCell extends PlayerBagCell
   {
      
      public static const NAME:String = "farm.cell.FarmBagCell";
      
      public function FarmBagCell()
      {
         super();
      }
      
      override protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [FarmBagCellClickMediator,FarmBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"farm.cell.FarmBagCell");
      }
   }
}

