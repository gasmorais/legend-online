package yishi.datas.templates
{
   import yishi.manager.TempleteManager;
   
   public class RoyaltyBossTempInfo
   {
      
      public var Id:int;
      
      public var Level:int;
      
      public var BossSkill:int;
      
      public var ArmourValue:int;
      
      public var SoulValue:int;
      
      public var Heros:String;
      
      public var HeroIcon:String;
      
      public var Soldiers:String;
      
      public var DropItem:String;
      
      public function RoyaltyBossTempInfo()
      {
         super();
      }
      
      public function getBossName() : String
      {
         var _loc2_:int = 0;
         var _loc3_:GameHeroTempInfo = null;
         var _loc1_:Array = Heros.split(",");
         if(_loc1_.length > 0)
         {
            _loc2_ = int(_loc1_[0]);
            _loc3_ = TempleteManager.instance.gameHeroTemplateCate.getTemplateByID(_loc2_);
            if(_loc3_)
            {
               return _loc3_.TemplateName;
            }
         }
         return "";
      }
   }
}

