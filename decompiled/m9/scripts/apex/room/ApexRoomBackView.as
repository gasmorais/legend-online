package apex.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.geom.Point;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import utils.LogicUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.OutyardBorderLayer;
   
   public class ApexRoomBackView extends Component
   {
      
      private const PLAYER_COUNT:int = 4;
      
      private var _roomInfo:RoomInfo;
      
      private var _player:ApexRoomPlayerView;
      
      private var _back:Bitmap;
      
      private var _borderView:OutyardBorderLayer;
      
      private var _blackBack:Sprite;
      
      private var initWidth:int;
      
      private var initHeight:int;
      
      private var _centerX:int;
      
      private var _centerY:int;
      
      private var _playerListPos:SimpleDictionary = new SimpleDictionary(true);
      
      private var _playerList:Vector.<ApexRoomPlayerView>;
      
      private var _pointArray:Vector.<Point>;
      
      public function ApexRoomBackView(param1:RoomInfo)
      {
         model = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.apexroom.RoomBg");
         _borderView = new OutyardBorderLayer(_back.width,_back.height);
         _blackBack = new Sprite();
         initWidth = _back.width;
         initHeight = _back.height;
         addChild(_blackBack);
         addChild(_back);
         addChild(_borderView);
         getPoint();
         initPlayerList();
         refreshPlayerData();
         setBlackBack();
      }
      
      private function setBlackBack() : void
      {
         _blackBack.graphics.clear();
         _blackBack.graphics.beginFill(0,1);
         _blackBack.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackBack.graphics.endFill();
      }
      
      private function getPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         _pointArray = new Vector.<Point>();
         _loc1_ = 1;
         while(_loc1_ <= 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("apexroom.PlayerFigure_" + _loc1_);
            _pointArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            RoomManager.instance.roomInfo.addEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
         }
      }
      
      private function removeEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.removeEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.removeEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
            RoomManager.instance.roomInfo.removeEventListener("ROOM_PLACE_STATE_CHANGE",__placeStateChangeHandler);
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
         for each(var _loc2_:ApexRoomPlayerView in _playerList)
         {
            _loc2_.updateOwnerState();
         }
      }
      
      private function __placeStateChangeHandler(param1:RoomEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:ApexRoomPlayerView = null;
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc3_ = _playerList[_loc2_] as ApexRoomPlayerView;
            _loc3_.placeState = model.placesState[_loc2_];
            _loc2_++;
         }
      }
      
      public function showFigure(param1:CampaignArmy) : void
      {
         for each(var _loc2_:ApexRoomPlayerView in _playerList)
         {
            if(_loc2_.index == param1.pos)
            {
               _loc2_.data = param1;
               break;
            }
         }
      }
      
      public function hideFigure(param1:CampaignArmy) : void
      {
         var _loc2_:ApexRoomPlayerView = _playerList[param1.pos] as ApexRoomPlayerView;
         _loc2_.data = null;
      }
      
      private function initPlayerList() : void
      {
         var _loc1_:int = 0;
         _playerList = new Vector.<ApexRoomPlayerView>();
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _player = new ApexRoomPlayerView();
            _player.x = _pointArray[_loc1_].x;
            _player.y = _pointArray[_loc1_].y;
            _player.index = _loc1_;
            _playerList.push(_player);
            _player.placeState = _roomInfo.placesState[_loc1_];
            _playerListPos.add(_player,{
               "x":_player.x,
               "y":_player.y,
               "width":_player.width,
               "height":_player.height,
               "target":_player
            });
            _loc1_++;
         }
         addChild(_playerList[1]);
         addChild(_playerList[2]);
         addChild(_playerList[0]);
         addChild(_playerList[3]);
      }
      
      private function refreshPlayerData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:CampaignArmy = null;
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = RoomManager.instance.roomInfo.getPlayerByPos(_loc1_);
            if(_loc2_)
            {
               showFigure(_loc2_);
            }
            _loc1_++;
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
         _back.y = (param2 - _back.height) / 2;
         _borderView.x = _back.x - 5;
         _borderView.y = _back.y - 5;
         _loc6_ = 0;
         while(_loc6_ < 4)
         {
            _loc5_ = _playerListPos[_playerList[_loc6_]];
            if(_loc5_)
            {
               _loc5_.target.scaleX = _loc7_;
               _loc5_.target.scaleY = _loc7_;
               _loc5_.target.x = _loc5_.x + _back.x;
               _loc5_.target.y = _back.y + _back.height - _loc5_.y;
               _loc5_.target.cacheAsBitmap = true;
            }
            _loc6_++;
         }
         _blackBack.graphics.clear();
         _blackBack.graphics.beginFill(0,1);
         _blackBack.graphics.drawRect(-200,-200,StageReferance.stage.stageWidth + 400,StageReferance.stage.stageHeight + 400);
         _blackBack.graphics.endFill();
      }
      
      public function set model(param1:RoomInfo) : void
      {
         _roomInfo = param1;
      }
      
      public function get model() : RoomInfo
      {
         return _roomInfo;
      }
      
      public function get back() : Bitmap
      {
         return _back;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_player);
         _player = null;
         ObjectUtils.disposeObject(_borderView);
         _borderView = null;
         ObjectUtils.disposeObject(_blackBack);
         _blackBack = null;
         LogicUtils.disposeDisplayCollection(_playerListPos);
         _playerListPos = null;
         LogicUtils.disposeDisplayCollection(_playerList);
         _playerList = null;
         super.dispose();
      }
   }
}

