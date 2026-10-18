package yishi.manager
{
   import com.road.yishi.proto.achievementtask.AchievementTaskListMsg;
   import com.road.yishi.proto.achievementtask.AchievementTaskMsg;
   import com.road.yishi.proto.heroroad.HeroRoadInfoMsg;
   import com.road.yishi.proto.heroroad.HeroRoadListMsg;
   import com.road.yishi.proto.player.PlayerOpMsg;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   import mvc.module.heroroad.AchievementTaskInfo;
   import mvc.module.heroroad.HeroRoadInfo;
   import ui.queuebar.QueueBar;
   import yishi.comm.PackageIn;
   import yishi.comm.PackageOut;
   import yishi.datas.templates.AchievementTaskTemplateInfo;
   import yishi.datas.templates.HeroRoadTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketManager;
   import yishi.service.managers.SocketSendManager;
   
   public class HeroRoadManager
   {
      
      private static var _instance:HeroRoadManager;
      
      public static var MASTER_GROW:int = 1;
      
      public static var MASTER_EXPL:int = 2;
      
      public static var MASTER_PETS:int = 3;
      
      public static var MASTER_CHILD:int = 4;
      
      public static var MASTER_OTHER:int = 5;
      
      public static var MASTER_DAY:int = 6;
      
      public static var MASTER_VIP:int = 7;
      
      public static var MASTER_ADVANCED:int = 8;
      
      public static var OP_TAKE_REWARD:int = 1;
      
      public static var OP_BUYS_REWARD:int = 2;
      
      public static var OP_OPEN:int = 1;
      
      public static var OP_REWARD:int = 2;
      
      public static var OP_POP_BUY:int = 3;
      
      public static var OP_BUY:int = 4;
      
      private var _itemCate:Dictionary;
      
      private var _op:int;
      
      private var _heroScore:int;
      
      public var currentPopTemplateId:int;
      
      public var currentLeftSecond:int;
      
      public var intervalTime:int = 0;
      
      private var _taskDictionary:Dictionary;
      
      private var _popTaskArr:Array;
      
      private var _count:int = 0;
      
      public var giftFrameHasOpen:Boolean = false;
      
      public function HeroRoadManager()
      {
         super();
         _itemCate = new Dictionary();
         _taskDictionary = new Dictionary();
         _popTaskArr = [];
      }
      
      public static function get instance() : HeroRoadManager
      {
         if(!_instance)
         {
            _instance = new HeroRoadManager();
         }
         return _instance;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function set count(param1:int) : void
      {
         _count = param1;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.instance.addEventListener("SLGSocketEvent" + 407,__chainBoxHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4288,__achievenmentDataList);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4289,__achievenmentUpdate);
      }
      
      private function __chainBoxHandler(param1:SLGSocketEvent) : void
      {
         var _loc5_:HeroRoadInfoMsg = null;
         var _loc4_:HeroRoadInfo = null;
         var _loc3_:int = 0;
         var _loc6_:PackageIn = param1.data as PackageIn;
         var _loc2_:HeroRoadListMsg = new HeroRoadListMsg();
         _loc2_ = _loc6_.readBody(_loc2_) as HeroRoadListMsg;
         _op = _loc2_.op;
         _heroScore = _loc2_.heroScore;
         _itemCate = new Dictionary();
         _loc3_ = 0;
         while(_loc3_ < _loc2_.roadInfo.length)
         {
            _loc5_ = _loc2_.roadInfo[_loc3_] as HeroRoadInfoMsg;
            _loc4_ = new HeroRoadInfo();
            _loc4_.taskTempId = _loc5_.taskTempId;
            _loc4_.masterType = _loc5_.masterType;
            _loc4_.takeItemsState = _loc5_.takeItemsState;
            _loc4_.buysItemsState = _loc5_.buysItemsState;
            _loc4_.takeNumbers = _loc5_.takeNumbers;
            _loc4_.index = _loc5_.index;
            _itemCate[_loc4_.taskTempId] = _loc4_;
            _loc3_++;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HEROROAD_UPDATE_VIEW"));
      }
      
      private function __achievenmentDataList(param1:SLGSocketEvent) : void
      {
         var _loc7_:AchievementTaskMsg = null;
         var _loc6_:AchievementTaskInfo = null;
         var _loc3_:AchievementTaskTemplateInfo = null;
         var _loc4_:int = 0;
         var _loc9_:AchievementTaskInfo = null;
         var _loc5_:int = 0;
         var _loc8_:PackageIn = param1.data as PackageIn;
         var _loc2_:AchievementTaskListMsg = new AchievementTaskListMsg();
         _loc2_ = _loc8_.readBody(_loc2_) as AchievementTaskListMsg;
         if(_loc2_.tasks.length > 0)
         {
            _popTaskArr = [];
            _taskDictionary = new Dictionary();
            _loc4_ = 0;
            while(_loc4_ < _loc2_.tasks.length)
            {
               _loc7_ = _loc2_.tasks[_loc4_] as AchievementTaskMsg;
               _loc6_ = new AchievementTaskInfo();
               _loc6_.templateId = _loc7_.templateId;
               _loc6_.data = _loc7_.data;
               _loc6_.isCompleted = _loc7_.isCompleted;
               _loc6_.isPopout = _loc7_.isPopout;
               _loc6_.isReward = _loc7_.isReward;
               _loc3_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_loc7_.templateId);
               if(_loc3_)
               {
                  _loc3_.sort = setSort(_loc6_);
               }
               if(_loc6_.isPopout && _loc6_.isCompleted)
               {
                  _popTaskArr.push(_loc6_);
               }
               _taskDictionary[_loc6_.templateId] = _loc6_;
               _loc4_++;
            }
            _popTaskArr.sortOn("templateId",16);
         }
         if(_loc2_.templateId > 0)
         {
            _loc9_ = _taskDictionary[_loc2_.templateId];
            _loc5_ = _popTaskArr.indexOf(_loc9_);
            _popTaskArr.splice(_loc5_,1);
            _popTaskArr.unshift(_loc9_);
            currentPopTemplateId = _loc2_.templateId;
            currentLeftSecond = _loc2_.leftSecond;
            QueueBar.instance.initHeroRoadBtn();
            QueueBar.instance.setCountTime(_loc2_.leftSecond);
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("HEROROAD_ACHIEVEMENT_LIST_UPDATE"));
      }
      
      private function __achievenmentUpdate(param1:SLGSocketEvent) : void
      {
         var _loc6_:AchievementTaskInfo = null;
         var _loc3_:AchievementTaskTemplateInfo = null;
         var _loc8_:AchievementTaskInfo = null;
         var _loc4_:int = 0;
         var _loc5_:String = null;
         var _loc7_:PackageIn = param1.data as PackageIn;
         var _loc2_:AchievementTaskMsg = new AchievementTaskMsg();
         _loc2_ = _loc7_.readBody(_loc2_) as AchievementTaskMsg;
         if(_loc2_)
         {
            _loc6_ = _taskDictionary[_loc2_.templateId];
            if(!_loc6_)
            {
               _loc6_ = new AchievementTaskInfo();
               _loc6_.templateId = _loc2_.templateId;
               _loc6_.data = _loc2_.data;
               _loc6_.isCompleted = _loc2_.isCompleted;
               _loc6_.isPopout = _loc2_.isPopout;
               _loc6_.isReward = _loc2_.isReward;
               _loc3_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_loc2_.templateId);
               if(_loc3_)
               {
                  _loc3_.sort = setSort(_loc6_);
               }
               _taskDictionary[_loc6_.templateId] = _loc6_;
               if(_loc6_.isPopout && _loc6_.isCompleted)
               {
                  _popTaskArr.push(_loc6_);
               }
            }
            else
            {
               _loc6_.data = _loc2_.data;
               _loc6_.isCompleted = _loc2_.isCompleted;
               _loc6_.isPopout = _loc2_.isPopout;
               _loc6_.isReward = _loc2_.isReward;
               _loc3_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_loc2_.templateId);
               if(_loc3_)
               {
                  _loc3_.sort = setSort(_loc6_);
               }
               _taskDictionary[_loc6_.templateId] = _loc6_;
               if(_loc6_.isPopout && _loc6_.isCompleted && _popTaskArr.indexOf(_loc6_) == -1)
               {
                  _popTaskArr.push(_loc6_);
               }
            }
            _popTaskArr.sortOn("templateId",16);
            if(currentPopTemplateId > 0)
            {
               _loc8_ = _taskDictionary[currentPopTemplateId];
               _loc4_ = _popTaskArr.indexOf(_loc8_);
               _popTaskArr.splice(_loc4_,1);
               _popTaskArr.unshift(_loc8_);
            }
            _loc5_ = SceneManager.instance.currentType;
            if(popTaskInfo && HeroRoadManager.instance.count == 0 && (_loc5_ == "SPACE_SCENE" || _loc5_ == "CASTLE_SCENE"))
            {
               FrameControllerManager.instance.openControllerByInfo("heroroad",2,popTaskInfo);
               HeroRoadManager.instance.count++;
            }
            NotificationManager.instance.dispatchEvent(new NotificationEvent("HEROROAD_ACHIEVEMENT_ITEM_UPDATE"));
         }
      }
      
      private function setSort(param1:AchievementTaskInfo) : int
      {
         var _loc2_:int = 0;
         if(param1.isCompleted && !param1.isReward)
         {
            _loc2_ = 1;
         }
         else if(!param1.isCompleted)
         {
            _loc2_ = 2;
         }
         else if(param1.isCompleted && param1.isReward)
         {
            _loc2_ = 3;
         }
         return _loc2_;
      }
      
      public function get itemCate() : Dictionary
      {
         return _itemCate;
      }
      
      public function get op() : int
      {
         return _op;
      }
      
      public function get popTaskArr() : Array
      {
         return _popTaskArr;
      }
      
      public function get popTaskInfo() : AchievementTaskInfo
      {
         var _loc1_:AchievementTaskInfo = _popTaskArr[0];
         if(_loc1_ && _loc1_.isPopout && _loc1_.isCompleted)
         {
            return _loc1_;
         }
         return null;
      }
      
      public function get heroScore() : int
      {
         return _heroScore;
      }
      
      public function getItemsByMasterType(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:HeroRoadInfo in _itemCate)
         {
            if(_loc3_.masterType == param1)
            {
               _loc2_.push(_loc3_);
            }
         }
         _loc2_.sortOn(["index"],[16]);
         return _loc2_;
      }
      
      public function getMinLevelByMasterType(param1:int) : int
      {
         var _loc2_:int = 5000;
         var _loc4_:Dictionary = TempleteManager.instance.heroRoadTemplateCate.getTemplates();
         for each(var _loc3_:HeroRoadTemplateInfo in _loc4_)
         {
            if(_loc3_.MasterType == param1 && _loc3_.OpenGrades < _loc2_)
            {
               _loc2_ = _loc3_.OpenGrades;
            }
         }
         return _loc2_;
      }
      
      public function hasTaskData(param1:int) : Boolean
      {
         var _loc3_:Dictionary = TempleteManager.instance.heroRoadTemplateCate.getTemplates();
         for each(var _loc2_:HeroRoadTemplateInfo in _loc3_)
         {
            if(_loc2_.MasterType == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      public function getItemById(param1:int) : HeroRoadInfo
      {
         for each(var _loc2_:HeroRoadInfo in _itemCate)
         {
            if(_loc2_.taskTempId == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      public function getAllScore() : int
      {
         var _loc3_:int = 0;
         var _loc2_:Dictionary = TempleteManager.instance.heroRoadTemplateCate.getTemplates();
         for each(var _loc1_:HeroRoadTemplateInfo in _loc2_)
         {
            _loc3_ += _loc1_.HeroRoadScore;
         }
         return _loc3_;
      }
      
      public function operateHandler(param1:int, param2:int) : void
      {
         var _loc4_:PackageOut = new PackageOut(9634);
         var _loc3_:HeroRoadListMsg = new HeroRoadListMsg();
         _loc3_.op = param1;
         _loc3_.taskTempId = param2;
         SocketSendManager.instance.sendProtoBuffer(_loc4_,_loc3_);
      }
      
      public function achivementOpenFrame() : void
      {
         var _loc2_:PackageOut = new PackageOut(8671);
         var _loc1_:PlayerOpMsg = new PlayerOpMsg();
         _loc1_.op = OP_OPEN;
         SocketSendManager.instance.sendProtoBuffer(_loc2_,_loc1_);
      }
      
      public function achivementGetReward(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8671);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_REWARD;
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function buyPackage(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8671);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_BUY;
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
         intervalTime = getTimer();
      }
      
      public function popBuyFrame(param1:int) : void
      {
         var _loc3_:PackageOut = new PackageOut(8671);
         var _loc2_:PlayerOpMsg = new PlayerOpMsg();
         _loc2_.op = OP_POP_BUY;
         _loc2_.templateId = param1;
         SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
      }
      
      public function get taskDictionary() : Dictionary
      {
         return _taskDictionary;
      }
      
      public function getAllAchievemtnItems() : Array
      {
         var _loc2_:AchievementTaskTemplateInfo = null;
         var _loc1_:Array = [];
         var _loc4_:Array = [];
         var _loc3_:Array = [];
         var _loc5_:Array = [];
         for each(var _loc6_:AchievementTaskInfo in _taskDictionary)
         {
            if(_loc6_)
            {
               _loc2_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_loc6_.templateId);
               if(_loc2_ && _loc2_)
               {
                  if(_loc2_.sort == 1)
                  {
                     _loc4_.push(_loc6_);
                  }
                  else if(_loc2_.sort == 2)
                  {
                     _loc3_.push(_loc6_);
                  }
                  else if(_loc2_.sort == 3)
                  {
                     _loc5_.push(_loc6_);
                  }
               }
            }
         }
         _loc4_.sortOn("templateId",16);
         _loc3_.sortOn("templateId",16);
         _loc5_.sortOn("templateId",16);
         return _loc4_.concat(_loc3_).concat(_loc5_);
      }
      
      public function getAchievemtnItemsByClassify(param1:int) : Array
      {
         var _loc3_:AchievementTaskTemplateInfo = null;
         var _loc2_:Array = [];
         var _loc5_:Array = [];
         var _loc4_:Array = [];
         var _loc6_:Array = [];
         for each(var _loc7_:AchievementTaskInfo in _taskDictionary)
         {
            if(_loc7_)
            {
               _loc3_ = TempleteManager.instance.achievementTaskTemplateCate.getTemplateByID(_loc7_.templateId);
               if(_loc3_ && _loc3_.Classify == param1)
               {
                  if(_loc3_.sort == 1)
                  {
                     _loc5_.push(_loc7_);
                  }
                  else if(_loc3_.sort == 2)
                  {
                     _loc4_.push(_loc7_);
                  }
                  else if(_loc3_.sort == 3)
                  {
                     _loc6_.push(_loc7_);
                  }
               }
            }
         }
         _loc5_.sortOn("templateId",16);
         _loc4_.sortOn("templateId",16);
         _loc6_.sortOn("templateId",16);
         return _loc5_.concat(_loc4_).concat(_loc6_);
      }
   }
}

