package yishi.manager
{
   import flash.utils.Dictionary;
   import yishi.datas.CastleViewData;
   
   public class ViewTempDataManager
   {
      
      private static var _instance:ViewTempDataManager;
      
      private var _castleViewdata:CastleViewData = new CastleViewData();
      
      private var _armyChangeInfo:Dictionary = new Dictionary();
      
      private var _battleArmyChangeInfo:Dictionary = new Dictionary();
      
      private var _changeList:Array = [];
      
      public function ViewTempDataManager()
      {
         super();
      }
      
      public static function getInstance() : ViewTempDataManager
      {
         if(!_instance)
         {
            _instance = new ViewTempDataManager();
         }
         return _instance;
      }
      
      public function get castleViewdata() : CastleViewData
      {
         return _castleViewdata;
      }
      
      public function set castleViewdata(param1:CastleViewData) : void
      {
         _castleViewdata = param1;
      }
   }
}

