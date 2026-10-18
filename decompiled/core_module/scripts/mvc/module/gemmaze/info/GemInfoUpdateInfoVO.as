package mvc.module.gemmaze.info
{
   public class GemInfoUpdateInfoVO
   {
      
      private var _gemDelArr:Array = [];
      
      private var _gemAddArr:Array = [];
      
      public var rewardInfo:GemRewardInfoVO;
      
      public var scoreAdd:Array;
      
      public var curExp:int;
      
      public var maxExp:int;
      
      public var addIntergal:Array;
      
      public function GemInfoUpdateInfoVO()
      {
         super();
         rewardInfo = new GemRewardInfoVO();
      }
      
      public function get gemAddArr() : Array
      {
         return _gemAddArr;
      }
      
      public function set gemAddArr(param1:Array) : void
      {
         _gemAddArr = param1;
      }
      
      public function get gemDelArr() : Array
      {
         return _gemDelArr;
      }
      
      public function set gemDelArr(param1:Array) : void
      {
         _gemDelArr = param1;
      }
   }
}

