package mvc.module.fundVein
{
   import yishi.manager.ArmyManager;
   
   public class GradeRewardInfo
   {
      
      public var needGrade:int;
      
      public var isTaked:Boolean;
      
      public var itemInfo:Array = [];
      
      public var index:int;
      
      public var isParentLevelBuy:Boolean;
      
      public var times:int = 0;
      
      public function GradeRewardInfo()
      {
         super();
      }
      
      public function get interval() : int
      {
         return needGrade;
      }
      
      public function get isGained() : Boolean
      {
         if(!isParentLevelBuy)
         {
            return false;
         }
         if(isTaked)
         {
            return false;
         }
         if(ArmyManager.instance.thane.grades < needGrade)
         {
            return false;
         }
         return true;
      }
      
      public function get sortValue() : int
      {
         if(isGained)
         {
            return 0;
         }
         if(isTaked)
         {
            return 2;
         }
         return 1;
      }
      
      public function clear() : void
      {
         itemInfo.length = 0;
         itemInfo = null;
      }
   }
}

