package battle.view.buffer
{
   import battle.BattleManager;
   import battle.data.BufferDamageData;
   import battle.skillsys.effect.EffectContainer;
   import flash.display.MovieClip;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import yishi.datas.objects.RoleInfo;
   import yishi.datas.templates.BufferTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class BufferLastEffect
   {
      
      private var _roleInfo:RoleInfo;
      
      private var _bufferDamageData:BufferDamageData;
      
      private var _effectContainer:EffectContainer;
      
      private var _res:String;
      
      private var _effect:MovieClip;
      
      private var _timer:Timer;
      
      private var _interval:int;
      
      private var _destroyed:Boolean;
      
      public function BufferLastEffect(param1:RoleInfo, param2:BufferDamageData, param3:EffectContainer, param4:String)
      {
         super();
         _roleInfo = param1;
         _bufferDamageData = param2;
         _effectContainer = param3;
         _res = param4;
      }
      
      public function show() : void
      {
         if(BattleManager.getInstance().battleModel.isHideOtherInBattle(_roleInfo))
         {
            return;
         }
         var _loc2_:BufferTemplateInfo = TempleteManager.instance.bufferTemplateCate.getTemplateByID(_bufferDamageData.templateId);
         _interval = _loc2_.getLastEffectArr()[2];
         _effect = BattleManager.getInstance().resourceModel.getOrCreateInstanse(_res);
         var _loc1_:Point = _roleInfo.getSpecialPos(_loc2_.getLastEffectArr()[1]);
         _effect.x = _loc1_.x;
         _effect.y = _loc1_.y;
         _effectContainer.addChild(_effect);
         _effect.addFrameScript(_effect.totalFrames - 1,movieEndFrameFun);
         showOne();
      }
      
      private function showOne() : void
      {
         _effect.gotoAndPlay(1);
         _effect.visible = true;
      }
      
      private function movieEndFrameFun() : void
      {
         if(!_destroyed)
         {
            if(_interval > 0)
            {
               _effect.stop();
               _effect.visible = false;
               startTimer();
            }
         }
      }
      
      private function startTimer() : void
      {
         removeTimer();
         _timer = new Timer(_interval * 40,1);
         _timer.addEventListener("timerComplete",onTimerComplete);
         _timer.start();
      }
      
      private function onTimerComplete(param1:TimerEvent) : void
      {
         removeTimer();
         showOne();
      }
      
      private function removeTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timerComplete",onTimerComplete);
            _timer = null;
         }
      }
      
      public function get bufferData() : BufferDamageData
      {
         return _bufferDamageData;
      }
      
      public function dispose() : void
      {
         removeTimer();
         BattleManager.getInstance().resourceModel.recyleInstanse(_effect);
         _effect = null;
         _destroyed = true;
         _roleInfo = null;
         _bufferDamageData = null;
         _effectContainer = null;
      }
   }
}

