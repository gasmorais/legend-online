package managers
{
   import com.road.yishi.proto.box.BoxMsg;
   import events.TimeBoxEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.comm.PackageIn;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.BoxTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   
   public class BoxManager extends EventDispatcher
   {
      
      private static var _instance:BoxManager;
      
      private var _timeBoxList:Array = [];
      
      private var _gradeBoxList:Array = [];
      
      private var _remainTime:int;
      
      public function BoxManager()
      {
         super();
      }
      
      public static function get instance() : BoxManager
      {
         if(_instance == null)
         {
            _instance = new BoxManager();
         }
         return _instance;
      }
      
      public function get gradeBoxList() : Array
      {
         return _gradeBoxList;
      }
      
      public function setup() : void
      {
         initTemplate();
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4,__getHaveTimeBox);
      }
      
      private function __getHaveTimeBox(param1:SLGSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.data as PackageIn;
         var _loc2_:BoxMsg = new BoxMsg();
         _loc2_ = _loc3_.readBody(_loc2_) as BoxMsg;
         playerInfo.timeProgress = _loc2_.time;
         playerInfo.timeGet = _loc2_.operate;
         playerInfo.timeRun = _loc2_.timerun;
         dispatchEvent(new TimeBoxEvent("UPDATE_TIME_BOX"));
      }
      
      private function initTemplate() : void
      {
         var _loc2_:Dictionary = TempleteManager.instance.noviceboxTemplateCate.getTemplates();
         for(var _loc3_:String in _loc2_)
         {
            _gradeBoxList.push(int(_loc3_));
         }
         _gradeBoxList.sort(16);
         var _loc1_:Dictionary = TempleteManager.instance.timeBoxTemplateCate.getTemplates();
         for(_loc3_ in _loc1_)
         {
            _timeBoxList.push(int(_loc3_));
         }
         _timeBoxList.sort(16);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function isRecviedByGrade(param1:int) : Boolean
      {
         var _loc2_:int = PlayerManager.instance.currentPlayerModel.playerInfo.gradeProcess;
         if((_loc2_ >> param1 & 1) == 1)
         {
            return true;
         }
         return false;
      }
      
      public function isCanRecviByGrade(param1:int) : Boolean
      {
         return param1 <= thane.grades;
      }
      
      public function getGradeTempByGrade(param1:int) : BoxTemplateInfo
      {
         return TempleteManager.instance.noviceboxTemplateCate.getTemplatesByGrade(param1)[0] as BoxTemplateInfo;
      }
      
      public function getGradeBoxGoodsByGrade(param1:int) : Vector.<BoxTemplateInfo>
      {
         var _loc4_:Vector.<BoxTemplateInfo> = new Vector.<BoxTemplateInfo>();
         var _loc2_:Array = TempleteManager.instance.noviceboxTemplateCate.getTemplatesByGrade(param1);
         for each(var _loc3_:BoxTemplateInfo in _loc2_)
         {
            if(_loc3_.Job == thane.templateInfo.Job)
            {
               _loc4_.push(_loc3_);
            }
         }
         return _loc4_;
      }
      
      public function get remainTime() : int
      {
         return _remainTime;
      }
      
      public function set remainTime(param1:int) : void
      {
         _remainTime = param1;
         if(_remainTime == 0)
         {
            dispatchEvent(new TimeBoxEvent("TIME_COMPLETE"));
         }
      }
      
      public function getCurrentTimePeriod() : int
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(playerInfo.timeProgress == 0)
         {
            return int(_timeBoxList[0]);
         }
         _loc1_ = 0;
         while(_loc1_ < _timeBoxList.length)
         {
            _loc2_ = int(_timeBoxList[_loc1_]);
            if(_loc2_ == playerInfo.timeProgress)
            {
               if(playerInfo.timeGet)
               {
                  return int(_timeBoxList[_loc1_ + 1]);
               }
               return _loc2_;
            }
            _loc1_++;
         }
         return int(_timeBoxList[0]);
      }
      
      public function get needCountTime() : Boolean
      {
         if(!playerInfo.timeGet)
         {
            return playerInfo.timeProgress <= int(_timeBoxList[_timeBoxList.length - 1]);
         }
         return playerInfo.timeProgress < int(_timeBoxList[_timeBoxList.length - 1]);
      }
      
      public function get timeBoxList() : Array
      {
         return _timeBoxList;
      }
      
      public function get nextTimePeriod() : int
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:int = int(_timeBoxList.length);
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            if(playerInfo.timeProgress == int(_timeBoxList[_loc2_]))
            {
               if(_loc2_ + 1 < _loc1_)
               {
                  return _timeBoxList[_loc2_ + 1];
               }
               return -1;
            }
            _loc2_++;
         }
         return -1;
      }
   }
}

