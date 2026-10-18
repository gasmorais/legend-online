package farm.cell
{
   import cell.view.playerbag.PlayerBagCell;
   import yishi.manager.MediatorMananger;
   
   public class MarryTreeBagCell extends PlayerBagCell
   {
      
      public static const NAME:String = "farm.cell.MarryTreeBagCell";
      
      public function MarryTreeBagCell()
      {
         super();
      }
      
      override protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [MarryTreeBagCellClickMediator,MarryTreeBagCellDropMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"farm.cell.MarryTreeBagCell");
      }
   }
}

