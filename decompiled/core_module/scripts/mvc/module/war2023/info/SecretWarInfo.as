package mvc.module.war2023.info
{
   import yishi.utils.DateFormatter;
   
   public class SecretWarInfo
   {
      
      public var gameIsStart:Boolean = false;
      
      public var blueScore:int;
      
      public var bluePlayerCount:int;
      
      public var blueNodeCount:int;
      
      public var redScore:int;
      
      public var redPlayerCount:int;
      
      public var redNodeCount:int;
      
      public var curDate:Date;
      
      private var _curTime:String;
      
      public var preDate:Date;
      
      private var _preTime:String;
      
      public var stopDate:Date;
      
      private var _stopTime:String;
      
      public function SecretWarInfo()
      {
         super();
      }
      
      public function set curTime(param1:String) : void
      {
         _curTime = param1;
         curDate = DateFormatter.parse(_curTime,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function set preTime(param1:String) : void
      {
         if(_preTime == param1)
         {
            return;
         }
         _preTime = param1;
         preDate = DateFormatter.parse(_preTime,"YYYY-MM-DD hh:mm:ss");
      }
      
      public function set stopTime(param1:String) : void
      {
         if(_stopTime == param1)
         {
            return;
         }
         _stopTime = param1;
         stopDate = DateFormatter.parse(_stopTime,"YYYY-MM-DD hh:mm:ss");
      }
   }
}

