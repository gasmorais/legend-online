package mvc.module.faterotary
{
   import flash.utils.Dictionary;
   
   public class FateRotaryModel
   {
      
      public static var index:Array = [1,2,3];
      
      public var raceDic:Dictionary = new Dictionary();
      
      public var rndDic:Dictionary = new Dictionary();
      
      public function FateRotaryModel()
      {
         super();
         rndDic[8] = 45;
         rndDic[6] = 62.99999999999999;
         rndDic[20] = 18;
         rndDic[2] = 144;
         rndDic[4] = 90;
         raceDic[8] = 315;
         raceDic[6] = 252;
         raceDic[20] = 234;
         raceDic[2] = 90;
         raceDic[4] = 0;
      }
   }
}

