package map.space.view.physics
{
   import avatar.data.AvatarStaticData;
   import avatar.view.HeroAvatar;
   import avatar.view.SimpleAvatarView;
   import chat.datas.ChatFactory;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import managers.MarryManager;
   import map.internals.data.MapPhysics;
   import map.internals.data.PhysicsEvent;
   import map.internals.data.SpaceNode;
   import map.internals.interfaces.IBaseMouseEvent;
   import map.internals.view.hero.HeroAvatarView;
   import mvc.module.marry.MarryCarInfo;
   import mvc.module.marry.MarryModel;
   import yishi.datas.ai.AIBaseInfo;
   import yishi.manager.PathManager;
   import yishi.utils.MsgMan;
   
   public class MarryCarView extends HeroAvatarView implements IBaseMouseEvent
   {
      
      private var _carInfo:MarryCarInfo;
      
      private var _nodeInfo:MapPhysics;
      
      private var _chatPopView:Component;
      
      private var _attackView:SimpleAvatarView;
      
      public function MarryCarView()
      {
         super();
         mouseChildren = false;
         mouseEnabled = false;
      }
      
      public function get carInfo() : MarryCarInfo
      {
         return _carInfo;
      }
      
      public function set carInfo(param1:MarryCarInfo) : void
      {
         _carInfo = param1;
      }
      
      override protected function showName(param1:String, param2:int, param3:int, param4:int, param5:int) : void
      {
         super.showName(param1,param2,param3,param4,param5);
         _npcName.width = 280;
         _npcName.x = -140;
         _npcName.y = -250;
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
            info.speed = 5;
         }
      }
      
      public function set nodeInfo(param1:MapPhysics) : void
      {
         _nodeInfo = param1;
         refreshAvatarView();
         initDataImp();
         initSpeed();
         info.pathInfo = [new Point(carInfo.firstX / 20,carInfo.firstY / 20)].concat(carInfo.pathInfo);
      }
      
      private function refreshAvatarView() : void
      {
         var _loc2_:SpaceNode = _nodeInfo as SpaceNode;
         if(!_loc2_)
         {
            return;
         }
         avatarView = new HeroAvatar(false,_loc2_.sonType.toString(),2,0,true);
         avatarView.showMountShadow = true;
         _loc2_.toward = _loc2_.sizeType == 10 ? 0 : _loc2_.toward;
         updateDirection(_loc2_.toward);
         showName(_loc2_.info.names,_loc2_.info.grade,_loc2_.info.state,_loc2_.info.types,_loc2_.nameColor);
         (avatarView as HeroAvatar).stepFrame = 4;
         var _loc3_:String = PathManager.getMarryCarPathByJob(carInfo.jobA,carInfo.jobB);
         var _loc1_:Object = createResourceLoadInfo(_loc3_,AvatarStaticData.getBaseNumByType("Stand","mount"),AvatarStaticData.getBaseNumByType("Walk","mount"),"mount");
         LoaderManagerII.instance.load(_loc3_,4,8,loaderCompleteHandler,null,null,_loc1_);
      }
      
      private function initDataImp() : void
      {
         if(_nodeInfo && _info)
         {
            addEvent();
         }
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
            if(nodeInfo && nodeInfo.info && nodeInfo.info.types == 1)
            {
               nodeInfo.move(int(x / 20),int(y / 20));
            }
         }
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
         _carInfo.isExist = false;
         MarryManager.instance.model.updateCarList(_carInfo);
         super.walkOver();
         MsgMan.notifyObserver("MarryEventType.CAR_WALK_OVER");
         dispose();
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
         return false;
      }
      
      public function attackFun() : Boolean
      {
         return false;
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
      
      private function get marryModel() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      override public function dispose() : void
      {
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(loaderCompleteHandler);
         removeEvent();
         ObjectUtils.disposeObject(_chatPopView);
         _chatPopView = null;
         ObjectUtils.disposeObject(_attackView);
         _attackView = null;
         _nodeInfo = null;
         super.dispose();
      }
   }
}

