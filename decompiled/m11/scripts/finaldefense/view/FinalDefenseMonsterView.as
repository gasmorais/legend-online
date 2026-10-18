package finaldefense.view
{
   import com.greensock.TweenMax;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.clearTimeout;
   import flash.utils.setInterval;
   import flash.utils.setTimeout;
   import managers.FinalDefenseManager;
   import mvc.module.finaldefense.info.DitchNpcInfoData;
   import yishi.manager.NotificationManager;
   
   public class FinalDefenseMonsterView extends FinalDefenseRoleView
   {
      
      private static const MIN_X:Array = [0,205,170,135,100];
      
      private var uintFlag:uint;
      
      private var _bornPoint:Point;
      
      private var _status:String;
      
      private var _isStop:Boolean = false;
      
      private var _stopFlag:uint;
      
      public function FinalDefenseMonsterView(param1:DisplayObject)
      {
         super(param1);
      }
      
      override protected function initLvUpBtn() : void
      {
      }
      
      override public function set data(param1:DitchNpcInfoData) : void
      {
         super.data = param1;
      }
      
      override protected function setPoint() : void
      {
         this.scaleX = -1;
         this.x = -50 + _parent.width * _data.bornPoint / 100;
         this.y = 50 + _parent.height * _data.rowIndex * 0.18;
         _bornPoint = new Point(this.x,this.y);
      }
      
      override public function gameStar() : void
      {
         this.addEventListener("enterFrame",onEnterFrame);
         if(_isStop)
         {
            return;
         }
         if(uintFlag == 0)
         {
            uintFlag = setInterval(sendMove,1000);
         }
         if(_roleMc != null)
         {
            _status = "Walk";
            _roleMc.gotoAndPlay(_status);
         }
      }
      
      private function onEnterFrame(param1:Event) : void
      {
         if(_status == "Walk" && !_isStop)
         {
            this.x -= 1;
            if(this.x <= MIN_X[_data.rowIndex])
            {
               clearInterval(uintFlag);
               uintFlag = 0;
               _status = "Stand";
               _roleMc.gotoAndPlay(_status);
               attack();
            }
         }
         else if(_status == "Stand")
         {
            if(FinalDefenseManager.ins.model.getSelfNpcByRow(_data.rowIndex) == -1)
            {
               this.removeEventListener("enterFrame",onEnterFrame);
               _roleMc.gotoAndPlay("Walk");
               TweenMax.to(this,2,{
                  "x":-200,
                  "onComplete":dispose
               });
            }
         }
      }
      
      override protected function sendAttack() : void
      {
         var _loc1_:int = int(FinalDefenseManager.ins.model.getSelfNpcByRow(_data.rowIndex));
         if(_loc1_ == -1)
         {
            clearInterval(_attackFlag);
         }
         else
         {
            FinalDefenseManager.ins.sendAttack(_data.id,_loc1_);
         }
      }
      
      public function blackToBornPoint() : void
      {
         this.x = _bornPoint.x;
         this.y = _bornPoint.y;
      }
      
      public function stopByTime(param1:int) : void
      {
         if(_status == "Walk")
         {
            _roleMc.gotoAndPlay("Stand");
            _isStop = true;
         }
         clearTimeout(_stopFlag);
         _stopFlag = setTimeout(removeStop,param1 * 1000);
      }
      
      private function removeStop() : void
      {
         _isStop = false;
         _roleMc.gotoAndPlay("Walk");
      }
      
      private function sendMove() : void
      {
      }
      
      override protected function attackAction() : void
      {
         clearInterval(uintFlag);
         if(_roleMc != null)
         {
            _roleMc.gotoAndPlay("Attack01");
            sendAttack();
         }
      }
      
      override protected function roleDea() : void
      {
         NotificationManager.instance.sendNotification("FINAL_DEFENSE_ROLE_DEA",_data.id);
         FinalDefenseManager.ins.model.delDeaNPC(_data.id);
      }
      
      override public function dispose() : void
      {
         clearTimeout(_stopFlag);
         this.removeEventListener("enterFrame",onEnterFrame);
         super.dispose();
      }
   }
}

