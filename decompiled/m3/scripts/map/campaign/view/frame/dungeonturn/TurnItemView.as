package map.campaign.view.frame.dungeonturn
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import flash.utils.setTimeout;
   import managers.DungeoTurnManager;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   
   public class TurnItemView extends Component
   {
      
      private var _itemList:Vector.<TurnItem>;
      
      public var curentIndex:int;
      
      private var xyArray:Array = [[0,0],[102,0],[204,0],[306,0],[408,0],[510,0],[510,107],[511,214],[409,214],[307,214],[205,214],[103,214],[0,214],[0,107]];
      
      private var timer:Timer = new Timer(500);
      
      private var targetIndex:int;
      
      private var _black:Function;
      
      private var needFight:Boolean;
      
      public var killedCount:int;
      
      public function TurnItemView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TurnItem = null;
         _itemList = new Vector.<TurnItem>();
         _loc2_ = 0;
         while(_loc2_ < xyArray.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("TurnItemView.TurnItem");
            _loc1_.x = xyArray[_loc2_][0];
            _loc1_.y = xyArray[_loc2_][1];
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc2_++;
         }
         selectItem(0);
      }
      
      public function set data(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc2_:TurnItem = null;
         var _loc5_:int = 0;
         killedCount = 0;
         var _loc3_:Array = [0,1,2,3,4,5,6,7,8];
         _loc4_ = 0;
         while(_loc4_ < 14)
         {
            _loc2_ = _itemList[_loc4_];
            switch(_loc4_)
            {
               case 0:
                  _loc2_.setStart();
                  break;
               case 4:
               case 8:
                  _loc2_.setAgain();
                  break;
               case 12:
                  _loc2_.setRestart();
                  break;
               case 13:
                  _loc2_.setBoss();
                  break;
               default:
                  _loc5_ = _loc3_.shift();
                  if(param1[_loc5_].status == 1)
                  {
                     killedCount = killedCount + 1;
                  }
                  _loc2_.setStatus(param1[_loc5_].type,param1[_loc5_].count,param1[_loc5_].additionType,param1[_loc5_].status);
            }
            _loc4_++;
         }
      }
      
      public function selectItem(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:TurnItem = null;
         _loc3_ = 0;
         while(_loc3_ < 14)
         {
            _loc2_ = _itemList[_loc3_];
            if(_loc3_ == param1)
            {
               _loc2_.select();
               curentIndex = _loc3_;
            }
            else
            {
               _loc2_.cancelSelect();
            }
            _loc3_++;
         }
      }
      
      private function moveTo(param1:int) : void
      {
         targetIndex = param1;
         if(param1 == 0 && DungeoTurnManager.instance.model.rollNum == 0)
         {
            selectItem(0);
            return;
         }
         timer.start();
      }
      
      public function goToNext(param1:TimerEvent) : void
      {
         if(curentIndex == 13 && DungeoTurnManager.instance.model.currentIndex == 0)
         {
            selectItem(0);
            timer.stop();
            NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_ROLL_OVER"));
            return;
         }
         selectItem(curentIndex);
         if(targetIndex == curentIndex)
         {
            timer.stop();
            if(_itemList[curentIndex].canFight())
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_START_FIGHT"));
               setTimeout(DungeoTurnManager.instance.fight,700);
            }
            else
            {
               NotificationManager.instance.dispatchEvent(new NotificationEvent("DUNGEO_ROLL_OVER"));
            }
         }
         else
         {
            curentIndex += 1;
         }
      }
      
      private function addEvent() : void
      {
         timer.addEventListener("timer",goToNext);
         NotificationManager.instance.addEventListener("DUNGEO_PREPARE_FIGHT",_prepareFight);
      }
      
      private function _prepareFight(param1:Event) : void
      {
         moveTo(DungeoTurnManager.instance.model.currentIndex);
      }
      
      private function removeEvent() : void
      {
         timer.removeEventListener("timer",goToNext);
         NotificationManager.instance.removeEventListener("DUNGEO_PREPARE_FIGHT",_prepareFight);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:TurnItem in _itemList)
         {
            _loc1_.dispose();
         }
         _itemList = null;
         timer = null;
         super.dispose();
      }
   }
}

