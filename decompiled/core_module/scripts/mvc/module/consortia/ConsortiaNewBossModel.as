package mvc.module.consortia
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import yishi.datas.ConfigInfoManager;
   import yishi.manager.PlayerManager;
   
   public class ConsortiaNewBossModel extends EventDispatcher
   {
      
      public var passLevel:int;
      
      public var maxLevel:int;
      
      public var callLevel:int;
      
      public var bossId:int;
      
      public var hasCallCount:int;
      
      public var maxCallCount:int;
      
      private var _bufferId:int;
      
      public var bufferStartTime:Date;
      
      public var bufferStopTime:Date;
      
      public var startTime:Date;
      
      public var stopTime:Date;
      
      public var rankArray:Array;
      
      public var fightCount:int;
      
      public var maxFightCount:int;
      
      public var myRank:int;
      
      public var myDamage:Number;
      
      public var bufferBuyCount:int;
      
      public var bestCount:int;
      
      public var hp:Number = 0;
      
      public var maxHp:Number = 0;
      
      public function ConsortiaNewBossModel()
      {
         super();
      }
      
      public function get bufferId() : int
      {
         return _bufferId;
      }
      
      public function set bufferId(param1:int) : void
      {
         _bufferId = param1;
         dispatchEvent(new Event("CONSORTIA_NEW_BOSS_BUFFER_CLEAR"));
      }
      
      public function isOver() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc2_:Number = stopTime.time / 1000;
         if(_loc3_ > _loc2_)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function bufferIsOver() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond;
         var _loc2_:Number = bufferStopTime.time / 1000;
         if(_loc3_ > _loc2_)
         {
            _loc1_ = true;
         }
         else
         {
            _loc1_ = false;
         }
         return _loc1_;
      }
      
      public function getBufferCount() : int
      {
         return ConfigInfoManager.instance.getConsortiaNewbuffCount();
      }
   }
}

