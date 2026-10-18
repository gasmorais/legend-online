package map.space.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.data.SpaceNode;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.hero.HeroAvatarView;
   import map.space.SpaceManager;
   import map.space.mediator.npcai.NPCPatrolMediator;
   import mvc.module.crossguild.CrossGuildModel;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.manager.CrossGuildManager;
   import yishi.manager.MediatorMananger;
   import yishi.manager.PathManager;
   
   public class SpaceNpcView extends HeroAvatarView implements IBaseMouseEvent
   {
      
      public static const NAME:String = "map.space.view.physics.SpaceNpcView";
      
      private var _mediatorKey:String;
      
      private var _nodeInfo:MapPhysics;
      
      private var _chatPopView:Component;
      
      private var _attackView:SimpleAvatarView;
      
      private var _pathCache:Array;
      
      private var _crossGuildTxt:GradientText;
      
      private var _serverTxt:GradientText;
      
      public function SpaceNpcView(param1:String, param2:String, param3:int, param4:int)
      {
         super();
         this.mouseChildren = false;
      }
      
      private function get crossGuildModel() : CrossGuildModel
      {
         return CrossGuildManager.instance.model;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         _npcName.y = getPosYById(nodeInfo.info.id);
         if(crossGuildModel.firstGuild)
         {
            showFirstCrossGuild();
         }
      }
      
      protected function showFirstCrossGuild() : void
      {
         if(!_crossGuildTxt)
         {
            _crossGuildTxt = ComponentFactory.Instance.creatComponentByStylename("spaceNpcView.crossGuildTxt");
         }
         if(!_serverTxt)
         {
            _serverTxt = ComponentFactory.Instance.creatComponentByStylename("spaceNpcView.serverTxt");
         }
         _crossGuildTxt.text = LanguageMgr.GetTranslation("map.avatar.view.consortiaName",crossGuildModel.firstGuild.consortiaName);
         _serverTxt.text = crossGuildModel.firstGuild.serverName;
         addChild(_serverTxt);
         addChild(_crossGuildTxt);
         var _loc1_:int = getPosYById(nodeInfo.info.id);
         _serverTxt.y = _loc1_ - 16;
         _crossGuildTxt.y = _loc1_ - 32;
      }
      
      public function getPosYById(param1:int) : int
      {
         var _loc2_:int = -130;
         switch(param1)
         {
            case 3:
               _loc2_ = -190;
               break;
            case 21:
               _loc2_ = -200;
               break;
            case 28:
               _loc2_ = -140;
               break;
            default:
               _loc2_ = -130;
         }
         return _loc2_;
      }
      
      public function getTopPosY() : int
      {
         if(_crossGuildTxt && _crossGuildTxt.parent)
         {
            return _crossGuildTxt.y + 10;
         }
         return getPosYById(nodeInfo.info.id);
      }
      
      override public function set info(param1:AIBaseInfo) : void
      {
         super.info = param1;
         initDataImp();
         initSpeed();
      }
      
      private function initSpeed() : void
      {
         if(_nodeInfo && info)
         {
            if(nodeInfo.info.types == 1)
            {
               info.speed = 2;
               return;
            }
         }
      }
      
      public function set pathCache(param1:Array) : void
      {
         _pathCache = param1;
      }
      
      public function get pathCache() : Array
      {
         return _pathCache;
      }
      
      public function set nodeInfo(param1:MapPhysics) : void
      {
         _nodeInfo = param1;
         refreshAvatarView();
         initDataImp();
         initSpeed();
      }
      
      private function refreshAvatarView() : void
      {
         var _loc2_:SpaceNode = _nodeInfo as SpaceNode;
         if(!_loc2_)
         {
            return;
         }
         avatarView = new HeroAvatar(true,_loc2_.sonType.toString(),2,0,true);
         _loc2_.toward = _loc2_.sizeType == 10 ? 0 : _loc2_.toward;
         updateDirection(_loc2_.toward);
         showName(_loc2_.info.names,_loc2_.info.grade,_loc2_.info.state,_loc2_.info.types,_loc2_.nameColor);
         if(_loc2_.info.types != 1)
         {
            avatarView.angle = 90;
         }
         (avatarView as HeroAvatar).stepFrame = 4;
         var _loc3_:String = PathManager.getAvatarResourcePath(_loc2_.sonType.toString(),-1,1,"body",-1,2);
         var _loc1_:Object = createResourceLoadInfo(_loc3_,AvatarStaticData.BASE_NPC_STAND,AvatarStaticData.BASE_NPC_WALK,"body");
         LoaderManagerII.instance.load(_loc3_,4,7,loaderCompleteHandler,null,null,_loc1_);
      }
      
      private function initDataImp() : void
      {
         if(_nodeInfo && _info)
         {
            addEvent();
            initMediator();
         }
      }
      
      protected function initMediator() : void
      {
         var _loc1_:Array = [NPCPatrolMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"map.space.view.physics.SpaceNpcView");
      }
      
      private function __chatDataHandler(param1:PhysicsEvent) : void
      {
         if(_nodeInfo.chatData == null)
         {
            if(_chatPopView)
            {
               _chatPopView.dispose();
            }
            _chatPopView = null;
            return;
         }
         if(_chatPopView)
         {
            _chatPopView.dispose();
            _chatPopView = null;
         }
         if(!_chatPopView)
         {
            _chatPopView = ChatFactory.createChatPopByType(_nodeInfo.chatData,__chatBackCall);
            _chatPopView.x = -_chatPopView.displayWidth / 2;
            _chatPopView.y = _npcName.y - _chatPopView.displayHeight;
            addChild(_chatPopView);
         }
      }
      
      public function __chatBackCall() : void
      {
         _chatPopView = null;
      }
      
      override public function execute() : void
      {
         if(info.isLiving)
         {
            super.execute();
            if(nodeInfo.info.types == 1)
            {
               nodeInfo.move(int(x / 20),int(y / 20));
            }
         }
      }
      
      private function __updateAvatarHandler(param1:PhysicsEvent) : void
      {
         refreshAvatarView();
         super.info = _info;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         displayVisible = param1;
      }
      
      private function set displayVisible(param1:Boolean) : void
      {
         if(param1)
         {
            if(_avatar)
            {
               addChild(_avatar);
            }
            if(_npcName)
            {
               addChild(_npcName);
            }
         }
         else
         {
            if(_avatar && _avatar.parent)
            {
               _avatar.parent.removeChild(_avatar);
            }
            if(_npcName && _npcName.parent)
            {
               _npcName.parent.removeChild(_npcName);
            }
         }
      }
      
      override protected function nextWalk(param1:Point) : void
      {
         super.nextWalk(param1);
      }
      
      override protected function walkOver() : void
      {
         super.walkOver();
         if(nodeInfo.info.types == 1)
         {
            info.walkIndex = 0;
         }
      }
      
      private function layouTextView(param1:String) : void
      {
      }
      
      public function get nodeInfo() : MapPhysics
      {
         return _nodeInfo;
      }
      
      public function get aiInfo() : AIBaseInfo
      {
         return _info;
      }
      
      public function mouseClickHandler(param1:MouseEvent) : Boolean
      {
         if(_avatar && (_avatar as HeroAvatar).getCurrentPixels() > 50)
         {
            return attackFun();
         }
         return false;
      }
      
      public function attackFun() : Boolean
      {
         if(!SpaceManager.instance.model.mapTielsData)
         {
            return false;
         }
         SpaceManager.instance.visitSpaceNPC((nodeInfo as SpaceNode).nodeId,true);
         return true;
      }
      
      public function mouseOverHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseOutHandler(param1:MouseEvent) : Boolean
      {
         return false;
      }
      
      public function mouseMoveHandler(param1:MouseEvent) : Boolean
      {
         if(!param1)
         {
            SpaceManager.instance.model.glowTarget = this;
         }
         else if((_avatar as HeroAvatar).getCurrentPixels() > 50)
         {
            SpaceManager.instance.model.glowTarget = this;
            return true;
         }
         return false;
      }
      
      public function setGlowFilter() : void
      {
         if(_avatar)
         {
            _filter.setGlowFilter(_avatar.contentBitmap);
         }
      }
      
      public function setNormalFilter() : void
      {
         if(_avatar)
         {
            _filter.setNormalFilter(_avatar.contentBitmap);
         }
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
         removeEvent();
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
         if(_nodeInfo)
         {
            _nodeInfo.nodeView = null;
         }
         _nodeInfo = null;
         _pathCache = null;
         super.dispose();
      }
   }
}

