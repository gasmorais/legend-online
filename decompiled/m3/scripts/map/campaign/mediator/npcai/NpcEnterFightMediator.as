package map.campaign.mediator.npcai
{
   import com.pickgliss.ui.ComponentFactory;
   import flash.display.MovieClip;
   import map.campaign.view.physics.NpcAvatarView;
   import map.internals.data.PhysicsEvent;
   import yishi.interfaces.IMediator;
   import yishi.view.tools.SimpleMovie;
   
   public class NpcEnterFightMediator implements IMediator
   {
      
      private var _npc:NpcAvatarView;
      
      private var _attackView:MovieClip;
      
      public function NpcEnterFightMediator()
      {
         super();
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1 as NpcAvatarView;
         if(_npc && _npc.nodeInfo && _npc.nodeInfo.info)
         {
            _npc.nodeInfo.info.addEventListener("UP_STATE",__updateNodeStateHandler);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         if(_npc && _npc.nodeInfo && _npc.nodeInfo.info)
         {
            _npc.nodeInfo.info.removeEventListener("UP_STATE",__updateNodeStateHandler);
         }
      }
      
      private function __updateNodeStateHandler(param1:PhysicsEvent) : void
      {
         if(!_attackView)
         {
            _attackView = ComponentFactory.Instance.creatCustomObject("asset.campaign.attack.AttackMovieAsset");
         }
         var _loc2_:SimpleMovie = new SimpleMovie(_attackView,__call);
         _npc.addChild(_loc2_);
         _attackView.y = -100;
      }
      
      private function __call() : void
      {
         if(_attackView)
         {
            if(_attackView.parent)
            {
               _attackView.parent.removeChild(_attackView);
            }
            _attackView.stop();
         }
         _attackView = null;
      }
   }
}

