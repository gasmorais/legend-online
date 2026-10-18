package yishi.actions.map
{
   import com.pickgliss.ui.LayerManager;
   import com.road.yishi.proto.campaign.PlayerMoveMsg;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.MouseData;
   import map.campaign.view.ui.SceneMaskView;
   import yishi.scene.SceneManager;
   
   public class PlayerMoveAction extends MapBaseAction
   {
      
      private var _msg:PlayerMoveMsg;
      
      private var _playerView:Object;
      
      private var _tarPos:Point;
      
      private var _sceneMask:SceneMaskView;
      
      public function PlayerMoveAction(param1:PlayerMoveMsg)
      {
         _msg = param1;
         super();
      }
      
      override public function prepare() : void
      {
         var _loc1_:String = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            return;
         }
         super.prepare();
         if(CampaignManager.instance.mapModel.selfMemberData.id == _msg.userId)
         {
            MouseData.instance.curState = "Lock";
            if(_msg.ismoveCamera)
            {
               CampaignManager.instance.mapView.moveCenterPoint(new Point(_msg.tarX * 20,_msg.tarY * 20));
               CampaignManager.instance.mapModel.updateFog(_msg.tarX * 20,_msg.tarY * 20,2);
               MouseData.instance.curState = "Lock";
            }
            CampaignManager.instance.controller.moveArmyByPos(_msg.tarX * 20,_msg.tarY * 20);
            var _loc2_:CampaignArmy = CampaignManager.instance.mapModel.getUserArmyByArmyId(_msg.userId);
            var _loc3_:Object = CampaignManager.instance.controller.getArmyView(_loc2_);
            if(_loc2_)
            {
               _playerView = _loc3_;
            }
            _sceneMask = new SceneMaskView();
            LayerManager.Instance.addToLayer(_sceneMask,3,true);
            _sceneMask.x = 0;
            _sceneMask.y = 0;
            return;
         }
         _loc1_ = LanguageMgr.GetTranslation("yishi.actions.map.PlayerMoveAction.prepareErrorTip");
         throw new Error(_loc1_);
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE" || !_playerView || _playerView.aiInfo.pathInfo.length == 0)
         {
            if(_sceneMask)
            {
               _sceneMask.dispose();
            }
            _sceneMask = null;
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         MouseData.instance.curState = "Normal";
      }
   }
}

