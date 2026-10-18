package armyII.viewII.allocate
{
   import com.pickgliss.events.InteractiveEvent;
   import mvc.controler.ArmyControler;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.GameDrag;
   import yishi.view.community.PawnContain;
   
   public class SoldierDragCell extends PawnContain
   {
      
      public var site:int;
      
      public function SoldierDragCell()
      {
         super();
         dragEnable = true;
      }
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void
      {
         if(pawn && pawn.ownPawns > 0)
         {
            freePawn(this);
         }
      }
      
      override protected function onDragStop(param1:GameDrag) : void
      {
         var _loc2_:PawnContain = null;
         var _loc3_:PawnContain = null;
         if(param1.dropTarget != this && _pawn)
         {
            if(param1.dropTarget is PawnContain)
            {
               _loc2_ = param1.target as PawnContain;
               _loc3_ = param1.dropTarget as PawnContain;
               if(_loc3_.isLock)
               {
                  __iTEM_DROP_BagNotic();
                  return;
               }
               if(param1.dropTarget is PawnDragCell)
               {
                  freePawn(_loc2_);
               }
            }
            else
            {
               param1.stopImmediatePropagation();
            }
         }
         __iTEM_DROP_BagNotic();
      }
      
      protected function freePawn(param1:PawnContain) : void
      {
         var _loc2_:int = int(param1.pawn.ownPawns);
         ArmyManager.instance.army.removeArmyPawnCountByIndex(site,_loc2_);
         ArmyManager.instance.addPawnCountById(param1.pawn.templateId,_loc2_);
         control.sendMovePawnInfo();
      }
      
      private function get control() : ArmyControler
      {
         return FrameControllerManager.instance.armyController;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

