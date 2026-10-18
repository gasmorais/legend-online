package map.campaign.mediator.mapview
{
   import map.campaign.data.WorldBossBuyBuffModel;
   import yishi.interfaces.IMediator;
   
   public class WorldBossBuffMediator implements IMediator
   {
      
      private static var OP_REQUEST_PRICE:int = 1;
      
      private static var OP_CONFIRM_BUY:int = 2;
      
      private var _model:WorldBossBuyBuffModel;
      
      public function WorldBossBuffMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
      }
      
      public function unregister(param1:Object) : void
      {
      }
      
      protected function init() : void
      {
      }
      
      protected function dispose() : void
      {
         _model = null;
      }
   }
}

