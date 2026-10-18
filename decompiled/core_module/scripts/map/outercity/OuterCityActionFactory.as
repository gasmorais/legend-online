package map.outercity
{
   import map.outercity.manager.OuterCityManager;
   import yishi.actions.map.collection.CollectionAction;
   import yishi.comm.PackageIn;
   import yishi.manager.GameBaseQueueManager;
   
   public class OuterCityActionFactory
   {
      
      public function OuterCityActionFactory()
      {
         super();
      }
      
      public static function createAction(param1:String, param2:Object, param3:PackageIn, param4:int = 75, param5:int = 0) : void
      {
         param3.position = 20;
         var _loc6_:String = param1;
         if("COLLECTION" === _loc6_)
         {
            if(OuterCityManager.instance.model.onCollectionId == 0)
            {
               GameBaseQueueManager.instance.addAction(new CollectionAction(param2,param5));
            }
         }
      }
   }
}

