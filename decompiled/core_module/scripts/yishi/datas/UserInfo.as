package yishi.datas
{
   import com.pickgliss.utils.MD5;
   
   public class UserInfo
   {
      
      private var _user:String;
      
      public var site:String;
      
      private var _serverName:String;
      
      private var _userId:int;
      
      private var _tempPassword:String;
      
      private var _password:String;
      
      private var _isActive:Boolean;
      
      private var _noviceProcess:int;
      
      private var _key:String;
      
      public function UserInfo()
      {
         super();
      }
      
      public function get user() : String
      {
         return _user;
      }
      
      public function set user(param1:String) : void
      {
         _user = param1;
      }
      
      public function get userId() : int
      {
         return _userId;
      }
      
      public function set userId(param1:int) : void
      {
         _userId = param1;
      }
      
      public function get tempPassword() : String
      {
         return _tempPassword;
      }
      
      public function set tempPassword(param1:String) : void
      {
         _tempPassword = param1;
         _key = MD5.hash(_tempPassword);
      }
      
      public function get password() : String
      {
         return _password;
      }
      
      public function set password(param1:String) : void
      {
         _password = param1;
      }
      
      public function get isActive() : Boolean
      {
         return _isActive;
      }
      
      public function set isActive(param1:Boolean) : void
      {
         _isActive = param1;
      }
      
      public function get noviceProcess() : int
      {
         return _noviceProcess;
      }
      
      public function set noviceProcess(param1:int) : void
      {
         _noviceProcess = param1;
      }
      
      public function get key() : String
      {
         return _key;
      }
      
      public function get serverName() : String
      {
         return _serverName;
      }
      
      public function set serverName(param1:String) : void
      {
         _serverName = param1;
      }
   }
}

