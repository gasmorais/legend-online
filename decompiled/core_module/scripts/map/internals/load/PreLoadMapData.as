package map.internals.load
{
   import map.internals.data.MapInfo;
   
   public class PreLoadMapData
   {
      
      private var _backCall:Function;
      
      protected var _model:MapInfo;
      
      public function PreLoadMapData(param1:MapInfo)
      {
         super();
         _model = param1;
      }
      
      public function syncBackCall(param1:Function) : void
      {
         _backCall = param1;
         loadData();
      }
      
      protected function loadData() : void
      {
      }
      
      protected function backCall() : void
      {
         if(_backCall != null)
         {
            _backCall();
         }
         _backCall = null;
         _model = null;
      }
   }
}

