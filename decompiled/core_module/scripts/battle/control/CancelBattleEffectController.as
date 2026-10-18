package battle.control
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import yishi.interfaces.IEnterFrame;
   import yishi.manager.EnterFrameManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.utils.TimerUtils;
   
   public class CancelBattleEffectController implements IEnterFrame
   {
      
      private static var _instance:CancelBattleEffectController;
      
      private static var _hadOpened:Boolean;
      
      private var _stoped:Boolean;
      
      private var _frameCount:int;
      
      private const CHECK_NUM:int = 10;
      
      private var _startTime:int;
      
      private var _fps:int;
      
      private var _fpsCache:Array;
      
      private var _alert:BaseAlerFrame;
      
      public function CancelBattleEffectController()
      {
         super();
      }
      
      public static function start() : void
      {
         var _loc1_:int = 1;
         if(BattleManager.getInstance().battleModel)
         {
            _loc1_ = BattleManager.getInstance().battleModel.mapResId;
         }
         if(!_hadOpened && _loc1_ != 1)
         {
            getInstance().play();
         }
      }
      
      public static function cancel() : void
      {
         getInstance().stop();
      }
      
      private static function getInstance() : CancelBattleEffectController
      {
         if(!_instance)
         {
            _instance = new CancelBattleEffectController();
         }
         return _instance;
      }
      
      private function play() : void
      {
         _stoped = false;
         TimerUtils.setTimeout(startCheck,1000);
      }
      
      private function startCheck() : void
      {
         if(!_stoped)
         {
            _fpsCache = [];
            _startTime = getTimer();
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      private function stop() : void
      {
         _stoped = true;
         resposeHandler(null);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      public function enterFrame() : void
      {
         _frameCount = _frameCount + 1;
         if(_frameCount == 10)
         {
            _frameCount = 0;
            _fps = 1000 * 10 / (getTimer() - _startTime);
            _startTime = getTimer();
            _fpsCache.push(_fps);
            if(_fpsCache.length > 10)
            {
               _fpsCache.shift();
               processData();
            }
         }
      }
      
      private function processData() : void
      {
         var _loc2_:int = 0;
         for each(var _loc1_:int in _fpsCache)
         {
            _loc2_ += _loc1_;
         }
      }
      
      private function showAlert() : void
      {
         var _loc1_:String = null;
         var _loc2_:String = null;
         var _loc3_:String = null;
         var _loc4_:String = null;
         _hadOpened = true;
         if(SharedManager.instance.allowSceneEffect)
         {
            _loc1_ = LanguageMgr.GetTranslation("public.confirm");
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc3_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("battle.control.CancelBattleEffectController.content");
            _alert = AlertManager.Instance.functionAlert(_loc3_,_loc4_,_loc1_,_loc2_,false,false,true);
            _alert.addEventListener("response",resposeHandler);
         }
      }
      
      private function resposeHandler(param1:FrameEvent) : void
      {
         if(_alert)
         {
            _alert.removeEventListener("response",resposeHandler);
            _alert.dispose();
            _alert = null;
         }
         if(param1)
         {
            switch(param1.responseCode - 2)
            {
               case 0:
               case 1:
                  SharedManager.instance.allowSceneEffect = false;
                  NotificationManager.instance.dispatchEvent(new BattleEvent("sceneEffectClose",null));
            }
         }
      }
   }
}

