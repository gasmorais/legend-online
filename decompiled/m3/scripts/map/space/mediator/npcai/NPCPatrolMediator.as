package map.space.mediator.npcai
{
   import map.internals.data.SpaceNode;
   import yishi.events.AiEvents;
   import yishi.interfaces.IEnterFrame;
   import yishi.interfaces.IMediator;
   import yishi.manager.EnterFrameManager;
   
   public class NPCPatrolMediator implements IMediator, IEnterFrame
   {
      
      private var _npc:Object;
      
      private var _count:int;
      
      private var _diff:int = 100;
      
      public function NPCPatrolMediator()
      {
         super();
      }
      
      public function enterFrame() : void
      {
         _count = _count + 1;
         if(_count % 100 == 0)
         {
            if(_npc.aiInfo.moveState == 3)
            {
               _npc.aiInfo.moveState = 5;
            }
         }
         if(_count % _diff == 0)
         {
            if(_npc.aiInfo.moveState == 5)
            {
               _npc.aiInfo.moveState = 3;
               _diff = int(Math.random() * 20) * 25 + 100;
            }
         }
      }
      
      public function register(param1:Object) : void
      {
         _npc = param1;
         if(_npc && (_npc.nodeInfo as SpaceNode).info.types == 1)
         {
            _npc.aiInfo.moveState = 5;
            __moveStateHandler(null);
            _npc.aiInfo.addEventListener("moveState",__moveStateHandler);
            EnterFrameManager.instance.registeEnterFrame(this);
         }
      }
      
      public function unregister(param1:Object) : void
      {
         _npc.aiInfo.removeEventListener("moveState",__moveStateHandler);
         EnterFrameManager.instance.unRegisteEnterFrame(this);
      }
      
      private function __moveStateHandler(param1:AiEvents) : void
      {
         if(_npc.nodeInfo.info.state != 1)
         {
            return;
         }
         if(_npc.aiInfo.moveState == 3)
         {
            _npc.aiInfo.pathInfo = [];
         }
         else if(_npc.aiInfo.moveState == 5)
         {
            _npc.aiInfo.pathInfo = _npc.pathCache;
         }
      }
   }
}

