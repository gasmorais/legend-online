package mvc.module.armyII
{
   import chat.datas.ChatData;
   import events.ArmyEvent;
   import flash.display.Sprite;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import map.internals.data.ArmyChildrenInfo;
   import map.internals.data.ArmyMonsterInfo;
   import map.internals.data.ArmyPetInfo;
   import map.internals.data.PhysicsEvent;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.MountTemplate;
   import yishi.events.RoleEvent;
   import yishi.manager.TempleteManager;
   
   public class BaseArmy extends EventDispatcher
   {
      
      public var petInfo:ArmyPetInfo;
      
      public var armyView:Sprite;
      
      public var childrenInfo:ArmyChildrenInfo;
      
      public var monsterInfo:ArmyMonsterInfo;
      
      private var _id:int;
      
      public var userId:int;
      
      public var mapId:int;
      
      public var armyName:String;
      
      public var nickName:String;
      
      public var type:int;
      
      public var curPosX:int;
      
      public var curPosY:int;
      
      public var roomState:int;
      
      private var _state:int;
      
      public var armyPawns:Dictionary;
      
      public var baseHero:ThaneInfo;
      
      private var _viceHero:ThaneInfo;
      
      private var _chatData:ChatData;
      
      private var _mountTemplateId:int = -1;
      
      public var mountGrade:int;
      
      public function BaseArmy()
      {
         super();
         armyPawns = new Dictionary(true);
         armyPawns[0] = new ArmyPawn();
         armyPawns[1] = new ArmyPawn();
         baseHero = new ThaneInfo();
         viceHero = new ThaneInfo();
         petInfo = new ArmyPetInfo();
         childrenInfo = new ArmyChildrenInfo();
         monsterInfo = new ArmyMonsterInfo();
      }
      
      public function get id() : int
      {
         return _id;
      }
      
      public function set id(param1:int) : void
      {
         if(param1 == 0)
         {
            throw new Error("id=0");
         }
         _id = param1;
      }
      
      public function dispose() : void
      {
         for(var _loc1_:String in armyPawns)
         {
            delete armyPawns[_loc1_];
         }
         armyPawns = null;
         baseHero = null;
         viceHero = null;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
         dispatchEvent(new ArmyEvent("UPDATE_STATE",this));
      }
      
      public function synchronizationAllPawn(param1:ArmyPawn) : void
      {
         for each(var _loc2_:ArmyPawn in armyPawns)
         {
            if(_loc2_.templateInfo && _loc2_.templateInfo.SonType == param1.templateInfo.SonType)
            {
               _loc2_.synchronization(param1);
               _loc2_.commit();
            }
         }
      }
      
      public function getPawnByIndex(param1:int) : ArmyPawn
      {
         return armyPawns[param1];
      }
      
      public function gePawnByTempId(param1:int) : ArmyPawn
      {
         var _loc2_:int = 0;
         var _loc3_:ArmyPawn = null;
         _loc2_ = 0;
         while(_loc2_ < 2)
         {
            _loc3_ = armyPawns[_loc2_];
            if(_loc3_.templateId == param1 && _loc3_.ownPawns > 0)
            {
               return _loc3_;
            }
            _loc2_++;
         }
         return null;
      }
      
      public function getEmputyPos() : int
      {
         var _loc1_:int = 0;
         var _loc2_:ArmyPawn = null;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = armyPawns[_loc1_];
            if(_loc2_.ownPawns <= 0)
            {
               return _loc1_;
            }
            _loc1_++;
         }
         return -1;
      }
      
      public function getLeftPopulation() : int
      {
         var _loc1_:int = baseHero.attackProrerty.totalConatArmy;
         for each(var _loc2_:ArmyPawn in armyPawns)
         {
            if(_loc2_.templateId > 0 && _loc2_.ownPawns)
            {
               _loc1_ -= _loc2_.ownPawns * _loc2_.templateInfo.NeedPopulation;
            }
         }
         return _loc1_;
      }
      
      public function addArmyPawnCountByIndex(param1:int, param2:int) : void
      {
         var _loc3_:ArmyPawn = armyPawns[param1];
         _loc3_.ownPawns += param2;
         _loc3_.commit();
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",this));
      }
      
      public function removeArmyPawnCountByIndex(param1:int, param2:int) : void
      {
         var _loc3_:ArmyPawn = armyPawns[param1];
         _loc3_.ownPawns -= param2;
         _loc3_.commit();
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",this));
      }
      
      public function addNewPawnByIndex(param1:int, param2:ArmyPawn, param3:int) : void
      {
         var _loc4_:ArmyPawn = armyPawns[param1];
         _loc4_.synchronization(param2);
         _loc4_.ownPawns = param3;
         _loc4_.commit();
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",this));
      }
      
      public function commit() : void
      {
         if(petInfo)
         {
            petInfo.commit();
         }
         if(childrenInfo)
         {
            childrenInfo.commit();
         }
         if(monsterInfo && VersionSwitch.MONSTER_FOLLOW)
         {
            monsterInfo.commit();
         }
         dispatchEvent(new ArmyEvent("ARMY_PAWN_CHANGE",this));
      }
      
      public function countAllArmyPawnNmber() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:ArmyPawn in armyPawns)
         {
            _loc1_ += _loc2_.ownPawns;
         }
         return _loc1_;
      }
      
      public function countArmyPawnsAllPopulaition() : int
      {
         var _loc1_:int = 0;
         for each(var _loc2_:ArmyPawn in armyPawns)
         {
            _loc1_ += _loc2_.ownPawns * _loc2_.templateInfo.NeedPopulation;
         }
         return _loc1_;
      }
      
      public function get combatPower() : int
      {
         return heroRace;
      }
      
      public function get heroRace() : Number
      {
         if(baseHero.id == 0)
         {
            return 0;
         }
         return baseHero.attackProrerty.totalAttribute + baseHero.attackProrerty.totalLive / 5 + baseHero.attackProrerty.totalConatArmy;
      }
      
      public function get chatData() : ChatData
      {
         return _chatData;
      }
      
      public function set chatData(param1:ChatData) : void
      {
         _chatData = param1;
         this.dispatchEvent(new PhysicsEvent("CHAT_DATA",_chatData));
      }
      
      public function set battleGold(param1:int) : void
      {
         this.dispatchEvent(new RoleEvent("battleGold",param1));
      }
      
      public function set battleGp(param1:int) : void
      {
         this.dispatchEvent(new RoleEvent("battleGP",param1));
      }
      
      public function set battleStrategy(param1:int) : void
      {
         this.dispatchEvent(new RoleEvent("battleStrategy",param1));
      }
      
      public function get mountTemplateId() : int
      {
         return _mountTemplateId;
      }
      
      public function set mountTemplateId(param1:int) : void
      {
         if(_mountTemplateId != param1)
         {
            _mountTemplateId = param1;
            if(baseHero)
            {
               baseHero.beginChanges();
               if(mountTemplate)
               {
                  baseHero.mountAvata = mountTemplate.AvatarPath;
               }
               else
               {
                  baseHero.mountAvata = "";
               }
               baseHero.commit();
            }
            if(viceHero)
            {
               viceHero.beginChanges();
               if(mountTemplate)
               {
                  viceHero.mountAvata = mountTemplate.AvatarPath;
               }
               else
               {
                  viceHero.mountAvata = "";
               }
               viceHero.commit();
            }
         }
      }
      
      public function get mountTemplate() : MountTemplate
      {
         return TempleteManager.instance.mountTemplateDic[_mountTemplateId];
      }
      
      public function get key() : String
      {
         var _loc1_:String = "";
         if(baseHero)
         {
            _loc1_ = baseHero.serviceName;
         }
         return _loc1_ + "_" + id;
      }
      
      public function get viceHero() : ThaneInfo
      {
         return _viceHero;
      }
      
      public function set viceHero(param1:ThaneInfo) : void
      {
         _viceHero = param1;
      }
   }
}

