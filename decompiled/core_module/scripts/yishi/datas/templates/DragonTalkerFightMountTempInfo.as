package yishi.datas.templates
{
   public class DragonTalkerFightMountTempInfo
   {
      
      public var Grade:int;
      
      public var Power:int;
      
      public var Agility:int;
      
      public var Intellect:int;
      
      public var Physique:int;
      
      public var HitPoint:int;
      
      public var MountTempId:int;
      
      public var TemplateName:String;
      
      public var AvatarPath:String;
      
      public var Description:String;
      
      public function DragonTalkerFightMountTempInfo()
      {
         super();
      }
      
      public function get hasValueAtt() : Array
      {
         var _loc1_:Array = [];
         if(Power != 0)
         {
            _loc1_.push("Power");
         }
         if(Agility != 0)
         {
            _loc1_.push("Agility");
         }
         if(Intellect != 0)
         {
            _loc1_.push("Intellect");
         }
         if(Physique != 0)
         {
            _loc1_.push("Physique");
         }
         return _loc1_;
      }
   }
}

