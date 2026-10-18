package map.campaign.mediator.godsevening
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.event.CampaignMapEvent;
   import map.campaign.view.ui.godsevening.GodsEveningLeftView;
   import map.campaign.view.ui.godsevening.GodsEveningRightView;
   import map.campaign.view.ui.godsevening.GodsEveningTopView;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.GodsEveningManager;
   import yishi.manager.PlayerManager;
   
   public class GodsEveningUIMediator implements IEnterFrame, IMediator
   {
      
      private var _leftView:GodsEveningLeftView;
      
      private var _topView:GodsEveningTopView;
      
      private var _rightView:GodsEveningRightView;
      
      private var _cancelBtn:BaseButton;
      
      private var _selfArmy:CampaignArmy;
      
      public function GodsEveningUIMediator()
      {
         super();
      }
      
      public function enterFrame() : void
      {
      }
      
      public function register(param1:Object) : void
      {
         _leftView = new GodsEveningLeftView();
         _leftView.show();
         _topView = new GodsEveningTopView();
         _topView.show();
         _rightView = new GodsEveningRightView();
         _rightView.show();
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("GodsEveningCampaign.CancelBtn");
         _cancelBtn.addEventListener("click",__cancelTransport);
         _cancelBtn.visible = false;
         LayerManager.Instance.addToLayer(_cancelBtn,4,false,false,0,2);
         _selfArmy = CampaignManager.instance.mapModel.selfMemberData;
         if(_selfArmy)
         {
            _selfArmy.addEventListener("IS_DIE",__dieHandler);
            __dieHandler(null);
         }
         StageReferance.stage.addEventListener("resize",__resizeHandler);
         __resizeHandler(null);
      }
      
      public function unregister(param1:Object) : void
      {
         StageReferance.stage.removeEventListener("resize",__resizeHandler);
         _cancelBtn.removeEventListener("click",__cancelTransport);
         if(_selfArmy)
         {
            _selfArmy.removeEventListener("IS_DIE",__dieHandler);
         }
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_topView);
         _topView = null;
         ObjectUtils.disposeObject(_rightView);
         _rightView = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
      }
      
      private function __cancelTransport(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         GodsEveningManager.instance.sendCancelTransport(playerInfo.userId,playerInfo.serviceName);
      }
      
      private function __dieHandler(param1:CampaignMapEvent) : void
      {
         if(_selfArmy.isDie == 2 || _selfArmy.isDie == 3 || _selfArmy.isDie == 10 || _selfArmy.isDie == 11)
         {
            _cancelBtn.visible = true;
         }
         else
         {
            _cancelBtn.visible = false;
         }
      }
      
      private function __resizeHandler(param1:Event) : void
      {
         var _loc3_:int = int(StageReferance.stage.stageWidth);
         var _loc2_:int = int(StageReferance.stageHeight);
         if(_leftView)
         {
            _leftView.x = 0;
            _leftView.y = 40 + (StageReferance.stageHeight - _rightView.height) / 2;
         }
         if(_topView)
         {
            _topView.x = (_loc3_ - _topView.width) / 2;
            _topView.y = 0;
         }
         if(_rightView)
         {
            _rightView.x = StageReferance.stageWidth - _rightView.width;
            _rightView.y = (StageReferance.stageHeight - _rightView.height) / 2;
         }
         if(_cancelBtn)
         {
            _cancelBtn.x = (StageReferance.stageWidth - _cancelBtn.width) / 2;
            _cancelBtn.y = StageReferance.stageHeight - _cancelBtn.height - 55;
         }
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
   }
}

