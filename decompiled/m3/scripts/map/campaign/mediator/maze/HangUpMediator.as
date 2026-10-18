package map.campaign.mediator.maze
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignArmyState;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.event.CampaignMapEvent;
   import map.internals.data.CampaignNode;
   import map.internals.data.ChestInfo;
   import yishi.events.NotificationEvent;
   import yishi.interfaces.IMediator;
   import yishi.manager.NotificationManager;
   import yishi.view.tips.MessageTipManager;
   
   public class HangUpMediator implements IMediator
   {
      
      private var _cannelBtn:IconButton;
      
      private var _submitBtn:IconButton;
      
      private var _hangUpTip:Bitmap;
      
      private var _selfArmy:CampaignArmy;
      
      private var _timeId:int;
      
      private var _repeat:int;
      
      public function HangUpMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         CampaignMapModel.inMazeFlag = true;
         _selfArmy = selfMemberData;
         _cannelBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.HangUpCannelBtn");
         _submitBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.HangUpStartBtn");
         _hangUpTip = ComponentFactory.Instance.creatBitmap("asset.campaign.maze.HangUpIngAsset");
         if(CampaignMapModel.isHangUp)
         {
            __submitHandler(null);
         }
         else
         {
            __cannelHandler(null);
         }
         NotificationManager.instance.addEventListener("MAZE_DIE",__mazeDieHandler);
         addEvent();
         playerState();
      }
      
      public function unregister(param1:Object) : void
      {
         removeEvent();
         if(_cannelBtn)
         {
            if(_cannelBtn.parent)
            {
               _cannelBtn.parent.removeChild(_cannelBtn);
            }
            _cannelBtn.dispose();
            _cannelBtn = null;
         }
         if(_submitBtn)
         {
            if(_submitBtn.parent)
            {
               _submitBtn.parent.removeChild(_submitBtn);
            }
            _submitBtn.dispose();
            _submitBtn = null;
         }
         if(_hangUpTip)
         {
            if(_hangUpTip.parent)
            {
               _hangUpTip.parent.removeChild(_hangUpTip);
            }
            _hangUpTip.bitmapData.dispose();
         }
         _hangUpTip = null;
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         CampaignManager.instance.controller.removeEventListener("mouseDown",__cannelHandler);
         NotificationManager.instance.removeEventListener("MAZE_DIE",__mazeDieHandler);
         _selfArmy = null;
      }
      
      private function addEvent() : void
      {
         _cannelBtn.addEventListener("click",__cannelHandler);
         _submitBtn.addEventListener("click",__submitHandler);
         _selfArmy.addEventListener("IS_DIE",__mazeDieHandler);
         NotificationManager.instance.addEventListener("QUIT_CAMPAIGN",__quitCampaignHandler);
      }
      
      private function removeEvent() : void
      {
         if(_cannelBtn)
         {
            _cannelBtn.removeEventListener("click",__cannelHandler);
         }
         if(_submitBtn)
         {
            _submitBtn.removeEventListener("click",__submitHandler);
         }
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__mazeDieHandler);
         }
         NotificationManager.instance.removeEventListener("QUIT_CAMPAIGN",__quitCampaignHandler);
      }
      
      private function __quitCampaignHandler(param1:NotificationEvent) : void
      {
         __cannelHandler(null);
      }
      
      private function __mazeDieHandler(param1:CampaignMapEvent) : void
      {
         playerState();
         __cannelHandler(null);
      }
      
      private function playerState() : void
      {
         var _loc1_:int = int(_selfArmy.isDie);
         _submitBtn.enable = !CampaignArmyState.checkDied(_loc1_);
      }
      
      private function __cannelHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         CampaignMapModel.isHangUp = false;
         if(_cannelBtn)
         {
            if(_cannelBtn.parent)
            {
               _cannelBtn.parent.removeChild(_cannelBtn);
            }
            LayerManager.Instance.addToLayer(_submitBtn,4);
         }
         if(_hangUpTip && _hangUpTip.parent)
         {
            _hangUpTip.parent.removeChild(_hangUpTip);
         }
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         CampaignManager.instance.controller.removeEventListener("mouseDown",__cannelHandler);
      }
      
      private function __submitHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         if(_selfArmy.isDie == 1)
         {
            _loc3_ = LanguageMgr.GetTranslation("map.campaign.mediator.maze.HangUpMediator.isDieTip");
            MessageTipManager.instance().show(_loc3_);
            return;
         }
         CampaignMapModel.isHangUp = true;
         StageReferance.stage.focus = StageReferance.stage;
         if(_submitBtn && _submitBtn.parent)
         {
            _submitBtn.parent.removeChild(_submitBtn);
         }
         LayerManager.Instance.addToLayer(_cannelBtn,4);
         LayerManager.Instance.addToLayer(_hangUpTip,3,true);
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         var _loc2_:int = param1 == null ? 2000 : 400;
         _timeId = setInterval(findNextStep,_loc2_);
         CampaignManager.instance.controller.addEventListener("mouseDown",__cannelHandler);
      }
      
      private function get selfMemberData() : CampaignArmy
      {
         return CampaignManager.instance.mapModel.selfMemberData;
      }
      
      private function findNextStep() : void
      {
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc4_:String = null;
         CampaignManager.instance.controller.addEventListener("mouseDown",__cannelHandler);
         if(_timeId > 0)
         {
            clearInterval(_timeId);
         }
         _timeId = 0;
         var _loc3_:CampaignNode = getMazeNodeByType(42);
         if(_loc3_)
         {
            CampaignManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y,true);
            return;
         }
         _loc3_ = getMazeNodeByType(92);
         if(_loc3_)
         {
            if(!repeatCount())
            {
               __cannelHandler(null);
               _repeat = 0;
               return;
            }
            _loc1_ = int((_loc3_.info as ChestInfo).nodePosX);
            _loc2_ = int((_loc3_.info as ChestInfo).nodePosY);
            _loc4_ = (_loc3_.info as ChestInfo).signId;
            _loc3_.info.state = 8;
            _loc3_.commit();
            CampaignSocketOutManager.instance.getFallChest(_loc4_,_loc1_,_loc2_);
            _timeId = setInterval(findNextStep,2000);
            return;
         }
         _loc3_ = getMazeNodeByType(61);
         if(_loc3_)
         {
            CampaignManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y,true);
            _timeId = setInterval(findNextStep,5000);
            return;
         }
         _loc3_ = getMazeNodeByType(62);
         if(_loc3_)
         {
            CampaignManager.instance.controller.moveArmyByPos(_loc3_.x,_loc3_.y,true);
            return;
         }
      }
      
      private function repeatCount() : Boolean
      {
         _repeat = _repeat + 1;
         if(_repeat >= 2)
         {
            return false;
         }
         return true;
      }
      
      private function getMazeNodeByType(param1:int) : CampaignNode
      {
         var _loc2_:Array = CampaignManager.instance.mapModel.mapNodesData;
         for each(var _loc3_:CampaignNode in _loc2_)
         {
            if(_loc3_.info.types == param1 && _loc3_.info.state != 8 && _loc3_.info.state != 9 && (param1 != 62 || param1 == 62 && _loc3_.sonType == 2336))
            {
               return _loc3_;
            }
         }
         return null;
      }
   }
}

