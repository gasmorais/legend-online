package map.campaign.mediator.mapview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.vo.AlertInfo;
   import com.road.yishi.proto.campaign.HangupAttackMsg;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.view.physics.HoodRoomArmyView;
   import map.space.view.frame.SpacePkAlertFrame;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.SharedManager;
   import yishi.scene.SceneManager;
   
   public class HookMapPKMediator implements IMediator
   {
      
      private var _pkStack:Array;
      
      private var _alertFrame:SpacePkAlertFrame;
      
      private var timerId:int = 0;
      
      private var timerId2:int = 0;
      
      private var _selfInfo:CampaignArmy;
      
      private var _controller:CampaignMapController;
      
      public function HookMapPKMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _controller = CampaignManager.instance.controller as CampaignMapController;
         _pkStack = [];
         _selfInfo = CampaignManager.instance.mapModel.selfMemberData;
         NotificationManager.instance.addEventListener("CAMPAIGN_PK",__onPKRequestHandler);
         param1.addEventListener("mouseOver",__onMouseOver);
         param1.addEventListener("mouseOut",__onMouseOut);
         param1.addEventListener("mouseMove",__onMouseMove);
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
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         if(FrameControllerManager.instance.outyardControler.isOutyardMapApply)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         _alertFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.HookMapPkAlertFrame");
         _alertFrame.msg = param1;
         var _loc2_:AlertInfo = new AlertInfo(LanguageMgr.GetTranslation("public.prompt"));
         _loc2_.enableHtml = true;
         _loc2_.data = LanguageMgr.GetTranslation("map.hookMap.command01",_alertFrame.msg.attackName);
         _loc2_.submitLabel = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.accept");
         _loc2_.cancelLabel = LanguageMgr.GetTranslation("map.campaign.view.frame.PrepareBattleFrame1.reject");
         _alertFrame.info = _loc2_;
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
      
      private function __onMouseOver(param1:MouseEvent) : void
      {
         var _loc2_:HoodRoomArmyView = null;
         if(param1.target is HoodRoomArmyView)
         {
            _loc2_ = param1.target as HoodRoomArmyView;
            _loc2_.mouseOverHandler(param1);
            param1.stopPropagation();
         }
      }
      
      private function __onMouseOut(param1:MouseEvent) : void
      {
         var _loc2_:HoodRoomArmyView = null;
         if(param1.target is HoodRoomArmyView)
         {
            _loc2_ = param1.target as HoodRoomArmyView;
            _loc2_.mouseOutHandler(param1);
            param1.stopPropagation();
         }
      }
      
      private function __onMouseMove(param1:MouseEvent) : void
      {
         var _loc2_:HoodRoomArmyView = null;
         if(param1.target is HoodRoomArmyView)
         {
            _loc2_ = param1.target as HoodRoomArmyView;
            _loc2_.mouseMoveHandler(param1);
            param1.stopPropagation();
         }
      }
      
      public function receiveThisRequest(param1:HangupAttackMsg) : void
      {
         param1.defenceId = this._selfInfo.userId;
         _controller.receivePKRequest(this._selfInfo.userId,param1.attackId);
         _alertFrame = null;
      }
      
      public function refuseThisRequest(param1:HangupAttackMsg) : void
      {
         _controller.refusePKRequest(this._selfInfo.userId,param1.attackId);
         _alertFrame = null;
         if(_pkStack.length != 0)
         {
            timerId2 = setTimeout(alertMsg,300,_pkStack.pop());
         }
      }
      
      public function unregister(param1:Object) : void
      {
         NotificationManager.instance.removeEventListener("CAMPAIGN_PK",__onPKRequestHandler);
         param1.removeEventListener("mouseOver",__onMouseOver);
         param1.removeEventListener("mouseOut",__onMouseOut);
         param1.removeEventListener("mouseMove",__onMouseMove);
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

