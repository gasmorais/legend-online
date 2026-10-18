package yishi.manager
{
   import flash.events.Event;
   import flash.geom.Point;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import flash.utils.Dictionary;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.SpaceMapNodeInfoTemplate;
   
   public class SpaceTemplateManager
   {
      
      private static var _instance:SpaceTemplateManager;
      
      private var _setupFlag:Boolean = false;
      
      private var _index:int = 0;
      
      private var _robotInited:Boolean = false;
      
      private var _robots:Array;
      
      private var _nodeDic:Dictionary;
      
      private var _robotDic:Dictionary;
      
      private var _robotArmysDic:Dictionary;
      
      private var _robotPositions:Array;
      
      public function SpaceTemplateManager()
      {
         super();
         _robots = [];
         _nodeDic = new Dictionary();
         _robotDic = new Dictionary();
         _robotArmysDic = new Dictionary();
         _robotPositions = [];
         initRobotPositions();
      }
      
      public static function get instance() : SpaceTemplateManager
      {
         if(!_instance)
         {
            _instance = new SpaceTemplateManager();
         }
         return _instance;
      }
      
      private function initRobotPositions() : void
      {
         _robotPositions.push(new Point(140,118));
         _robotPositions.push(new Point(141,119));
         _robotPositions.push(new Point(142,120));
         _robotPositions.push(new Point(143,119));
         _robotPositions.push(new Point(144,118));
         _robotPositions.push(new Point(145,117));
         _robotPositions.push(new Point(146,116));
         _robotPositions.push(new Point(147,115));
         _robotPositions.push(new Point(150,112));
         _robotPositions.push(new Point(106,90));
         _robotPositions.push(new Point(107,91));
         _robotPositions.push(new Point(108,92));
         _robotPositions.push(new Point(109,91));
         _robotPositions.push(new Point(110,90));
         _robotPositions.push(new Point(87,102));
         _robotPositions.push(new Point(88,101));
         _robotPositions.push(new Point(89,98));
         _robotPositions.push(new Point(89,100));
         _robotPositions.push(new Point(90,99));
      }
      
      public function setup() : void
      {
         var _loc5_:Array = null;
         if(_setupFlag)
         {
            return;
         }
         _setupFlag = true;
         var _loc6_:Dictionary = TempleteManager.instance.getAllSpaceTemplateDic();
         for each(var _loc2_:SpaceMapNodeInfoTemplate in _loc6_)
         {
            _loc5_ = _nodeDic[_loc2_.MapId] as Array;
            if(!_loc5_)
            {
               _loc5_ = [];
               _nodeDic[_loc2_.MapId] = _loc5_;
            }
            _loc5_.push(SpaceManager.instance.readSpaceNodeInfo(_loc2_));
         }
         var _loc4_:String = PathManager.orderPath + "skycastlerobot_unzip.xml";
         var _loc3_:URLLoader = new URLLoader();
         _loc3_.dataFormat = "text";
         _loc3_.addEventListener("complete",__configLoadCompleteHandler);
         _loc3_.addEventListener("ioError",__configLoadCompleteHandler);
         var _loc1_:URLRequest = new URLRequest(_loc4_);
         _loc1_.method = "POST";
         _loc3_.load(_loc1_);
      }
      
      private function __configLoadCompleteHandler(param1:Event) : void
      {
         var _loc3_:XML = null;
         var _loc4_:XMLList = null;
         var _loc2_:String = null;
         var _loc6_:URLLoader = param1.currentTarget as URLLoader;
         _loc6_.removeEventListener("complete",__configLoadCompleteHandler);
         _loc6_.removeEventListener("ioError",__configLoadCompleteHandler);
         try
         {
            _loc2_ = _loc6_.data as String;
            if(_loc2_)
            {
               _loc3_ = new XML(_loc2_);
               _loc4_ = _loc3_..Robot;
               for each(var _loc5_:XML in _loc4_)
               {
                  createRobot(_loc5_);
               }
               _robotInited = true;
            }
         }
         catch(errObject:Error)
         {
         }
      }
      
      public function getRobotInfo(param1:int) : ThaneInfo
      {
         if(_robotDic[param1])
         {
            return _robotDic[param1];
         }
         return null;
      }
      
      public function getRobotArmyInfoByUserId(param1:int) : SpaceArmy
      {
         if(_robotArmysDic[param1])
         {
            return _robotArmysDic[param1];
         }
         return null;
      }
      
      private function createRobot(param1:XML) : void
      {
         var _loc2_:SpaceArmy = new SpaceArmy();
         var _loc4_:ThaneInfo = _loc2_.baseHero;
         _loc4_.beginChanges();
         _loc4_.id = int(param1.@HeroId);
         _loc4_.userId = int(param1.@UserId);
         _loc4_.IsVipAndNoExpirt = int(param1.@IsVipAndNoExpirt) == 1 ? true : false;
         _loc4_.grades = int(param1.@Grades);
         _loc4_.nickName = decodeURIComponent(String(param1.@NikcName));
         _loc4_.templateId = int(param1.@TemplateId);
         _loc4_.headId = int(param1.@HeadId);
         _loc4_.armsEquipAvata = String(param1.@ArmsEquipAvata);
         _loc4_.bodyEquipAvata = String(param1.@BodyEquipAvata);
         _loc4_.wingAvata = String(param1.@WingAvata);
         _loc4_.hairFashionAvata = String(param1.@HairFashionAvata);
         _loc4_.armsFashionAvata = String(param1.@ArmsFashionAvata);
         _loc4_.bodyFashionAvata = String(param1.@BodyFashionAvata);
         _loc4_.hideFashion = String(param1.@IsHideFashion) == "true" ? true : false;
         _loc4_.appellId = int(param1.@AppellId);
         _loc4_.fateSkill = String(param1.@FateSkill);
         _loc2_.petInfo.petTemplateId = int(param1.@PetTemplateId);
         _loc4_.consortiaID = int(param1.@ConsortiaID);
         _loc4_.consortiaName = String(param1.@ConsortiaName);
         _loc4_.state = 7;
         _loc2_.id = int(param1.@HeroId);
         _loc2_.userId = int(param1.@UserId);
         _loc2_.nickName = decodeURIComponent(String(param1.@NikcName));
         _loc2_.mountTemplateId = int(param1.@MountTemplateId);
         var _loc3_:int = Math.random() * _robotPositions.length;
         if(_loc3_ == _robotPositions.length)
         {
            _loc3_ = 0;
         }
         _loc2_.curPosX = _robotPositions[_loc3_].x;
         _loc2_.curPosY = _robotPositions[_loc3_].y;
         _loc2_.isRobot = true;
         _loc2_.isAdded = false;
         _loc4_.commit();
         _robotDic[_loc4_.userId] = _loc4_;
         _robotArmysDic[_loc4_.userId] = _loc2_;
         _robots.push(_loc2_);
         _index = _index + 1;
      }
      
      private function getPosX() : int
      {
         var _loc1_:int = 90;
         var _loc2_:int = _index % 4;
         if(_loc2_ == 1 || _loc2_ == 3)
         {
            _loc1_ = 150;
         }
         return int(_loc1_ + int(Math.random() * 20));
      }
      
      private function getPosY() : int
      {
         var _loc1_:int = 90;
         var _loc2_:int = _index % 4;
         if(_loc2_ == 2 || _loc2_ == 3)
         {
            _loc1_ = 110;
         }
         return int(_loc1_ + int(Math.random() * 20));
      }
      
      public function get robotInited() : Boolean
      {
         return _robotInited;
      }
      
      public function get robots() : Array
      {
         return _robots;
      }
      
      public function get nodeDic() : Dictionary
      {
         return _nodeDic;
      }
      
      private function get self() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
   }
}

