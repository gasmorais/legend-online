package map.internals.view.team
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.team.MemberFightPos;
   import events.FreedomTeamEvent;
   import manager.LanguageMgr;
   import managers.FreedomTeamManager;
   import managers.FreedomTeamSocketOutManager;
   import map.internals.view.team.sort.FreedomTeamSortCell;
   import mvc.module.armyII.BaseArmy;
   import mvc.module.team.FreedomTeamModel;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.SimpleDictionary;
   
   public class FreedomTeamSortFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Scale9CornerImage;
      
      private var _itemList:SimpleDictionary;
      
      private var _posList:Array;
      
      private var _legitPosList:Array;
      
      private var isCaptain:Boolean;
      
      public function FreedomTeamSortFrame()
      {
         super();
         initView();
         addEvent();
         FreedomTeamSocketOutManager.sendEditTeamFightPos();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:FreedomTeamSortCell = null;
         escEnable = true;
         titleText = LanguageMgr.GetTranslation("teammanager.pve.TeamSortFrame.title");
         _itemList = new SimpleDictionary();
         _posList = [3,2,1,6,5,4,9,8,7,12,11,10];
         _legitPosList = [0,2,3,5,6,8,9,11];
         _bg = ComponentFactory.Instance.creatComponentByStylename("teammanager.TeamSortBg");
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("teammanager.TeamSortBg2");
         addToContent(_bg);
         addToContent(_bg2);
         isCaptain = model.captainId == playerInfo.userId;
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            if(_legitPosList.indexOf(_loc1_) != -1)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("team.FreedomTeamSortCell");
               _loc2_.x = _loc1_ % 3 * (_loc2_.displayWidth + 10) + 27;
               _loc2_.y = int(_loc1_ / 3) * (_loc2_.displayHeight + 10) - 10;
               if(_loc1_ % 3 == 0)
               {
                  _loc2_.backTxt.setFrame(3);
               }
               if(_loc1_ % 3 == 1)
               {
                  _loc2_.backTxt.setFrame(2);
               }
               if(_loc1_ % 3 == 2)
               {
                  _loc2_.backTxt.setFrame(1);
               }
               if(_loc1_ % 3 == 2)
               {
                  _loc2_.x = _loc2_.displayWidth + 70;
               }
               _loc2_.pos = _posList[_loc1_];
               _loc2_.dragEnable = isCaptain;
               _itemList.add(_loc2_.pos,_loc2_);
               addToContent(_loc2_);
            }
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.addEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
         for each(var _loc1_:FreedomTeamSortCell in _itemList)
         {
            _loc1_.addEventListener("EDIT_TEAM_FIGHT_POS",__editTeamFightPos);
         }
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_UPDATE",__teamInfoUpdateHandler);
         NotificationManager.instance.removeEventListener("TEAM_INFO_SYNC",__teamInfoUpdateHandler);
         for each(var _loc1_:FreedomTeamSortCell in _itemList)
         {
            if(_loc1_)
            {
               _loc1_.removeEventListener("EDIT_TEAM_FIGHT_POS",__editTeamFightPos);
            }
         }
      }
      
      private function __teamInfoUpdateHandler(param1:FreedomTeamEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:BaseArmy = null;
         if(FreedomTeamManager.instance.hasTeam)
         {
            clean();
            _loc3_ = model.armyFightPos;
            for each(var _loc2_:MemberFightPos in _loc3_)
            {
               _loc4_ = model.getMemberByUserId(_loc2_.memberId);
               if(_loc4_ && _itemList[_loc2_.pos])
               {
                  _itemList[_loc2_.pos].hero = _loc4_.baseHero;
               }
            }
         }
         else
         {
            dispose();
         }
      }
      
      private function clean() : void
      {
         for each(var _loc1_:FreedomTeamSortCell in _itemList)
         {
            _loc1_.hero = null;
         }
      }
      
      private function __editTeamFightPos(param1:FreedomTeamEvent) : void
      {
         var _loc2_:Object = null;
         var _loc4_:Array = [];
         for each(var _loc3_:FreedomTeamSortCell in _itemList)
         {
            if(_loc3_.hero)
            {
               _loc2_ = {};
               _loc2_.userId = _loc3_.hero.userId;
               _loc2_.heroPos = _loc3_.pos;
               _loc4_.push(_loc2_);
            }
         }
         FreedomTeamSocketOutManager.sendEditTeamFightPos(false,_loc4_);
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode != 2)
         {
            dispose();
         }
      }
      
      private function get model() : FreedomTeamModel
      {
         return FreedomTeamManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         DragManager.getInstance().stopDrag();
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         _bg = null;
         _bg2 = null;
         for each(var _loc1_:FreedomTeamSortCell in _itemList)
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

