package yishi.actions.map
{
   import com.greensock.TweenMax;
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import map.campaign.CampaignManager;
   import yishi.scene.SceneManager;
   import yishi.view.tools.SimpleMovie;
   
   public class TranseferAction extends MapBaseAction
   {
      
      private var _target:Object;
      
      private var _posX:int;
      
      private var _posY:int;
      
      private var _action:String;
      
      private var _count:int;
      
      public function TranseferAction(param1:Object, param2:int, param3:int, param4:String)
      {
         super();
         _target = param1;
         _posX = param2;
         _posY = param3;
         _action = param4;
      }
      
      override public function prepare() : void
      {
         if(!isMapScene)
         {
            dispose();
            return;
         }
         selfArmyView.alpha = 0;
         selfArmyView.aiInfo.pathInfo = [];
         super.prepare();
      }
      
      private function get isMapScene() : Boolean
      {
         var _loc1_:String = SceneManager.instance.currentType;
         var _loc2_:String = _loc1_;
         if("CAMPAIGN_MAP_SCENE" !== _loc2_)
         {
            return false;
         }
         return true;
      }
      
      override public function update() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:SimpleMovie = null;
         if(!isMapScene)
         {
            dispose();
            return;
         }
         selfArmyView.x = _posX;
         selfArmyView.y = _posY;
         if(_count == 0)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("asset.campaign.TranseferOutAsset");
            _loc2_ = new SimpleMovie(_loc1_,dispose);
            _target.parent.addChild(_loc2_);
            if(_target.hasOwnProperty("isPlaying"))
            {
               _target["isPlaying"] = true;
            }
            _loc2_.x = _posX;
            _loc2_.y = _posY;
            selfArmyView.alpha = 1;
            TweenMax.to(selfArmyView,0.8,{"alpha":0});
         }
         if(_count == 100)
         {
            dispose();
         }
         _count = _count + 1;
      }
      
      override public function dispose() : void
      {
         if(_finished)
         {
            return;
         }
         super.dispose();
         if(selfArmyView)
         {
            TweenMax.killTweensOf(selfArmyView);
         }
      }
      
      private function get selfArmyView() : Object
      {
         var _loc1_:Object = null;
         if(CampaignManager.instance.mapModel.selfMemberData)
         {
            _loc1_ = CampaignManager.instance.controller.getArmyView(CampaignManager.instance.mapModel.selfMemberData);
         }
         return _loc1_;
      }
   }
}

