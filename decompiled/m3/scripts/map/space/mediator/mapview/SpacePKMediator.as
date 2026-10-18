package map.space.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.net.MapSocketOuterManager;
   import map.space.SpaceManager;
   import map.space.data.SpaceArmy;
   import map.space.view.frame.SpacePkAlertFrame;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   
   public class SpacePKMediator implements IMediator
   {
      
      private var _pkStack:Array;
      
      private var _alertFrame:SpacePkAlertFrame;
      
      private var timerId:int = 0;
      
      private var timerId2:int = 0;
      
      private var _selfInfo:SpaceArmy;
      
      public function SpacePKMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _pkStack = [];
         _selfInfo = SpaceManager.instance.model.selfArmy;
         NotificationManager.instance.addEventListener("SPACE_PK",__onPKRequestHandler);
      }
      
      private function __onPKRequestHandler(param1:NotificationEvent) : void
      {
         var _loc2_:HangupAttackMsg = param1.data as HangupAttackMsg;
         if(SharedManager.instance.refuseInvitation)
         {
            refuseThisRequest(_loc2_);
            return;
         }
         if(_loc2_.op == 1 && _loc2_.attackId != this._selfInfo.userId)
         {
            if(timerId2 != 0)
            {
               _pkStack.push(_loc2_);
               clearTimeout(timerId2);
            }
            else
            {
               clear();
            }
            deletePreMsgByAttackId(_loc2_.attackId);
            timerId2 = setTimeout(alertMsg,300,_loc2_);
         }
      }
      
      private function deletePreMsgByAttackId(param1:int) : void
      {
         var _loc2_:int = 0;
         while(_loc2_ < _pkStack.length)
         {
            if(_pkStack[_loc2_].attackId == param1)
            {
               _pkStack.splice(_loc2_,1);
            }
            else
            {
               _loc2_++;
            }
         }
      }
      
      private function alertMsg(param1:HangupAttackMsg) : void
      {
         clearTimeout(timerId2);
         timerId2 = 0;
         if(SceneManager.instance.currentType != "SPACE_SCENE")
         {
            return;
         }
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            return;
         }
         if(FrameControllerManager.instance.landMineController.isInLandMineFrame)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         _alertFrame = ComponentFactory.Instance.creatComponentByStylename("space.SpacePkAlertFrame");
         _alertFrame.msg = param1;
         var _loc2_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("public.prompt"));
         _loc2_.enableHtml = true;
         _loc2_.data = LanguageMgr.GetTranslation("map.hookMap.command01",_alertFrame.msg.attackName);
         _loc2_.submitLabel = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.accept");
         _loc2_.cancelLabel = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.reject");
         _alertFrame.info = _loc2_;
         _alertFrame.mediator = this;
         LayerManager.Instance.addToLayer(_alertFrame,1,true,true,2);
         if(timerId != 0)
         {
            clearTimeout(timerId);
         }
         timerId = setTimeout(clear,10000,false);
      }
      
      private function clear(param1:Boolean = true) : void
      {
         if(timerId != 0)
         {
            clearTimeout(timerId);
         }
         timerId = 0;
         if(_alertFrame)
         {
            param1 && _alertFrame.msg && _pkStack.push(_alertFrame.msg);
            _alertFrame.dispose();
         }
         _alertFrame = null;
      }
      
      public function receiveThisRequest(param1:HangupAttackMsg) : void
      {
         param1.defenceId = this._selfInfo.userId;
         MapSocketOuterManager.receivePKRequest(this._selfInfo.userId,param1.attackId);
         _alertFrame = null;
      }
      
      public function refuseThisRequest(param1:HangupAttackMsg) : void
      {
         MapSocketOuterManager.refusePKRequest(this._selfInfo.userId,param1.attackId);
         _alertFrame = null;
         if(_pkStack.length != 0)
         {
            timerId2 = setTimeout(alertMsg,300,_pkStack.pop());
         }
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("SPACE_PK",__onPKRequestHandler);
         clear();
         _pkStack = null;
         _selfInfo = null;
         if(timerId != 0)
         {
            clearTimeout(timerId);
         }
         if(timerId2 != 0)
         {
            clearTimeout(timerId2);
         }
      }
   }
}

