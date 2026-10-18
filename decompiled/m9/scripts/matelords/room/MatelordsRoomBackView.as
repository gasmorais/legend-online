package matelords.room
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.geom.Point;
   import managers.RoomManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.room.RoomInfo;
   import yishi.utils.SimpleDictionary;
   import yishi.view.base.OutyardBorderLayer;
   
   public class MatelordsRoomBackView extends Sprite implements Disposeable
   {
      
      private const PLAYER_COUNT:int = 2;
      
      private var _roomInfo:RoomInfo;
      
      private var _playerList:Vector.<MatelordsRoomPlayerView>;
      
      private var _pointArray:Vector.<Point>;
      
      private var _back:Bitmap;
      
      private var _backEffect:MovieClip;
      
      private var _borderView:OutyardBorderLayer;
      
      private var _blackBack:Component;
      
      private var initWidth:int;
      
      private var initHeight:int;
      
      private var _centerX:int;
      
      private var _centerY:int;
      
      private var _playerListPos:SimpleDictionary = new SimpleDictionary(true);
      
      private var _bgEffect2:MovieClip;
      
      public function MatelordsRoomBackView(param1:RoomInfo)
      {
         model = param1;
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.matelordsroom.RoomBg");
         _bgEffect2 = ComponentFactory.Instance.creatCustomObject("matedsroom.RoomBgEffect");
         _borderView = new OutyardBorderLayer(_back.width,_back.height);
         _blackBack = new Component();
         initWidth = _back.width;
         initHeight = _back.height;
         addChild(_blackBack);
         addChild(_back);
         addChild(_borderView);
         _bgEffect2.x = _back.x + 145;
         _bgEffect2.y = _back.y + 275;
         getPoint();
         addChild(_bgEffect2);
         initPlayerList();
         refreshPlayerData();
         _bgEffect2.play();
         setBlackBack();
      }
      
      private function setBlackBack() : void
      {
         _blackBack.graphics.clear();
         _blackBack.graphics.beginFill(0,1);
         _blackBack.graphics.drawRect(0,0,StageReferance.stageWidth,StageReferance.stageWidth);
         _blackBack.graphics.endFill();
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeAllChildren(this);
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
         for each(var _loc2_:MatelordsRoomPlayerView in _playerList)
         {
            _loc2_.updateOwnerState();
         }
      }
      
      public function showFigure(param1:CampaignArmy) : void
      {
         for each(var _loc2_:MatelordsRoomPlayerView in _playerList)
         {
            if(_loc2_.index == param1.pos)
            {
               _loc2_.data = param1;
               _loc2_.state = 1;
               break;
            }
         }
      }
      
      public function hideFigure(param1:CampaignArmy) : void
      {
         var _loc2_:MatelordsRoomPlayerView = _playerList[param1.pos] as MatelordsRoomPlayerView;
         _loc2_.data = null;
         _loc2_.state = 0;
      }
      
      private function getPoint() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Point = null;
         _pointArray = new Vector.<Point>();
         _loc1_ = 1;
         while(_loc1_ <= 2)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("matelords.PlayerView_" + _loc1_);
            _pointArray.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function initPlayerList() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MatelordsRoomPlayerView = null;
         _playerList = new Vector.<MatelordsRoomPlayerView>();
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = new MatelordsRoomPlayerView();
            _loc2_.x = _pointArray[_loc1_].x;
            _loc2_.y = _pointArray[_loc1_].y;
            _loc2_.placeState = _roomInfo.placesState[_loc1_];
            _loc2_.index = _loc1_;
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
         addChild(_playerList[1]);
         addChild(_playerList[0]);
      }
      
      private function refreshPlayerData() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MatelordsRoomPlayerView = null;
         var _loc3_:CampaignArmy = null;
         _loc1_ = 0;
         while(_loc1_ < 2)
         {
            _loc2_ = _playerList[_loc1_] as MatelordsRoomPlayerView;
            _loc3_ = RoomManager.instance.roomInfo.getPlayerByPos(_loc1_);
            if(_loc3_)
            {
               showFigure(_loc3_);
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
         _back.y = -(900 - param2);
         _borderView.x = _back.x - 5;
         _borderView.y = _back.y - 5;
         _bgEffect2.x = _back.x + 145;
         _bgEffect2.y = _back.y + 275;
         _loc6_ = 0;
         while(_loc6_ < 2)
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
      
      public function set model(param1:RoomInfo) : void
      {
         _roomInfo = param1;
      }
      
      public function get model() : RoomInfo
      {
         return _roomInfo;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_borderView);
         _borderView = null;
         ObjectUtils.disposeObject(_blackBack);
         _blackBack = null;
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

