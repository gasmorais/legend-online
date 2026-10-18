package farm.data
{
   import farm.event.FarmEvent;
   import flash.events.EventDispatcher;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.PetTemplate;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.DateFormatter;
   
   public class PetLandInfo extends EventDispatcher
   {
      
      public var userId:int = 0;
      
      public var petId:int = 0;
      
      public var name:String = "";
      
      private var _quality:int = 1;
      
      private var _petTemplateId:int = 0;
      
      public var petTemplate:PetTemplate;
      
      public var pos:int = 0;
      
      public var beginTime:String;
      
      public var endTime:String;
      
      public var lastFeedRegion:int = 0;
      
      public function PetLandInfo()
      {
         super();
      }
      
      public function get quality() : int
      {
         return _quality;
      }
      
      public function set quality(param1:int) : void
      {
         if(param1 < 1)
         {
            return;
         }
         _quality = param1;
      }
      
      public function get petTemplateId() : int
      {
         return _petTemplateId;
      }
      
      public function set petTemplateId(param1:int) : void
      {
         if(_petTemplateId == param1)
         {
            return;
         }
         _petTemplateId = param1;
         petTemplate = TempleteManager.instance.petTemplateCate.getTemplateById(param1);
      }
      
      public function commit() : void
      {
         dispatchEvent(new FarmEvent("PET_LAND_UPDATE",this));
      }
      
      public function canFeed() : Boolean
      {
         if(petId <= 0)
         {
            return false;
         }
         if(lastFeedRegion >= 5)
         {
            return false;
         }
         if(!beginTime || !endTime)
         {
            return false;
         }
         if(canGains())
         {
            return false;
         }
         var _loc2_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc1_:Date = DateFormatter.parse(beginTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Date = DateFormatter.parse(endTime,"YYYY-MM-DD hh:mm:ss");
         var _loc5_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc6_:Number = (_loc3_.time - _loc1_.time) / 10;
         var _loc4_:int = Math.floor((_loc5_.time - _loc1_.time) / _loc6_);
         return _loc4_ > lastFeedRegion;
      }
      
      public function canGains() : Boolean
      {
         if(petId <= 0)
         {
            return false;
         }
         if(!beginTime || !endTime)
         {
            return false;
         }
         var _loc2_:Date = DateFormatter.parse(endTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc1_:String = DateFormatter.format(_loc3_,"YYYY-MM-DD hh:mm:ss");
         return _loc3_.time >= _loc2_.time;
      }
      
      public function get remainMatureMinutes() : int
      {
         return totalMatureMinutes - growMinutes;
      }
      
      public function get growMinutes() : int
      {
         var _loc1_:Date = DateFormatter.parse(beginTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Date = PlayerManager.instance.currentPlayerModel.sysCurtime;
         var _loc2_:int = Math.floor((_loc3_.time - _loc1_.time) / 60000);
         if(_loc2_ < 0)
         {
            _loc2_ = 0;
         }
         return _loc2_;
      }
      
      public function get totalMatureMinutes() : int
      {
         var _loc3_:Date = DateFormatter.parse(endTime,"YYYY-MM-DD hh:mm:ss");
         var _loc1_:Date = DateFormatter.parse(beginTime,"YYYY-MM-DD hh:mm:ss");
         return int(Math.ceil((_loc3_.time - _loc1_.time) / 60000));
      }
      
      public function get isSelfLand() : Boolean
      {
         return userId == thane.userId;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

