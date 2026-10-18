package yishi.actions.map
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import yishi.scene.SceneManager;
   import yishi.view.tools.SimpleMovie;
   
   public class TrapAction extends MapBaseAction
   {
      
      private var _target:Object;
      
      private var _count:int;
      
      public function TrapAction(param1:Object)
      {
         super();
         _target = param1;
      }
      
      override public function update() : void
      {
         var _loc1_:MovieClip = null;
         var _loc2_:SimpleMovie = null;
         if(SceneManager.instance.currentType != "CAMPAIGN_MAP_SCENE")
         {
            dispose();
            return;
         }
         if(_count == 1)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("asset.campaign.effect.TrapEffectAsset");
            _loc2_ = new SimpleMovie(_loc1_,dispose);
            _target.parent.addChild(_loc2_);
            _loc2_.x = _target.x;
            _loc2_.y = _target.y;
            _loc1_ = null;
         }
         _count = _count + 1;
      }
   }
}

