package mvc.module.consortia
{
   public class ConsortiaVotingUserInfo
   {
      
      private var _userId:int;
      
      private var _nickName:String;
      
      private var _votingId:int;
      
      private var _isVotingman:Boolean;
      
      private var _votingTime:int;
      
      private var _votingData:int;
      
      public function ConsortiaVotingUserInfo()
      {
         super();
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get nickName() : String
      {
         return _nickName;
      }
      
      public function set nickName(param1:String) : void
      {
         _nickName = param1;
      }
      
      public function get votingId() : int
      {
         return _votingId;
      }
      
      public function set votingId(param1:int) : void
      {
         _votingId = param1;
      }
      
      public function get isVotingman() : Boolean
      {
         return _isVotingman;
      }
      
      public function set isVotingman(param1:Boolean) : void
      {
         _isVotingman = param1;
      }
      
      public function get votingTime() : int
      {
         return _votingTime;
      }
      
      public function set votingTime(param1:int) : void
      {
         _votingTime = param1;
      }
      
      public function get votingData() : int
      {
         return _votingData;
      }
      
      public function set votingData(param1:int) : void
      {
         _votingData = param1;
      }
   }
}

