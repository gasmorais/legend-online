package yishi.actions.map
{
   import com.pickgliss.effect.EffectManager;
   import com.pickgliss.effect.IEffect;
   import flash.display.DisplayObject;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.CampaignMapView;
   import map.internals.data.CampaignNode;
   import map.internals.view.physics.MapPhysicsBase;
   import yishi.scene.SceneManager;
   
   public class CommonAction extends MapBaseAction
   {
      
      private var _nodeEffct:IEffect;
      
      private var _target:Object;
      
      private var _isPlayer:Boolean;
      
      private var _count:int;
      
      private var _time:int;
      
      private var _nodeId:int;
      
      public function CommonAction(param1:Object, param2:int = 75)
      {
         super();
         _target = param1;
         _isPlayer = false;
         _time = param2;
         if(_target && _target is MapPhysicsBase)
         {
            _nodeId = (_target as MapPhysicsBase).info.info.id;
         }
      }
      
      override public function update() : void
      {
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            dispose();
            return;
         }
         if(_isPlayer)
         {
            _count = _count + 1;
            if(_count < _time)
            {
               return;
            }
            if(_target)
            {
               _target.visible = false;
            }
            dispose();
            return;
         }
         if(_target)
         {
            if(_target.parent)
            {
               _count = 0;
               _target.visible = true;
               if(_target.hasOwnProperty("isPlaying"))
               {
                  _target["isPlaying"] = true;
               }
               if(_nodeEffct == null)
               {
                  _nodeEffct = EffectManager.Instance.creatEffect(3,_target,{
                     "color":"gold",
                     "speed":0.4,
                     "blurWidth":10,
                     "intensity":40,
                     "strength":0.6
                  });
               }
               _nodeEffct.play();
               _isPlayer = true;
            }
            else
            {
               _count = _count + 1;
               if(_count > 50)
               {
                  dispose();
               }
            }
         }
      }
      
      override public function dispose() : void
      {
         var _loc1_:CampaignMapView = null;
         var _loc3_:DisplayObject = null;
         var _loc4_:CampaignNode = null;
         if(_nodeEffct)
         {
            _nodeEffct.stop();
         }
         if(_nodeId > 0 && SceneManager.instance.currentType == "CAMPAIGN_MAP_SCENE")
         {
            _loc1_ = CampaignManager.instance.mapView;
            if(_loc1_)
            {
               _loc3_ = _loc1_.getNpcNodeById(_nodeId);
               if(_loc3_)
               {
                  _loc3_.visible = false;
               }
            }
         }
         var _loc2_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc2_)
         {
            _loc4_ = _loc2_.getMapNodesById(_nodeId);
            if(_loc4_ && _loc4_.info)
            {
               _loc4_.info.state = 8;
            }
         }
         _target = null;
         super.dispose();
      }
   }
}

