package mvc.module.war2023.info
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import yishi.utils.SimpleDictionary;
   
   public class SecretWarNodeInfo extends EventDispatcher
   {
      
      public var nodeId:int;
      
      public var x:int;
      
      public var y:int;
      
      public var connects:Array = [];
      
      public var isFigting:Boolean;
      
      public var isDefand:Boolean;
      
      public var isCan:Boolean;
      
      public var state:int = -1;
      
      private var _changeObj:SimpleDictionary = new SimpleDictionary();
      
      private var _bluePlayerList:Array = [];
      
      private var _redPlayerList:Array = [];
      
      private var _allPlayerList:Array = [];
      
      private var _cdTime:int;
      
      private var _cdTimeUID:int;
      
      private var _isPop:Boolean;
      
      private var _type:int;
      
      public function SecretWarNodeInfo()
      {
         super();
      }
      
      public function set isPop(param1:Boolean) : void
      {
         _isPop = param1;
         if(_isPop)
         {
            dispatchEvent(new Event("secretwarPlayScoreEvent"));
            _isPop = false;
         }
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function set type(param1:int) : void
      {
         if(_type == param1)
         {
            return;
         }
         _type = param1;
         dispatchEvent(new Event("secretwarNodeTypeEvent"));
      }
      
      public function updatePlays(param1:SecretwarPlayInfo) : void
      {
         if(param1.camp == 1)
         {
            dealWithData(param1,_bluePlayerList);
         }
         else
         {
            dealWithData(param1,_redPlayerList);
         }
      }
      
      private function dealWithData(param1:SecretwarPlayInfo, param2:Array) : void
      {
         var _loc3_:int = 0;
         if(param1.curNodeId != nodeId)
         {
            _loc3_ = param2.indexOf(param1);
            if(_loc3_ != -1)
            {
               param2.splice(_loc3_,1);
            }
            _loc3_ = _allPlayerList.indexOf(param1);
            if(_loc3_ != -1)
            {
               _allPlayerList.splice(_loc3_,1);
            }
            return;
         }
         switch(param1.state - 1)
         {
            case 0:
            case 2:
               _loc3_ = param2.indexOf(param1);
               if(_loc3_ != -1)
               {
                  param2.splice(_loc3_,1);
               }
               _loc3_ = _allPlayerList.indexOf(param1);
               if(_loc3_ != -1)
               {
                  _allPlayerList.splice(_loc3_,1);
               }
               break;
            case 3:
               if(param1.toNodeId <= 0)
               {
                  _loc3_ = param2.indexOf(param1);
                  if(_loc3_ == -1)
                  {
                     param2.push(param1);
                  }
                  _loc3_ = _allPlayerList.indexOf(param1);
                  if(_loc3_ == -1)
                  {
                     _allPlayerList.push(param1);
                  }
               }
               else
               {
                  _loc3_ = param2.indexOf(param1);
                  if(_loc3_ != -1)
                  {
                     param2.splice(_loc3_,1);
                  }
                  _loc3_ = _allPlayerList.indexOf(param1);
                  if(_loc3_ != -1)
                  {
                     _allPlayerList.splice(_loc3_,1);
                  }
               }
               break;
            default:
               _loc3_ = param2.indexOf(param1);
               if(_loc3_ == -1)
               {
                  param2.push(param1);
               }
               _loc3_ = _allPlayerList.indexOf(param1);
               if(_loc3_ == -1)
               {
                  _allPlayerList.push(param1);
               }
         }
      }
      
      public function get camp() : int
      {
         var _loc1_:int = 0;
         switch(_type - 1)
         {
            case 0:
            case 2:
               _loc1_ = 1;
               break;
            case 1:
            case 3:
               _loc1_ = 2;
         }
         return _loc1_;
      }
      
      public function get bluePlayerList() : Array
      {
         return _bluePlayerList;
      }
      
      public function get redPlayerList() : Array
      {
         return _redPlayerList;
      }
      
      public function get allPlayerList() : Array
      {
         return _allPlayerList;
      }
      
      public function set cdTime(param1:int) : void
      {
         if(_cdTime == param1)
         {
            return;
         }
         _cdTime = param1;
         if(_cdTime <= 0)
         {
            clearInterval(_cdTimeUID);
         }
         else
         {
            clearInterval(_cdTimeUID);
            _cdTimeUID = setInterval(autoUpdateCd,1000);
         }
      }
      
      private function autoUpdateCd() : void
      {
         _cdTime -= 1000;
         if(_cdTime < 0)
         {
            _cdTime = 0;
            clearInterval(_cdTimeUID);
         }
      }
      
      public function get cdTime() : int
      {
         return _cdTime / 1000;
      }
   }
}

