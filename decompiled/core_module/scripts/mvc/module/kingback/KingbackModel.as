package mvc.module.kingback
{
   import flash.utils.Dictionary;
   
   public class KingbackModel
   {
      
      public static const TYPE_DAY:int = 1;
      
      public static const TYPE_SCORE:int = 2;
      
      public static const TYPE_GIFT:int = 3;
      
      public static const TYPE_PetHallows:int = 4;
      
      public static const TYPE_Artifact:int = 5;
      
      public static const TYPE_GODDESS:int = 6;
      
      public static const TYPE_PET:int = 7;
      
      public static const TYPE_HERO:int = 8;
      
      public var openTime:Number;
      
      public var endTime:Number;
      
      public var chargeTotalCount:int;
      
      public var activeItems:Dictionary;
      
      public function KingbackModel()
      {
         super();
         activeItems = new Dictionary(true);
      }
      
      public function getInfoListByType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:KingbackInfo in activeItems)
         {
            if(_loc3_.tempInfo && _loc3_.tempInfo.Type == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn("templateId",16);
         return _loc2_;
      }
      
      public function getTypes() : Array
      {
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         for each(var _loc3_:KingbackInfo in activeItems)
         {
            if(_loc3_.tempInfo)
            {
               _loc2_ = _loc3_.tempInfo.Type;
               if(_loc1_.indexOf(_loc2_) == -1)
               {
                  _loc1_.push(_loc2_);
               }
            }
         }
         _loc1_.sort(16);
         return _loc1_;
      }
   }
}

