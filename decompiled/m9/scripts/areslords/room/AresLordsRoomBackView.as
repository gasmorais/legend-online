package areslords.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.geom.Point;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import utils.LogicUtils;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.OutyardBorderLayer;
   
   public class AresLordsRoomBackView extends Component
   {
      
      private const PLAYER_COUNT:int = 1;
      
      private var _roomInfo:RoomInfo;
      
      private var _player:AresLordsRoomPlayerView;
      
      private var _point:Point;
      
      private var _back:Bitmap;
      
      private var _borderView:OutyardBorderLayer;
      
      private var _blackBack:Component;
      
      private var initWidth:int;
      
      private var initHeight:int;
      
      private var _centerX:int;
      
      private var _centerY:int;
      
      private var _playerListPos:SimpleDictionary = new SimpleDictionary(true);
      
      public function AresLordsRoomBackView(param1:RoomInfo)
      {
         model = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.areslordsroom.RoomBg");
         _borderView = new OutyardBorderLayer(_back.width,_back.height);
         _blackBack = new Component();
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
         _blackBack.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageWidth);
         _blackBack.graphics.endFill();
      }
      
      private function addEvent() : void
      {
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.addEventListener("ADD_PLAYER_ROOM",__addPlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("REMOVE_PLAYER_ROOM",__removePlayerHandler);
            RoomManager.instance.roomInfo.addEventListener("room_HouseOwner_change",__houseOwnerChangeHandler);
         }
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
         _player.updateOwnerState();
      }
      
      public function showFigure(param1:CampaignArmy) : void
      {
         _player.data = param1;
         _player.state = 1;
      }
      
      public function hideFigure(param1:CampaignArmy) : void
      {
         _player.data = null;
         _player.state = 0;
      }
      
      private function getPoint() : void
      {
         _point = ComponentFactory.Instance.creatCustomObject("areslords.PlayerPoint");
      }
      
      private function initPlayerList() : void
      {
         _player = new AresLordsRoomPlayerView();
         _player.x = _point.x;
         _player.y = _point.y;
         _player.placeState = _roomInfo.placesState[0];
         _playerListPos.add(_player,{
            "x":_player.x,
            "y":_player.y,
            "width":_player.width,
            "height":_player.height,
            "target":_player
         });
         addChild(_player);
      }
      
      private function refreshPlayerData() : void
      {
         var _loc1_:CampaignArmy = RoomManager.instance.roomInfo.getPlayerByPos(0);
         if(_loc1_)
         {
            showFigure(_loc1_);
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
         _back.y = -(900 - param2);
         _borderView.x = _back.x - 5;
         _borderView.y = _back.y - 5;
         _loc6_ = 0;
         while(_loc6_ < 1)
         {
            _loc5_ = _playerListPos[_player];
            _loc5_.target.scaleX = _loc7_;
            _loc5_.target.scaleY = _loc7_;
            _loc5_.target.x = _loc5_.x * _loc4_ + 60 * _loc4_;
            _loc5_.target.y = StageReferance.stageHeight - _loc5_.y;
            _loc5_.target.cacheAsBitmap = true;
            _loc6_++;
         }
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
         super.dispose();
      }
   }
}

