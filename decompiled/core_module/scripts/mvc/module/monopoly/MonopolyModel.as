package mvc.module.monopoly
{
   import events.MonopolyEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import yishi.manager.TempleteManager;
   
   public class MonopolyModel extends EventDispatcher
   {
      
      public static const NORMAL_TYPE:int = 0;
      
      public static const NORMAL_BATTLE_TYPE:int = 1;
      
      public static const REINFROCE_BATTLE_TYPE:int = 2;
      
      public static const BOSS_BATTLE_TYPE:int = 3;
      
      public static const RANDOM_REWARD_TYPE:int = 4;
      
      public static const TRAP_TYPE:int = 5;
      
      public static const TREASURE_BOX_TYPE:int = 6;
      
      public static const END_REWARD_TYPE:int = 7;
      
      public static const BATTLE_FAIL_TYPE:int = 8;
      
      public static const BEGIN_TYPE:int = 9;
      
      public static const END_TYPE:int = 10;
      
      public static const RESOURCE_TYPE:int = 11;
      
      public static const GAME_TYPE:int = 12;
      
      public static const EVENT_END_TYPE:int = 100;
      
      public static const GEM_MAZE_TARGET:int = 300;
      
      public var normalPoint:int;
      
      public var specialPoint:int;
      
      public var warFlag:int;
      
      public var position:int;
      
      public var resultPoint:int;
      
      public var lastBuySpecialPoint:int;
      
      public var lastBuyWarFlag:int;
      
      public var nodeInfos:Array;
      
      public var normalTimes:int;
      
      public var magicTimes:int;
      
      public var slotMachineTimes:int;
      
      public var itemInfos:Array;
      
      public var isMail:Boolean;
      
      public var lastPosition:int;
      
      public var campaignCount:int;
      
      public var warFlagMax:int = 5;
      
      public var warFlagPrice:int = 10;
      
      public var magicDiceMax:int = 5;
      
      public var magicDicePrice:int = 50;
      
      public function MonopolyModel()
      {
         super();
         nodeInfos = [];
         var _loc1_:Array = TempleteManager.instance.getConfigInfoByConfigName("Flag_Monopoly").ConfigValue.split(",");
         var _loc2_:Array = TempleteManager.instance.getConfigInfoByConfigName("Dice_Monopoly").ConfigValue.split(",");
         warFlagMax = _loc1_[0];
         warFlagPrice = _loc1_[1];
         magicDiceMax = _loc2_[2];
         magicDicePrice = _loc2_[3];
      }
      
      public function get gameIsOver() : Boolean
      {
         if(normalPoint == 0 && specialPoint == 0 && lastBuySpecialPoint == 0)
         {
            return true;
         }
         return false;
      }
      
      public function getPath() : Array
      {
         var _loc4_:MonopolyNodeInfo = null;
         var _loc3_:int = 0;
         var _loc1_:Array = [];
         var _loc5_:int = lastPosition;
         var _loc2_:int = position;
         if(_loc5_ < _loc2_)
         {
            _loc3_ = 0;
            while(_loc3_ < nodeInfos.length)
            {
               _loc4_ = nodeInfos[_loc3_] as MonopolyNodeInfo;
               if(_loc4_)
               {
                  if(_loc4_.position >= _loc5_)
                  {
                     if(_loc4_.position > _loc2_)
                     {
                        break;
                     }
                     _loc1_.push(new Point(_loc4_.x,_loc4_.y));
                  }
               }
               _loc3_++;
            }
         }
         else if(_loc5_ > _loc2_)
         {
            _loc3_ = nodeInfos.length - 1;
            while(_loc3_ >= 0)
            {
               _loc4_ = nodeInfos[_loc3_] as MonopolyNodeInfo;
               if(_loc4_)
               {
                  if(_loc4_.position <= _loc5_ && _loc4_.position >= _loc2_)
                  {
                     _loc1_.push(new Point(_loc4_.x,_loc4_.y));
                  }
               }
               _loc3_--;
            }
         }
         return _loc1_;
      }
      
      public function commit() : void
      {
         dispatchEvent(new MonopolyEvent("MONOPOLY_INFO_CHANGE",this));
      }
   }
}

