package teammanager
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.geom.Point;
   import manager.LanguageMgr;
   import managers.GroupfbManager;
   import mvc.module.groupfb.GroupfbPlayerInfo;
   import mvc.module.groupfb.GroupfbSender;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.DragManager;
   import yishi.manager.NotificationManager;
   import yishi.utils.MsgMan;
   
   public class GroupSortFrame extends Frame
   {
      
      private var _vBox:VBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _isCreater:Boolean;
      
      private var _cellList:Vector.<GroupSortCell>;
      
      private var _tabList:Vector.<SelectedButton>;
      
      private const CELL_COUNT:uint = 8;
      
      private const CELL_ROW_COUNT:uint = 2;
      
      private const TAB_COUNT:uint = 2;
      
      private const SERVER_POS_LIST:Vector.<uint> = new <uint>[3,1,6,4,9,7,12,10];
      
      private const BACK_GROUND_POS:Point = new Point(24,15);
      
      private const CELL_START_POS_X:uint = 68;
      
      private const CLEE_H_GAP:uint = 40;
      
      private const CLEE_V_GAP:uint = 8;
      
      public function GroupSortFrame()
      {
         super();
         initView();
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function set isCreater(param1:Boolean) : void
      {
         _isCreater = param1;
         for each(var _loc2_:GroupSortCell in _cellList)
         {
            _loc2_.dragEnable = param1;
         }
      }
      
      private function initView() : void
      {
         var _loc1_:SelectedButton = null;
         var _loc5_:* = 0;
         var _loc2_:GroupSortCell = null;
         var _loc4_:* = 0;
         titleText = LanguageMgr.GetTranslation("teammanager.pve.TeamSortFrame.title");
         _btnGroup = new SelectedButtonGroup();
         _vBox = ComponentFactory.Instance.creatComponentByStylename("groupSortFrame.tabVBox");
         addToContent(_vBox);
         _tabList = new Vector.<SelectedButton>();
         _loc5_ = 0;
         while(_loc5_ < 2)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("groupSortFrame.tab" + _loc5_);
            _tabList.push(_loc1_);
            _vBox.addChild(_loc1_);
            _btnGroup.addSelectItem(_loc1_);
            _loc5_++;
         }
         var _loc3_:Bitmap = ComponentFactory.Instance.creatBitmap("asset.teammanger.teamBg");
         _loc3_.x = BACK_GROUND_POS.x;
         _loc3_.y = BACK_GROUND_POS.y;
         addToContent(_loc3_);
         _cellList = new Vector.<GroupSortCell>();
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("teammanager.GroupSortCell");
            _cellList.push(_loc2_);
            _loc2_.backTxt.setFrame(_loc4_ % 2 == 0 ? 3 : 1);
            _loc2_.x = 68 + _loc4_ % 2 * (_loc2_.displayWidth + 40);
            _loc2_.y = _vBox.y + int(_loc4_ / 2) * (_loc2_.displayHeight + 8);
            addToContent(_loc2_);
            _loc4_++;
         }
      }
      
      private function addEvent() : void
      {
         addEventListener("response",responseHandler);
         for each(var _loc1_:GroupSortCell in _cellList)
         {
            _loc1_.addEventListener("CHANGE_POS_EVENT",changePlayerPosHandler);
         }
         MsgMan.addObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,teamUpdateHandler);
         _btnGroup.addEventListener("change",tabChangeHandler);
         NotificationManager.instance.addEventListener("START_DRAG",startDragHandler);
         NotificationManager.instance.addEventListener("END_DRAG",endDragHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",responseHandler);
         for each(var _loc1_:GroupSortCell in _cellList)
         {
            _loc1_.removeEventListener("CHANGE_POS_EVENT",changePlayerPosHandler);
         }
         _btnGroup.removeEventListener("change",tabChangeHandler);
         NotificationManager.instance.removeEventListener("START_DRAG",startDragHandler);
         NotificationManager.instance.removeEventListener("END_DRAG",endDragHandler);
         MsgMan.removeObserver("PVPRoomListEvent.GROUP_ROOM_UPDATE",this,teamUpdateHandler);
      }
      
      private function responseHandler(param1:FrameEvent) : void
      {
         if(param1.responseCode != 2)
         {
            dispose();
         }
      }
      
      private function startDragHandler(param1:NotificationEvent) : void
      {
         var targetRowCellList:Vector.<GroupSortCell>;
         var curCell:GroupSortCell;
         var e:NotificationEvent = param1;
         var getRowCellsByRowIndex:* = function(param1:uint):Vector.<GroupSortCell>
         {
            var _loc3_:* = 0;
            var _loc2_:Vector.<GroupSortCell> = new Vector.<GroupSortCell>();
            _loc3_ = 0;
            while(_loc3_ < 2)
            {
               _loc2_.push(_cellList[param1 * 2 + _loc3_]);
               _loc3_++;
            }
            return _loc2_;
         };
         var getNoDropCells:* = function(param1:Vector.<GroupSortCell>):Vector.<GroupSortCell>
         {
            var _loc3_:Vector.<GroupSortCell> = new Vector.<GroupSortCell>();
            if(param1.indexOf(dragCell) < 0)
            {
               for each(var _loc2_:GroupSortCell in param1)
               {
                  if(_loc2_.hero == null)
                  {
                     _loc3_.push(_loc2_);
                  }
               }
               if(_loc3_.length == param1.length)
               {
                  _loc3_.length = 0;
               }
            }
            return _loc3_;
         };
         var dragCell:GroupSortCell = e.data as GroupSortCell;
         var totalRowCount:uint = _cellList.length / 2;
         var rowIndex:uint = 0;
         while(rowIndex < totalRowCount)
         {
            targetRowCellList = getRowCellsByRowIndex(rowIndex);
            targetRowCellList = getNoDropCells(targetRowCellList);
            for each(curCell in targetRowCellList)
            {
               curCell.setCellStatus(true);
            }
            rowIndex = rowIndex + 1;
         }
      }
      
      private function endDragHandler(param1:NotificationEvent) : void
      {
         for each(var _loc2_:GroupSortCell in _cellList)
         {
            _loc2_.setCellStatus(false);
         }
      }
      
      private function tabChangeHandler(param1:Event) : void
      {
         updateUIByIndex(_btnGroup.selectIndex);
      }
      
      private function changePlayerPosHandler(param1:Event) : void
      {
         var _loc2_:GroupfbPlayerInfo = null;
         var _loc5_:ThaneInfo = null;
         var _loc3_:GroupSortCell = null;
         var _loc4_:* = 0;
         _loc4_ = 0;
         while(_loc4_ < 8)
         {
            _loc3_ = _cellList[_loc4_];
            _loc5_ = _loc3_.hero;
            if(_loc5_ != null)
            {
               _loc2_ = getGroupfbPlayerInfoByUserId(_loc5_.userId);
               _loc2_.pos = viewIndexToServerIndex(_loc4_);
            }
            _loc4_++;
         }
      }
      
      private function teamUpdateHandler(param1:String, param2:Object) : void
      {
         updateUIByIndex(_btnGroup.selectIndex);
      }
      
      private function updateUIByIndex(param1:int) : void
      {
         var _loc4_:GroupSortCell = null;
         var _loc6_:ThaneInfo = null;
         var _loc5_:* = 0;
         for each(_loc4_ in _cellList)
         {
            _loc4_.hero = null;
         }
         var _loc2_:Vector.<GroupfbPlayerInfo> = GroupfbManager.instance.model.selfTeam.getTeamList(param1 + 1);
         for each(var _loc3_:GroupfbPlayerInfo in _loc2_)
         {
            _loc6_ = new ThaneInfo();
            _loc6_.templateId = _loc3_.templateId;
            _loc6_.headId = _loc3_.headID;
            _loc6_.nickName = _loc3_.nickName;
            _loc6_.grades = _loc3_.grades;
            _loc6_.userId = _loc3_.userId;
            _loc6_.fightingCapacity = _loc3_.fightCapacity;
            _loc5_ = serverIndexToViewIndex(_loc3_.pos);
            _loc4_ = _cellList[_loc5_];
            _loc4_.hero = _loc6_;
         }
         isCreater = GroupfbManager.instance.model.isCaptain;
      }
      
      private function serverIndexToViewIndex(param1:uint) : uint
      {
         return SERVER_POS_LIST.indexOf(param1);
      }
      
      private function viewIndexToServerIndex(param1:uint) : uint
      {
         return SERVER_POS_LIST[param1];
      }
      
      private function getGroupfbPlayerInfoByUserId(param1:uint) : GroupfbPlayerInfo
      {
         var _loc2_:GroupfbPlayerInfo = null;
         var _loc3_:Vector.<GroupfbPlayerInfo> = GroupfbManager.instance.model.selfTeam.list;
         for each(var _loc4_:GroupfbPlayerInfo in _loc3_)
         {
            if(_loc4_.userId == param1)
            {
               _loc2_ = _loc4_;
               break;
            }
         }
         return _loc2_;
      }
      
      public function show() : void
      {
         addEvent();
         _btnGroup.selectIndex = 0;
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         DragManager.getInstance().stopDrag();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         GroupfbSender.editPos();
      }
   }
}

