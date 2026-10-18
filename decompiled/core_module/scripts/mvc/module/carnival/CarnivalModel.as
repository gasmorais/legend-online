package mvc.module.carnival
{
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class CarnivalModel
   {
      
      public var openFrameTime:Number = 0;
      
      public var score:int;
      
      public var scoreRewardInfo:String;
      
      public var totalCharge:int;
      
      public var lotteryCount:int;
      
      public var dayCharge:int;
      
      public var giftBuyInfo:String;
      
      public var dayOnline:int;
      
      public var onlineDate:String;
      
      public var onlineRewardInfo:String;
      
      public var luckCount:int;
      
      public var luckNum:int;
      
      public var gameInfo:String;
      
      public var result:String;
      
      private var _configActId:int;
      
      private var _taskDic:SimpleDictionary;
      
      public function CarnivalModel()
      {
         super();
         _taskDic = new SimpleDictionary();
         _configActId = TempleteManager.instance.getConfigValue("CarnivalTabControl");
      }
      
      public function get configActId() : int
      {
         return _configActId;
      }
      
      public function getTaskInfo(param1:int) : CarnivalTaskInfo
      {
         return _taskDic[param1];
      }
      
      public function putTaskInfo(param1:CarnivalTaskInfo) : void
      {
         _taskDic.add(param1.taskId,param1);
      }
      
      public function getAllTaskInfo() : Array
      {
         return _taskDic.getList();
      }
   }
}

