package teammanager
{
   import army.net.ArmySocketSendManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.army.ArmyFightPosEditMsg;
   import events.RoomEvent;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import managers.RoomManager;
   import managers.RoomSocketOutManager;
   import map.campaign.data.CampaignArmy;
   import mvc.module.armyII.UserArmy;
   import mvc.module.children.ChildData;
   import mvc.module.room.RoomInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.DragManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class MatelordsSortFrame extends Frame
   {
      
      private var _teamBg:Bitmap;
      
      private var _itemList:SimpleDictionary;
      
      private var _posList:Array = [3,1,9,7];
      
      private var isTeamLeader:Boolean;
      
      public function MatelordsSortFrame()
      {
         super();
         isTeamLeader = roominfo.houseOwnerId == userArmy.userId;
         initView();
         addEvent();
         initFightPos(null);
         if(roominfo && roominfo.isCross)
         {
            RoomSocketOutManager.sendRequestCrossTeamPos(playerInfo.serviceName);
         }
         else
         {
            RoomSocketOutManager.sendRequestTeamPos();
         }
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:MatelordsTeamSortCell = null;
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("teammanager.pve.TeamSortFrame.title");
         _teamBg = ComponentFactory.Instance.creatBitmap("asset.matelordsSortFrame.itemListBack");
         _itemList = new SimpleDictionary();
         addToContent(_teamBg);
         _loc1_ = 0;
         while(_loc1_ < 4)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("matelordsSortFrame.TeamSortCell" + _loc1_);
            if(_loc1_ % 2 == 0)
            {
               _loc2_.backTxt.setFrame(3);
            }
            else
            {
               _loc2_.backTxt.setFrame(1);
            }
            _loc2_.pos = _posList[_loc1_];
            _loc2_.dragEnable = isTeamLeader;
            _itemList.add(_loc2_.pos,_loc2_);
            addToContent(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.addEventListener("UPDATE_TEAM_FIGHT_POS",initFightPos);
         }
         for each(var _loc1_:MatelordsTeamSortCell in _itemList)
         {
            _loc1_.addEventListener("CHANGE_MATELORDS_POS_EVENT",__updateView);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(RoomManager.instance.roomInfo)
         {
            RoomManager.instance.roomInfo.removeEventListener("UPDATE_TEAM_FIGHT_POS",initFightPos);
         }
         for each(var _loc1_:MatelordsTeamSortCell in _itemList)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener("CHANGE_MATELORDS_POS_EVENT",__updateView);
            }
         }
      }
      
      private function initFightPos(param1:RoomEvent) : void
      {
         var _loc5_:Object = null;
         var _loc3_:Array = roominfo.armyFightPos;
         var _loc4_:Array = [];
         for each(var _loc2_:ArmyFightPosEditMsg in _loc3_)
         {
            if(_loc2_)
            {
               _loc5_ = {};
               _loc5_.serverName = "";
               _loc5_.pos = _loc2_.heroPos;
               _loc5_.userId = _loc2_.userId;
               _loc4_.push(_loc5_);
            }
         }
         refreshView(_loc4_);
      }
      
      private function clean() : void
      {
         for each(var _loc1_:MatelordsTeamSortCell in _itemList)
         {
            if(_loc1_.hero)
            {
               _loc1_.hero = null;
            }
            if(_loc1_.child)
            {
               _loc1_.child = null;
            }
         }
      }
      
      private function refreshView(param1:Array) : void
      {
         var _loc5_:CampaignArmy = null;
         var _loc2_:int = 0;
         var _loc3_:ChildData = null;
         clean();
         for each(var _loc4_:Object in param1)
         {
            if(_loc4_)
            {
               _loc5_ = RoomManager.instance.roomInfo.getPlayerByUserId(_loc4_.userId);
               _loc2_ = getChildOrHeroPos(_loc4_.pos);
               _itemList[_loc4_.pos].hero = _loc5_.baseHero;
               _loc3_ = new ChildData();
               _loc3_.job = _loc5_.baseHero.childrenJob;
               _loc3_.growthGrade = _loc5_.baseHero.childrenGrade;
               _loc3_.fightUserId = _loc5_.baseHero.userId;
               _loc3_.fightValue = _loc5_.baseHero.childrenFightPower;
               _loc3_.name = _loc5_.baseHero.childrenName;
               _itemList[_loc2_].child = _loc3_;
            }
         }
      }
      
      private function __updateView(param1:NotificationEvent) : void
      {
         var _loc15_:Object = null;
         var _loc21_:Object = null;
         var _loc20_:Object = null;
         var _loc19_:Object = null;
         var _loc18_:Object = null;
         var _loc14_:Object = null;
         var _loc13_:Object = null;
         var _loc12_:Object = null;
         var _loc11_:Object = null;
         var _loc9_:Object = null;
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc16_:Object = null;
         var _loc17_:Object = null;
         var _loc2_:* = param1.data;
         var _loc7_:Array = [];
         var _loc8_:int = int(_loc2_.old);
         var _loc10_:int = int(_loc2_.now);
         if(_itemList[_loc10_].hero && _itemList[_loc8_].hero)
         {
            _loc15_ = {};
            _loc15_.pos = _loc10_;
            _loc15_.userId = _itemList[_loc8_].hero.userId;
            _loc7_.push(_loc15_);
            _loc21_ = {};
            _loc21_.pos = _loc8_;
            _loc21_.userId = _itemList[_loc10_].hero.userId;
            _loc7_.push(_loc21_);
         }
         else if(_itemList[_loc10_].child && _itemList[_loc8_].hero)
         {
            if(_itemList[_loc10_].child.fightUserId == _itemList[_loc8_].hero.userId)
            {
               _loc20_ = {};
               _loc20_.pos = _loc10_;
               _loc20_.userId = _itemList[_loc10_].child.fightUserId;
               _loc7_.push(_loc20_);
               if(_itemList.getList().length > 1)
               {
                  for each(var _loc3_:MatelordsTeamSortCell in _itemList)
                  {
                     if(_loc3_.hero && _loc3_.hero.userId != _itemList[_loc8_].hero.userId)
                     {
                        _loc19_ = {};
                        _loc19_.pos = _loc3_.pos;
                        _loc19_.userId = _loc3_.hero.userId;
                        _loc7_.push(_loc19_);
                     }
                  }
               }
            }
            else
            {
               _loc18_ = {};
               _loc18_.pos = _loc10_;
               _loc18_.userId = _itemList[_loc8_].hero.userId;
               _loc7_.push(_loc18_);
               _loc14_ = {};
               _loc14_.pos = getChildOrHeroPos(_loc8_);
               _loc14_.userId = _itemList[_loc10_].child.fightUserId;
               _loc7_.push(_loc14_);
            }
         }
         else if(_itemList[_loc10_].hero == null && _itemList[_loc10_].child == null && _itemList[_loc8_].hero)
         {
            _loc13_ = {};
            _loc13_.pos = _loc10_;
            _loc13_.userId = _itemList[_loc8_].hero.userId;
            _loc7_.push(_loc13_);
         }
         else if(_itemList[_loc10_].hero && _itemList[_loc8_].child)
         {
            if(_itemList[_loc10_].hero.userId == _itemList[_loc8_].child.fightUserId)
            {
               _loc12_ = {};
               _loc12_.pos = _loc8_;
               _loc12_.userId = _itemList[_loc10_].hero.userId;
               _loc7_.push(_loc12_);
               if(_itemList.getList().length > 1)
               {
                  for each(var _loc4_:MatelordsTeamSortCell in _itemList)
                  {
                     if(_loc4_.hero && _loc4_.hero.userId != _itemList[_loc10_].hero.userId)
                     {
                        _loc11_ = {};
                        _loc11_.pos = _loc4_.pos;
                        _loc11_.userId = _loc4_.hero.userId;
                        _loc7_.push(_loc11_);
                     }
                  }
               }
            }
            else
            {
               _loc9_ = {};
               _loc9_.pos = _loc8_;
               _loc9_.userId = _itemList[_loc10_].hero.userId;
               _loc7_.push(_loc9_);
               _loc5_ = {};
               _loc5_.pos = getChildOrHeroPos(_loc10_);
               _loc5_.userId = _itemList[_loc8_].child.fightUserId;
               _loc7_.push(_loc5_);
            }
         }
         else if(_itemList[_loc10_].child && _itemList[_loc8_].child)
         {
            _loc6_ = {};
            _loc6_.pos = getChildOrHeroPos(_loc10_);
            _loc6_.userId = _itemList[getChildOrHeroPos(_loc8_)].hero.userId;
            _loc7_.push(_loc6_);
            _loc16_ = {};
            _loc16_.pos = getChildOrHeroPos(_loc8_);
            _loc16_.userId = _itemList[getChildOrHeroPos(_loc10_)].hero.userId;
            _loc7_.push(_loc16_);
         }
         else
         {
            _loc17_ = {};
            _loc17_.pos = getChildOrHeroPos(_loc10_);
            _loc17_.userId = _itemList[getChildOrHeroPos(_loc8_)].hero.userId;
            _loc7_.push(_loc17_);
         }
         refreshView(_loc7_);
      }
      
      private function sendEditTeamPos() : void
      {
         var _loc1_:Object = null;
         var _loc3_:Array = [];
         for each(var _loc2_:MatelordsTeamSortCell in _itemList)
         {
            if(_loc2_.hero)
            {
               _loc1_ = {};
               _loc1_.serverName = _loc2_.hero.serviceName;
               _loc1_.userId = _loc2_.hero.userId;
               _loc1_.heroPos = _loc2_.pos;
               _loc3_.push(_loc1_);
            }
         }
         ArmySocketSendManager.sendEditTeamPos(_loc3_);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode != 2)
         {
            dispose();
         }
      }
      
      private function getChildOrHeroPos(param1:int) : int
      {
         switch(param1 - 1)
         {
            case 0:
               return 3;
            case 2:
               return 1;
            case 6:
               return 9;
            case 8:
               return 7;
            default:
               return 0;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function get roominfo() : RoomInfo
      {
         return RoomManager.instance.roomInfo;
      }
      
      private function get userArmy() : UserArmy
      {
         return ArmyManager.instance.army;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      override public function dispose() : void
      {
         DragManager.getInstance().stopDrag();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         sendEditTeamPos();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _teamBg = null;
         for each(var _loc1_:MatelordsTeamSortCell in _itemList)
         {
            if(_loc1_)
            {
               _loc1_.hero = null;
            }
            _loc1_ = null;
         }
         _itemList = null;
         _posList = null;
         super.dispose();
      }
   }
}

