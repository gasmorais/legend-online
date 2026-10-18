package dialog.utils
{
   import com.pickgliss.loader.DisplayLoader;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ClassUtils;
   import flash.events.EventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import managers.MopupManager;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.StringHelper;
   
   public class NewbieTutorialBase extends EventDispatcher implements Disposeable
   {
      
      private var _nid:int;
      
      private var _timer:Timer;
      
      private var _delayNum:int = 100;
      
      protected var _step:int = 1;
      
      protected var actionComplete:Boolean;
      
      protected var actionType:String = "";
      
      protected var actionParams:String = "";
      
      protected var actionFunc:Function;
      
      protected var needWaitForComplete:Boolean;
      
      public function NewbieTutorialBase()
      {
         super();
         clearDynamic();
      }
      
      protected function clearDynamic() : void
      {
         LayerManager.Instance.clearnGameDynamic();
      }
      
      public function prepare() : void
      {
         if(!_timer)
         {
            _timer = new Timer(_delayNum);
         }
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      protected function __timerHandler(param1:TimerEvent = null) : void
      {
         if(!checkCommonCons())
         {
            return;
         }
         next();
      }
      
      protected function next() : void
      {
      }
      
      protected function excuteAction() : void
      {
         var _loc4_:Array = null;
         var _loc2_:Class = null;
         var _loc3_:Array = null;
         var _loc1_:Class = DisplayLoader.Context.applicationDomain.getDefinition("utils.NewbieUtils") as Class;
         _loc4_ = actionType.split("|");
         _loc2_ = DisplayLoader.Context.applicationDomain.getDefinition(_loc4_[0]) as Class;
         actionFunc = _loc2_[_loc4_[1]] as Function;
         if(!StringHelper.isNullOrEmpty(actionParams))
         {
            _loc3_ = actionParams.split(",");
         }
         else
         {
            _loc3_ = [];
         }
         stopTimer();
         if(needWaitForComplete)
         {
            _loc1_["execFunc"](actionFunc,_loc3_,completeNode,[nid]);
         }
         else
         {
            _loc1_["execFunc"](actionFunc,_loc3_);
            completeNode();
         }
      }
      
      private function checkCommonCons() : Boolean
      {
         if(SceneManager.instance.lock || MopupManager.instance.model.isMopup)
         {
            return false;
         }
         return true;
      }
      
      private function stopTimer() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      protected function completeNode(param1:Object = null) : void
      {
         if(actionComplete)
         {
            complete();
            return;
         }
         addStep();
         if(_timer)
         {
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
      }
      
      protected function addStep() : void
      {
         _step = _step + 1;
      }
      
      protected function skipNode() : void
      {
         stopTimer();
         actionComplete = true;
         completeNode();
      }
      
      public function set nid(param1:int) : void
      {
         _nid = param1;
      }
      
      public function get nid() : int
      {
         return _nid;
      }
      
      protected function get mapModel() : CampaignMapModel
      {
         return CampaignManager.instance.mapModel;
      }
      
      protected function get mapView() : *
      {
         return CampaignManager.instance.mapView;
      }
      
      protected function get mapController() : *
      {
         return CampaignManager.instance.controller;
      }
      
      protected function get MouseDataClass() : *
      {
         return ClassUtils.getDefinition("map.campaign.data.MouseData");
      }
      
      public function complete() : void
      {
         PlayerManager.instance.currentPlayerModel.playerInfo.noviceProcess = _nid;
         NewbieSocketOutManager.sendSaveProcess(_nid);
         dispose();
      }
      
      public function dispose() : void
      {
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
            _timer = null;
         }
         dispatchEvent(new NoviceEvent("tutorialComplete"));
      }
   }
}

