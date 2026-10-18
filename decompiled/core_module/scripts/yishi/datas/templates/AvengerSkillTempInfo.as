package yishi.datas.templates
{
   public class AvengerSkillTempInfo
   {
      
      public var Id:int;
      
      public var SkillSonType:int;
      
      public var SkillGrade:int;
      
      public var NeedBodyGrade:int;
      
      public var NeedItem1:int;
      
      public var NeedItemNum1:int;
      
      public var NeedItem2:int;
      
      public var NeedItemNum2:int;
      
      public var NeedItem3:int;
      
      public var NeedItemNum3:int;
      
      public var NeedItem4:int;
      
      public var NeedItemNum4:int;
      
      public var NeedItem5:int;
      
      public var NeedItemNum5:int;
      
      public var NeedItem6:int;
      
      public var NeedItemNum6:int;
      
      public function AvengerSkillTempInfo()
      {
         super();
      }
      
      public function get needItemAry() : Array
      {
         var _loc2_:Array = [];
         var _loc1_:Array = [];
         if(NeedItem1 != 0)
         {
            _loc2_.push(NeedItem1);
            _loc1_.push(NeedItemNum1);
         }
         if(NeedItem2 != 0)
         {
            _loc2_.push(NeedItem2);
            _loc1_.push(NeedItemNum2);
         }
         if(NeedItem3 != 0)
         {
            _loc2_.push(NeedItem3);
            _loc1_.push(NeedItemNum3);
         }
         if(NeedItem4 != 0)
         {
            _loc2_.push(NeedItem4);
            _loc1_.push(NeedItemNum4);
         }
         if(NeedItem5 != 0)
         {
            _loc2_.push(NeedItem5);
            _loc1_.push(NeedItemNum5);
         }
         if(NeedItem6 != 0)
         {
            _loc2_.push(NeedItem6);
            _loc1_.push(NeedItemNum6);
         }
         return [_loc2_,_loc1_];
      }
   }
}

