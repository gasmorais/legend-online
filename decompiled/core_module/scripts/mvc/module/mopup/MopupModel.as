package mvc.module.mopup
{
   import events.MopupEvent;
   import flash.events.EventDispatcher;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.SimpleDictionary;
   
   public class MopupModel extends EventDispatcher
   {
      
      protected static const MOPUP_LIST_REFRESH:String = "MOPUP_LIST_REFRESH";
      
      protected static const MOPUP_END:String = "MOPUP_END";
      
      private var _campaignId:int;
      
      private var _mopupCount:int;
      
      private var _mopupLayer:int;
      
      private var _isMopup:Boolean;
      
      private var _resultInfoList:Array;
      
      private var _mopupTime:int;
      
      private var _mopupRemainTime:int;
      
      private var _mopupPayGold:int;
      
      private var _mopupExt:int;
      
      private var _mopupEnd:Boolean;
      
      private var _isNormalEnd:Boolean = true;
      
      private var _isDoubleProfit:int = 1;
      
      private var _mopupGoods:Array;
      
      protected var _changeObj:SimpleDictionary;
      
      public function MopupModel()
      {
         super();
         _changeObj = new SimpleDictionary();
      }
      
      public function beginChanges() : void
      {
         _changeObj.clear();
      }
      
      public function set campaignId(param1:int) : void
      {
         _campaignId = param1;
      }
      
      public function get campaignId() : int
      {
         return _campaignId;
      }
      
      public function set mopupCount(param1:int) : void
      {
         _mopupCount = param1;
      }
      
      public function get mopupCount() : int
      {
         return _mopupCount;
      }
      
      public function set mopupLayer(param1:int) : void
      {
         _mopupLayer = param1;
      }
      
      public function get mopupLayer() : int
      {
         return _mopupLayer;
      }
      
      public function set resultInfoList(param1:Array) : void
      {
         _resultInfoList = param1;
         _changeObj["MOPUP_LIST_REFRESH"] = true;
      }
      
      public function get resultInfoList() : Array
      {
         return _resultInfoList;
      }
      
      public function set mopupExt(param1:int) : void
      {
         _mopupExt = param1;
      }
      
      public function get mopupExt() : int
      {
         return _mopupExt;
      }
      
      public function set mopupEnd(param1:Boolean) : void
      {
         _mopupEnd = param1;
         _changeObj["MOPUP_END"] = param1;
      }
      
      public function get mopupEnd() : Boolean
      {
         return _mopupEnd;
      }
      
      public function get isNormalEnd() : Boolean
      {
         return _isNormalEnd;
      }
      
      public function set isNormalEnd(param1:Boolean) : void
      {
         _isNormalEnd = param1;
      }
      
      public function set mopupRemainTime(param1:int) : void
      {
         _mopupRemainTime = param1;
      }
      
      public function get mopupRemainTime() : int
      {
         return _mopupRemainTime;
      }
      
      public function set isDoubleProfit(param1:int) : void
      {
         _isDoubleProfit = param1;
      }
      
      public function get isDoubleProfit() : int
      {
         return _isDoubleProfit;
      }
      
      public function set isMopup(param1:Boolean) : void
      {
         _isMopup = param1;
         if(_isMopup)
         {
            if(FrameControllerManager.instance.dayGuideController.frame)
            {
               FrameControllerManager.instance.dayGuideController.frame.dispose();
            }
            NotificationManager.instance.sendNotification("LOCK_TEAM_FOLLOW_TARGET",null);
         }
      }
      
      public function get isMopup() : Boolean
      {
         return _isMopup;
      }
      
      public function set mopupGoods(param1:Array) : void
      {
         _mopupGoods = param1;
      }
      
      public function get mopupGoods() : Array
      {
         return _mopupGoods;
      }
      
      public function commit() : void
      {
         if(_changeObj["MOPUP_LIST_REFRESH"])
         {
            dispatchEvent(new MopupEvent("MOPUP_RESULT_LIST_REFRESH"));
         }
         if(_changeObj["MOPUP_END"] && _mopupEnd)
         {
            dispatchEvent(new MopupEvent("MOPUP_END"));
         }
      }
   }
}

