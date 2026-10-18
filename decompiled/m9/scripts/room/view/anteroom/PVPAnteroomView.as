package room.view.anteroom
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import logging.LoggerSys;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.utils.SimpleDictionary;
   
   public class PVPAnteroomView extends Component
   {
      
      private const PLAYER_COUNT:int = 4;
      
      private var _roomInfo:RoomInfo;
      
      private var _playerList:Vector.<PVPRoomPlayerFigure>;
      
      private var _pointArray:Vector.<Point>;
      
      private var _back:Bitmap;
      
      private var _backEffect:MovieImage;
      
      private var initWidth:int;
      
      private var initHeight:int;
      
      private var _playerListPos:SimpleDictionary = new SimpleDictionary(true);
      
      public function PVPAnteroomView(param1:RoomInfo)
      {
         super();
         model = param1;
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.baseroom.enterRoomBG");
         addChild(_back);
         _backEffect = ComponentFactory.Instance.creatComponentByStylename("baseroom.enterRoomEffect");
         addChild(_backEffect);
         initWidth = _back.width;
         initHeight = _back.height;
         getPoint();
         initPlayerList();
         refreshPlayerData();
      }
      
      private function addEvent() : void
      {
         RoomManager.instance.roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
         RoomManager.instance.roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
         RoomManager.instance.roomInfo.addEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function refreshPlayerData() : void
      {
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc4_:CampaignArmy = null;
         var _loc1_:String = null;
         var _loc5_:* = null;
         _loc2_ = 0;
         while(_loc2_ < _playerList.length)
         {
            _loc4_ = RoomManager.instance.roomInfo.getPlayerByPos(_loc2_);
            if(_loc4_)
            {
               if(_loc4_.userId == thane.userId)
               {
                  _loc3_ = true;
               }
               showFigure(_loc4_);
            }
            _loc2_++;
         }
         if(!_loc3_)
         {
            _loc1_ = "************************";
            for each(_loc5_ in _playerList)
            {
               if(_loc5_.data)
               {
                  _loc1_ += _loc5_.data.userId + " position : : " + _loc5_.data.pos + " state : : : " + _loc5_.data.roomState + "";
               }
            }
            LoggerSys.info("this room doesn\'t has self : : " + _loc1_);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         var _loc7_:Number = NaN;
         var _loc6_:int = 0;
         var _loc5_:Object = null;
         var _loc4_:Number = param1 / initWidth;
         var _loc3_:Number = param2 / 900;
         if(param2 >= 600 && param2 <= 650)
         {
            _loc7_ = 0.8 + (param2 - 600) * 0.2 / 50;
         }
         else if(param2 > 650)
         {
            _loc7_ = 1;
         }
         else if(param2 < 600)
         {
            _loc7_ = 0.8;
         }
         _back.x = (param1 - _back.width) / 2;
         _back.y = -(_back.height - param2);
         _backEffect.x = _back.x;
         _backEffect.y = _back.y;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc5_ = _playerListPos[_playerList[_loc6_]];
            _loc5_.target.scaleX = _loc7_;
            _loc5_.target.scaleY = _loc7_;
            _loc5_.target.x = _loc5_.x * _loc4_ + 60 * _loc4_;
            _loc5_.target.y = StageReferance.stageHeight - _loc5_.y;
            _loc5_.target.cacheAsBitmap = true;
            _loc6_++;
         }
      }
      
      private function getPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         _pointArray = new Vector.<Point>();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("roomPVP.PlayerFigure_" + _loc1_);
            _pointArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function __addPlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_)
         {
            showFigure(_loc2_);
         }
      }
      
      private function __removePlayerHandler(param1:RoomEvent) : void
      {
         var _loc2_:CampaignArmy = param1.data as CampaignArmy;
         if(_loc2_)
         {
            hideFigure(_loc2_);
         }
      }
      
      private function __houseOwnerChangeHandler(param1:RoomEvent) : void
      {
         for each(var _loc2_:PVPRoomPlayerFigure in _playerList)
         {
            _loc2_.updateOwnerState();
         }
      }
      
      private function initPlayerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:PVPRoomPlayerFigure = null;
         _playerList = new Vector.<PVPRoomPlayerFigure>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = new PVPRoomPlayerFigure();
            _loc2_.x = _pointArray[_loc1_].x;
            _loc2_.y = _pointArray[_loc1_].y;
            _loc2_.placeState = _roomInfo.placesState[_loc1_];
            _loc2_.index = _loc1_;
            addChild(_loc2_);
            _playerList.push(_loc2_);
            _playerListPos.add(_loc2_,{
               "x":_loc2_.x,
               "y":_loc2_.y,
               "width":_loc2_.width,
               "height":_loc2_.height,
               "target":_loc2_
            });
            _loc1_++;
         }
      }
      
      public function showFigure(param1:CampaignArmy) : void
      {
         var _loc2_:PVPRoomPlayerFigure = _playerList[param1.pos] as PVPRoomPlayerFigure;
         _loc2_.data = param1;
      }
      
      public function hideFigure(param1:CampaignArmy) : void
      {
         var _loc2_:PVPRoomPlayerFigure = _playerList[param1.pos] as PVPRoomPlayerFigure;
         _loc2_.data = null;
      }
      
      public function set model(param1:RoomInfo) : void
      {
         _roomInfo = param1;
      }
      
      public function get model() : RoomInfo
      {
         return _roomInfo;
      }
      
      override public function dispose() : void
      {
         _playerListPos.clear();
         removeEvent();
         _pointArray = null;
         for each(var _loc1_:PVPRoomPlayerFigure in _playerList)
         {
            if(_loc1_)
            {
               _loc1_.dispose();
            }
            _loc1_ = null;
         }
         _playerList = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

