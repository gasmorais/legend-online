package mvc.module.supersignincard
{
   import com.road.yishi.proto.active.SuperSigninDetailMsg;
   import com.road.yishi.proto.active.SuperSigninTempMsg;
   import yishi.utils.SimpleDictionary;
   
   public class SuperSigninCardModel
   {
      
      public var isOpen:Boolean;
      
      public var openTime:String;
      
      public var stopTime:String;
      
      public var tempDic:SimpleDictionary;
      
      public var stateDic:SimpleDictionary;
      
      public var cardPrice:int;
      
      public var reSigninPrice:int;
      
      public function SuperSigninCardModel()
      {
         super();
         tempDic = new SimpleDictionary();
         stateDic = new SimpleDictionary();
      }
      
      public function refreshTempData(param1:Array) : void
      {
         for each(var _loc2_:SuperSigninTempMsg in param1)
         {
            tempDic.add(_loc2_.date,_loc2_.itemMsg);
         }
      }
      
      public function refreshState(param1:Array) : void
      {
         for each(var _loc2_:SuperSigninDetailMsg in param1)
         {
            stateDic.add(_loc2_.date,_loc2_.state);
         }
      }
   }
}

