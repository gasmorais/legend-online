package yishi.actions.map.pvp
{
   import com.road.yishi.proto.campaign.WarMovieMsg;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.actions.map.MapBaseAction;
   import yishi.scene.SceneManager;
   
   public class ScoreOrGesteAction extends MapBaseAction
   {
      
      private var _count:int;
      
      private var _addScoreTime:int;
      
      private var _addScoreValue:int;
      
      private var _addGesteValue:int;
      
      private var _msg:WarMovieMsg;
      
      public function ScoreOrGesteAction(param1:WarMovieMsg)
      {
         _msg = param1;
         super();
      }
      
      override public function prepare() : void
      {
      }
      
      override public function update() : void
      {
         var _loc1_:CampaignArmy = null;
         _count = _count + 1;
         if(!CampaignManager.instance.mapModel || SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            if(_count > 400)
            {
               dispose();
            }
            return;
         }
         _addScoreTime = _addScoreTime + 1;
         if(_addScoreTime == 30)
         {
            _loc1_ = CampaignManager.instance.mapModel.getUserArmyByUserId(_msg.userId,_msg.serverName);
            if(_loc1_)
            {
               _loc1_.score = _msg.isAdd ? _msg.score : -_msg.score;
            }
            _addScoreTime = 10000;
         }
         else if(_addScoreTime == 10030)
         {
            _loc1_ = CampaignManager.instance.mapModel.getUserArmyByUserId(_msg.userId,_msg.serverName);
            if(_loc1_)
            {
               _loc1_.geste = _msg.isAdd ? _msg.geste : -_msg.geste;
            }
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         _msg = null;
         _count = 0;
         _addScoreTime = 0;
         _addScoreValue = 0;
         _addGesteValue = 0;
         super.dispose();
      }
   }
}

