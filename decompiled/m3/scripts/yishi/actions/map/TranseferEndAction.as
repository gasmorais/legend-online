package yishi.actions.map
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.road.yishi.proto.player.PlayerMovieMsg;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.geom.Point;
   import map.campaign.CampaignManager;
   import map.campaign.data.CampaignMapModel;
   import map.internals.data.CampaignNode;
   import map.internals.view.hero.helper.HeroAvatarViewHelper;
   import yishi.comm.PackageIn;
   import yishi.scene.SceneManager;
   import yishi.view.tools.SimpleMovie;
   
   public class TranseferEndAction extends MapBaseAction
   {
      
      private var _pkg:PackageIn;
      
      private var _count:int;
      
      private var _nodeId:int;
      
      private var _node:DisplayObject;
      
      public function TranseferEndAction(param1:PackageIn, param2:String)
      {
         _pkg = param1;
         super();
      }
      
      override public function prepare() : void
      {
         var _loc1_:PlayerMovieMsg = new PlayerMovieMsg();
         _loc1_ = _pkg.readBody(_loc1_) as PlayerMovieMsg;
         if(selfArmyView)
         {
            selfArmyView.aiInfo.pathInfo = [];
         }
         _nodeId = _loc1_.targetId;
         var _loc2_:CampaignNode = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
         if(_loc2_)
         {
            _node = _loc2_.nodeView;
         }
         _loc1_ = null;
         super.prepare();
      }
      
      override public function update() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:SimpleMovie = null;
         var _loc3_:String = SceneManager.instance.currentType;
         if(_loc3_ != "CAMPAIGN_MAP_SCENE")
         {
            dispose();
            return;
         }
         _count = _count + 1;
         if(_node && _count == 1)
         {
            CampaignManager.instance.mapView.moveCenterPoint(new Point(_node.x,_node.y));
            CampaignManager.instance.mapModel.updateFog(_node.x,_node.y,2);
            return;
         }
         if(_node && _count == 10)
         {
            _count = _count + 1;
            _loc1_ = ComponentFactory.Instance.creatCustomObject("asset.campaign.TranseferOverAsset");
            _loc2_ = new SimpleMovie(_loc1_,armyViewPos);
            if(selfArmyView && selfArmyView.parent)
            {
               selfArmyView.parent.addChild(_loc2_);
            }
            _loc2_.x = _node.x;
            _loc2_.y = _node.y;
            return;
         }
         if(!_node && CampaignManager.instance.mapModel)
         {
            _node = CampaignManager.instance.mapModel.getNodeById(_nodeId);
            if(!_node)
            {
               return;
            }
            if(_node.hasOwnProperty("isPlaying"))
            {
               _node["isPlaying"] = true;
            }
         }
         wait();
      }
      
      private function armyViewPos() : void
      {
         var _loc3_:CampaignNode = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         if(selfArmyView)
         {
            selfArmyView.x = _node.x;
            selfArmyView.y = _node.y;
            selfArmyView.alpha = 0.3;
            selfArmyView.aiInfo.pathInfo = [];
            _loc3_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
            _loc1_ = _loc3_.resetPosX * 20;
            _loc2_ = _loc3_.resetPosY * 20;
            selfArmyView.avatarView.angle = HeroAvatarViewHelper.twoPointAngle(_loc1_,_loc2_,selfArmyView.x,selfArmyView.y);
            TweenMax.to(selfArmyView,0.6,{
               "x":_loc1_,
               "y":_loc2_,
               "alpha":1,
               "onComplete":transeferCallBack
            });
         }
         else
         {
            transeferCallBack();
         }
      }
      
      private function wait() : void
      {
         if(_count > 250)
         {
            dispose();
         }
      }
      
      override public function dispose() : void
      {
         var _loc3_:CampaignNode = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         super.dispose();
         if(selfArmyView)
         {
            _loc3_ = CampaignManager.instance.mapModel.getMapNodesById(_nodeId);
            _loc1_ = _loc3_.resetPosX * 20;
            _loc2_ = _loc3_.resetPosY * 20;
            selfArmyView.x = _loc1_;
            selfArmyView.y = _loc2_;
         }
      }
      
      private function transeferCallBack() : void
      {
         if(selfArmyView)
         {
            selfArmyView.alpha = 1;
         }
         dispose();
      }
      
      private function get selfArmyView() : Object
      {
         var _loc2_:* = null;
         var _loc1_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc1_ && _loc1_.selfMemberData)
         {
            return CampaignManager.instance.controller.getArmyView(_loc1_.selfMemberData);
         }
         return null;
      }
   }
}

