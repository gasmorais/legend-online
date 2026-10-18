package mvc.module.armyII
{
   import events.PawnEvent;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import yishi.datas.templates.PawnTemplate;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   
   public class ArmyPawn extends EventDispatcher
   {
      
      private static const PROPERTY_CHANGE:String = "PROPERTY_CHANGE";
      
      private static const SPECIAL_ALIBITY:String = "SPECIAL_ALIBITY";
      
      public static const SPECIAL_BLESS:String = "SPECIAL_BLESS";
      
      public static const ATTACK:int = 0;
      
      public static const DEFENCE:int = 1;
      
      public static const MAGIC_ATTACK:int = 2;
      
      public static const MAGIC_DEFENCE:int = 3;
      
      public static const LIVE:int = 4;
      
      public static const FORCEHIT:int = 5;
      
      public var attributeDic:Dictionary;
      
      public var canRecruit:Boolean;
      
      private var _changeObj:SimpleDictionary;
      
      public var id:int;
      
      public var userId:int;
      
      public var armyId:int;
      
      public var sites:int;
      
      public var icon:String;
      
      public var fightPos:int;
      
      private var _ownPawns:int;
      
      private var _templateId:int;
      
      private var _specialAbility:String;
      
      private var _tempSpecial:String;
      
      private var _blessNum:int;
      
      public function ArmyPawn()
      {
         super();
         _changeObj = new SimpleDictionary();
         attributeDic = new Dictionary();
         attributeDic[0] = new PawnProperty();
         attributeDic[1] = new PawnProperty();
         attributeDic[2] = new PawnProperty();
         attributeDic[3] = new PawnProperty();
         attributeDic[4] = new PawnProperty();
         attributeDic[5] = new PawnProperty();
      }
      
      public function get live() : Number
      {
         return attributeDic[4].getTotalJoin(templateInfo.Live);
      }
      
      public function get attack() : Number
      {
         return (attributeDic[0] as PawnProperty).getTotalJoin(templateInfo.Attack);
      }
      
      public function get defence() : Number
      {
         return (attributeDic[1] as PawnProperty).getTotalJoin(templateInfo.Defence);
      }
      
      public function get magicAttack() : Number
      {
         return (attributeDic[2] as PawnProperty).getTotalJoin(templateInfo.MagicAttack);
      }
      
      public function get magicDefence() : Number
      {
         return (attributeDic[3] as PawnProperty).getTotalJoin(templateInfo.MagicDefence);
      }
      
      public function get forceHit() : Number
      {
         return (attributeDic[5] as PawnProperty).getTotalJoin(templateInfo.ForceHit);
      }
      
      public function getPropertyByType(param1:int) : PawnProperty
      {
         return attributeDic[param1] as PawnProperty;
      }
      
      public function get ownPawns() : int
      {
         return _ownPawns;
      }
      
      public function set ownPawns(param1:int) : void
      {
         if(param1 != _ownPawns)
         {
            _ownPawns = param1;
            if(_ownPawns < 0)
            {
               _ownPawns = 0;
            }
            _changeObj["PROPERTY_CHANGE"] = true;
         }
      }
      
      public function get templateId() : int
      {
         return _templateId;
      }
      
      public function set templateId(param1:int) : void
      {
         if(param1 != _templateId)
         {
            _templateId = param1;
            _changeObj["PROPERTY_CHANGE"] = true;
         }
      }
      
      public function get specialAbility() : String
      {
         return _specialAbility;
      }
      
      public function set specialAbility(param1:String) : void
      {
         if(param1 != _specialAbility)
         {
            _specialAbility = param1;
            _changeObj["SPECIAL_ALIBITY"] = true;
         }
      }
      
      public function get tempSpecial() : String
      {
         return _tempSpecial;
      }
      
      public function set tempSpecial(param1:String) : void
      {
         _tempSpecial = param1;
         _changeObj["SPECIAL_ALIBITY"] = true;
      }
      
      public function get blessNum() : int
      {
         return _blessNum;
      }
      
      public function set blessNum(param1:int) : void
      {
         if(param1 != _blessNum)
         {
            _blessNum = param1;
            _changeObj["SPECIAL_BLESS"] = true;
         }
      }
      
      public function get pawnEvaluate() : int
      {
         return int(Math.pow(live * (attack + defence + magicDefence * 1.5) * (1 + magicAttack / 500),0.45));
      }
      
      public function synchronization(param1:ArmyPawn) : void
      {
         templateId = param1.templateId;
         sites = param1.sites;
         icon = param1.icon;
         specialAbility = param1.specialAbility;
         tempSpecial = param1.tempSpecial;
         blessNum = param1.blessNum;
      }
      
      public function get templateInfo() : PawnTemplate
      {
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(_templateId);
      }
      
      public function get nextTemplate() : PawnTemplate
      {
         return TempleteManager.instance.pawnTemplateCate.getTemplateByID(templateInfo.NextLevelTemplateId);
      }
      
      public function commit() : void
      {
         if(_changeObj["PROPERTY_CHANGE"])
         {
            dispatchEvent(new PawnEvent("pawnProppertyChager",this));
         }
         if(_changeObj["SPECIAL_ALIBITY"])
         {
            dispatchEvent(new PawnEvent("SPECIAL_ALIBITY",this));
         }
         if(_changeObj["SPECIAL_BLESS"])
         {
            dispatchEvent(new PawnEvent("SPECIAL_BLESS",this));
         }
         _changeObj.clear();
      }
   }
}

