package yishi.datas.objects
{
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.manager.NotificationManager;
   
   public class BattleArmyInfo extends EventDispatcher
   {
      
      private var _site:int;
      
      private var _face:int;
      
      private var _heroList:Dictionary;
      
      private var _pawnList:Dictionary;
      
      private var _petList:Dictionary;
      
      private var _roles:Dictionary;
      
      private var _goddessList:Dictionary;
      
      private var _monsterList:Dictionary;
      
      private var _selfChessList:Dictionary;
      
      public var maxTotalHp:int;
      
      public function BattleArmyInfo()
      {
         super();
         _heroList = new Dictionary();
         _pawnList = new Dictionary();
         _petList = new Dictionary();
         _roles = new Dictionary();
         _goddessList = new Dictionary();
         _monsterList = new Dictionary();
         _selfChessList = new Dictionary();
      }
      
      public function get face() : int
      {
         return _face;
      }
      
      public function set face(param1:int) : void
      {
         _face = param1;
         for each(var _loc2_:RoleInfo in _roles)
         {
            _loc2_.face = _face;
         }
      }
      
      public function get currentArmyHp() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:PawnRoleInfo in _pawnList)
         {
            _loc2_ += _loc1_.bloodCalculate;
         }
         for each(var _loc3_:HeroRoleInfo in _heroList)
         {
            _loc2_ += _loc3_.bloodCalculate;
         }
         return _loc2_;
      }
      
      public function getPawnTotalHp() : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc1_:PawnRoleInfo in _pawnList)
         {
            _loc2_ += _loc1_.totalBloodA;
         }
         return _loc2_;
      }
      
      public function getArmyLeftHp() : int
      {
         var _loc2_:int = 0;
         for each(var _loc1_:PawnRoleInfo in _pawnList)
         {
            _loc2_ += _loc1_.bloodA;
         }
         return _loc2_;
      }
      
      public function getLeftHp() : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc1_:PawnRoleInfo in _pawnList)
         {
            _loc2_ += _loc1_.bloodA;
         }
         for each(var _loc3_:HeroRoleInfo in _heroList)
         {
            _loc2_ += _loc3_.bloodA;
         }
         return _loc2_;
      }
      
      public function getBossesTotalHpByInfo(param1:HeroRoleInfo) : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc3_:HeroRoleInfo in _heroList)
         {
            if(_loc3_ == param1)
            {
               return _loc3_.totalBloodA;
            }
         }
         return _loc2_;
      }
      
      public function getBossesLeftHpByInfo(param1:HeroRoleInfo) : Number
      {
         var _loc2_:Number = 0;
         for each(var _loc3_:HeroRoleInfo in _heroList)
         {
            if(_loc3_ == param1)
            {
               return _loc3_.bloodA;
            }
         }
         return _loc2_;
      }
      
      public function getBossesTotalHp() : Number
      {
         var _loc1_:Number = 0;
         for each(var _loc2_:HeroRoleInfo in _heroList)
         {
            if(_loc2_.type == 3)
            {
               _loc1_ += _loc2_.totalBloodA;
            }
         }
         return _loc1_;
      }
      
      public function getBossesLeftHp() : Number
      {
         var _loc1_:Number = 0;
         for each(var _loc2_:HeroRoleInfo in _heroList)
         {
            if(_loc2_.type == 3)
            {
               _loc1_ += _loc2_.bloodA;
            }
         }
         return _loc1_;
      }
      
      public function getRoleById(param1:int) : RoleInfo
      {
         for each(var _loc2_:RoleInfo in _heroList)
         {
            if(_loc2_.livingId == param1)
            {
               return _loc2_;
            }
         }
         for each(var _loc3_:RoleInfo in _pawnList)
         {
            if(_loc3_.livingId == param1)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function removeRole(param1:RoleInfo) : void
      {
         if(_heroList[param1.livingId])
         {
            delete _heroList[param1.livingId];
            NotificationManager.instance.sendNotification("BattleModelNotic.REMOVE_ROLE",param1);
            param1.dispose();
            param1 = null;
         }
      }
      
      public function addHero(param1:HeroRoleInfo) : void
      {
         var _loc2_:Object = {};
         if(_heroList[param1.livingId])
         {
            _loc2_.oldInfo = _heroList[param1.livingId];
         }
         _loc2_.newInfo = param1;
         _heroList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         maxTotalHp += param1.blood;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function getHeroByID(param1:int) : HeroRoleInfo
      {
         return _heroList[param1] as HeroRoleInfo;
      }
      
      public function get getHeros() : Dictionary
      {
         return _heroList;
      }
      
      public function addPawn(param1:PawnRoleInfo) : void
      {
         var _loc2_:Object = {};
         if(_pawnList[param1.livingId])
         {
            _loc2_.oldInfo = _pawnList[param1.livingId];
         }
         _loc2_.newInfo = param1;
         _pawnList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         maxTotalHp += param1.blood;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function getPawnById(param1:int) : PawnRoleInfo
      {
         return _pawnList[param1] as PawnRoleInfo;
      }
      
      public function get getPawns() : Dictionary
      {
         return _pawnList;
      }
      
      public function get roles() : Dictionary
      {
         return _roles;
      }
      
      public function get boss() : HeroRoleInfo
      {
         for each(var _loc1_:HeroRoleInfo in _heroList)
         {
            if(_loc1_.type == 3)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      public function get site() : int
      {
         return _site;
      }
      
      public function set site(param1:int) : void
      {
         _site = param1;
      }
      
      public function addPet(param1:PetRoleInfo) : void
      {
         var _loc2_:Object = {};
         _loc2_.oldInfo = _petList[param1.livingId];
         _loc2_.newInfo = param1;
         _petList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function get getPets() : Dictionary
      {
         return _petList;
      }
      
      public function addGoddess(param1:GoddessRoleInfo) : void
      {
         var _loc2_:Object = {};
         _loc2_.oldInfo = _petList[param1.livingId];
         _loc2_.newInfo = param1;
         _goddessList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function get getGoddess() : Dictionary
      {
         return _goddessList;
      }
      
      public function addMonster(param1:MonsterRoleInfo) : void
      {
         var _loc2_:Object = {};
         _loc2_.oldInfo = _petList[param1.livingId];
         _loc2_.newInfo = param1;
         _monsterList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function get getMonster() : Dictionary
      {
         return _monsterList;
      }
      
      public function addSelfChess(param1:SelfChessRoleInfo) : void
      {
         var _loc2_:Object = {};
         _loc2_.oldInfo = _petList[param1.livingId];
         _loc2_.newInfo = param1;
         _goddessList[param1.livingId] = param1;
         _roles[param1.livingId] = param1;
         NotificationManager.instance.sendNotification("BattleModelNotic.ADD_ROLE",_loc2_);
      }
      
      public function get selfChessList() : Dictionary
      {
         return _selfChessList;
      }
   }
}

