package stage3drender.avatar
{
   import avatar.data.AvatarPartInfo;
   import map.internals.data.MapPhysics;
   import map.internals.data.SpaceNode;
   import map.internals.view.hero.NpcNameView;
   import map.space.SpaceManager;
   import map.space.mediator.npcai.NPCPatrolMediator;
   import stage3drender.Global;
   import starling.display.Image;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   
   public class SpaceNpc extends AvatarRender
   {
      
      public static const NAME:String = "map.space.view.physics.SpaceNpcView";
      
      private var _mediatorKey:String;
      
      private var _pathCache:Array;
      
      private var _nodeInfo:MapPhysics;
      
      private var _shadowImg:Image;
      
      public function SpaceNpc()
      {
         super();
         _shadowImg = new Image(Global.avatarTextureDic["shadow"]);
         _shadowImg.x = -45;
         _shadowImg.y = -32;
         addChildAt(_shadowImg,0);
         _nameView = new NpcNameView();
         _nameView.heroView = this;
         Global.nameLayer.addChild(_nameView);
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(param1 && _nodeInfo)
         {
            initMediator();
         }
      }
      
      public function set nodeInfo(param1:SpaceNode) : void
      {
         _nodeInfo = param1;
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         if(aiInfo && _nodeInfo)
         {
            initMediator();
         }
         (_nameView as NpcNameView).nodeInfo = param1;
         loaderPriority = 7;
         refreshAvatarView();
         initSpeed();
      }
      
      private function initMediator() : void
      {
         var _loc1_:Array = [NPCPatrolMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.physics.SpaceNpcView");
      }
      
      override protected function setFrame() : void
      {
         _stepFrame = 5;
      }
      
      private function refreshAvatarView() : void
      {
         if(!nodeInfo)
         {
            return;
         }
         _avatarInfo = new AvatarInfo();
         nodeInfo.toward = nodeInfo.sizeType == 10 ? 0 : nodeInfo.toward;
         checkDirection(nodeInfo.toward);
         if(nodeInfo.info.types != 1)
         {
            angle = 90;
         }
         var _loc1_:AvatarPartInfo = new AvatarPartInfo();
         _loc1_.url = PathManager.getAvatarResourcePath(nodeInfo.sonType.toString(),-1,1,"body",-1,2,"");
         _loc1_.partPosition = "body";
         _avatarInfo.addPartInfo(_loc1_);
         startLoad();
      }
      
      override protected function defaultView() : void
      {
         action("S",_currentDirection);
         showOther();
         if(_nameView)
         {
            _nameView.layout();
         }
      }
      
      override public function advanceTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:AvatarPart = null;
         _step = _step + 1;
         execute();
         if(_nameView)
         {
            _nameView.execute();
         }
         if(_step % _stepFrame == 0 && _avatarPartList)
         {
            _loc2_ = int(_avatarPartList.length);
            _loc4_ = 0;
            while(_loc4_ < _loc2_)
            {
               _loc3_ = _avatarPartList[_loc4_];
               _loc3_.advanceTime(param1);
               _loc4_++;
            }
         }
      }
      
      override public function execute() : void
      {
         if(aiInfo.isLiving)
         {
            super.execute();
            if(nodeInfo.info.types == 1)
            {
               nodeInfo.move(int(x / 20),int(y / 20));
            }
         }
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         if(nodeInfo.info.types == 1)
         {
            aiInfo.walkIndex = 0;
         }
      }
      
      public function attackFun() : Boolean
      {
         if(!SpaceManager.instance.model.mapTielsData)
         {
            return false;
         }
         SpaceManager.instance.visitSpaceNPC((_nodeInfo as SpaceNode).nodeId,true);
         return true;
      }
      
      private function initSpeed() : void
      {
         if(_nodeInfo && aiInfo)
         {
            if(nodeInfo.info.types == 1)
            {
               aiInfo.speed = 2;
               return;
            }
         }
      }
      
      public function getPosYById(param1:int) : int
      {
         var _loc2_:int = -130;
         switch(param1 - 3)
         {
            case 0:
               _loc2_ = -190;
               break;
            default:
               _loc2_ = -130;
         }
         return _loc2_;
      }
      
      public function get nodeInfo() : SpaceNode
      {
         return _nodeInfo as SpaceNode;
      }
      
      public function set pathCache(param1:Array) : void
      {
         _pathCache = param1;
      }
      
      public function get pathCache() : Array
      {
         return _pathCache;
      }
      
      override public function dispose() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         super.dispose();
      }
   }
}

