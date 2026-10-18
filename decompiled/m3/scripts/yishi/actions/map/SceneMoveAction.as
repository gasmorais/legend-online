package yishi.actions.map
{
   import com.pickgliss.ui.controls.Frame;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setInterval;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignArmy;
   import yishi.manager.FrameControllerManager;
   import yishi.scene.SceneManager;
   
   public class SceneMoveAction extends MapBaseAction
   {
      
      private var _isRun:Boolean;
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _callback:Function;
      
      private var _timeId:int;
      
      public function SceneMoveAction(param1:int, param2:int, param3:Function = null)
      {
         _posX = param1;
         _posY = param2;
         _callback = param3;
         super();
      }
      
      override public function update() : void
      {
         var _loc4_:Object = null;
         var _loc3_:CampaignArmy = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Frame = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            over();
            return;
         }
         if(!_isRun)
         {
            _loc3_ = CampaignManager.instance.mapModel.selfMemberData;
            if(_loc3_)
            {
               _loc4_ = CampaignManager.instance.controller.getArmyView(_loc3_);
            }
            if(_loc4_)
            {
               _loc4_.aiInfo.pathInfo = [];
            }
            _loc1_ = int(_posX != 0 ? _posX : _loc4_.x / 20);
            _loc2_ = int(_posY != 0 ? _posY : _loc4_.y / 20);
            CampaignManager.instance.mapView.moveCenterPoint(new Point(_loc1_ * 20,_loc2_ * 20));
            CampaignManager.instance.mapModel.updateFog(_loc1_ * 20,_loc2_ * 20,2);
            _timeId = setInterval(over,200);
            _isRun = true;
            _loc5_ = FrameControllerManager.instance.taskControler.frame;
            if(_loc5_ && _loc5_.parent)
            {
               _loc5_.dispose();
            }
         }
      }
      
      private function over() : void
      {
         clearInterval(_timeId);
         _timeId = 0;
         dispose();
         if(_callback != null)
         {
            _callback();
         }
         _callback = null;
      }
   }
}

