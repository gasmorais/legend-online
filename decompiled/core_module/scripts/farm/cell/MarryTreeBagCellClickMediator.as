package farm.cell
{
   import cell.mediator.DoubleClickMediator;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.PlayerManager;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryTreeBagCellClickMediator extends DoubleClickMediator
   {
      
      public function MarryTreeBagCellClickMediator()
      {
         super();
      }
      
      override protected function __mouseDoubleClick(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:GoodsInfo = _cell.data;
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.bagType == 0)
         {
            _loc4_ = MarryManager.instance.model.endPos2;
            _loc3_ = 1;
         }
         else if(_loc2_.bagType == 1)
         {
            if(MarryManager.instance.model.endPos1 > 9)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("cell.mediator.storebag.StoreBagCellClickMediator.command02"));
               return;
            }
            _loc4_ = MarryManager.instance.model.endPos1;
            _loc3_ = 0;
         }
         PlayerManager.instance.moveBagToBag(_loc2_.bagType,_loc2_.objectId,_loc2_.pos,_loc3_,0,_loc4_,1);
      }
   }
}

