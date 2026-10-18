package cell.mediator.bottlebag
{
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.interfaces.IMediator;
   import yishi.manager.ArmyManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class BottleBagCellClickMediator implements IMediator
   {
      
      protected var _cell:BaseItemView;
      
      public function BottleBagCellClickMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _cell = param1 as BaseItemView;
         if(_cell.icon)
         {
            _cell.icon.addEventListener("click",__mouseClickHandler);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_cell && _cell.icon)
         {
            _cell.icon.removeEventListener("click",__mouseClickHandler);
            _cell = null;
         }
      }
      
      private function __mouseClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(!_cell.data)
         {
            return;
         }
         var _loc3_:int = GoodsManager.instance.findEmputyPos();
         if(_loc3_ == -1)
         {
            _loc2_ = LanguageMgr.GetTranslation("cell.mediator.consortiabag.ConsortiaCaseCellClickMediator.command01");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         PlayerManager.instance.moveBagToBag(_cell.bagType,_cell.objectId,_cell.pos,1,0,_loc3_,_cell.data.count);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

