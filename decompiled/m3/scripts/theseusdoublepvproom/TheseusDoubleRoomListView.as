package theseusdoublepvproom
{
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.TheseusRoomListEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.FocusEvent;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import managers.TheseusPvpManager;
   import mvc.controler.TheseusRoomListControler;
   import mvc.module.pveroomlist.ThsesusRoomListModel;
   import mvc.module.room.RoomInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.IMEManager;
   import yishi.view.component.TileContainer;
   
   public class TheseusDoubleRoomListView extends Component
   {
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Image;
      
      private var _filterBack:Bitmap;
      
      private var _filterTxt:Bitmap;
      
      private var _refreshBtn:BaseButton;
      
      private var _joinBtn:IconButton;
      
      private var _createBtn:IconButton;
      
      private var _listContain:TileContainer;
      
      private var _listPanel:ScrollPanel;
      
      private var ROOM_LIST_num:int = 6;
      
      private var _searchTxt:FilterFrameText;
      
      private var _searchBt:SimpleBitmapButton;
      
      private var _searchContainer:Sprite;
      
      private var _roomInfo:RoomInfo;
      
      public function TheseusDoubleRoomListView()
      {
         super();
         initView();
         initList();
         initEvent();
         __refreshHandler(null);
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomListBack1");
         _back1.x = 240;
         _back1.width = 701;
         _back1.height = 480;
         _back2 = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RoomListBack2");
         _back2.x = 245;
         _back2.width = 691;
         _back2.height = 60;
         _filterBack = ComponentFactory.Instance.creatBitmap("asset.pveroomlist.FilterBack");
         _filterBack.x = 259;
         _filterBack.y = 435;
         _filterTxt = ComponentFactory.Instance.creatBitmap("asset.theseuspve.double.roomSearch");
         _filterTxt.y = 440;
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.RefreshBtn");
         _listContain = new TileContainer();
         addChild(_back1);
         addChild(_back2);
         addChild(_filterBack);
         addChild(_filterTxt);
         addChild(_listContain);
         _listContain.rowCount = 2;
         _listContain.columnCount = 3;
         _listContain.paddingH = 5;
         _listContain.paddingV = 5;
         _listContain.width = 800;
         _joinBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuDoublespvp.joinBtn1");
         _createBtn = ComponentFactory.Instance.creatComponentByStylename("ui.theseuDoublespvp.createBtn1");
         _listPanel = ComponentFactory.Instance.creatComponentByStylename("pveroomlist.theseuspvpPlayerListPanel");
         addChild(_listPanel);
         _listPanel.setView(_listContain);
         addChild(_joinBtn);
         addChild(_createBtn);
         _searchTxt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchTextStyle1");
         _searchBt = ComponentFactory.Instance.creatComponentByStylename("shop.SearchBtn");
         _searchContainer = ComponentFactory.Instance.creatCustomObject("shop.SearchContainer");
         _searchContainer.addChild(_searchTxt);
         _searchTxt.x = -26;
         _searchContainer.addChild(_searchBt);
         _searchContainer.x = 390;
         _searchContainer.y = 437;
         addChild(_searchContainer);
         _searchTxt.text = "";
         _searchBt.x = 95;
      }
      
      private function initList() : void
      {
         var _loc3_:int = 0;
         var _loc1_:TheseusDoubleRoomItem = null;
         var _loc2_:int = int(model.roomList.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseusdoublepvproom.TheseusDoublePvpRoomItem");
            _listContain.appendItem(_loc1_);
            _loc3_++;
         }
         ROOM_LIST_num = _loc2_;
         _listPanel.invalidateViewport();
         _listPanel.commitChanges();
      }
      
      private function joinHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = "";
         control.sendSearchRoomInfo(16,control.searchId);
      }
      
      private function clickHandler(param1:MouseEvent) : void
      {
         control.sendCreateRoom();
         TheseusPvpManager.Instance.doSomething1(1);
      }
      
      private function initEvent() : void
      {
         _joinBtn.addEventListener("click",joinHandler);
         _createBtn.addEventListener("click",clickHandler);
         _refreshBtn.addEventListener("click",__refreshRoomListHandler);
         model.addEventListener("TheseusREFRESH_ROOM_LIST",__refreshHandler);
         _searchBt.addEventListener("click",__onSerachHandler);
         _searchTxt.addEventListener("focusIn",__onFocusin);
         _searchTxt.addEventListener("keyDown",__onKeydownHandler);
      }
      
      private function removeEvent() : void
      {
         _joinBtn.addEventListener("click",joinHandler);
         _createBtn.addEventListener("click",clickHandler);
         _refreshBtn.removeEventListener("click",__refreshRoomListHandler);
         model.removeEventListener("TheseusREFRESH_ROOM_LIST",__refreshHandler);
         _searchBt.removeEventListener("click",__onSerachHandler);
         _searchTxt.removeEventListener("focusIn",__onFocusin);
         _searchTxt.removeEventListener("keyDown",__onKeydownHandler);
      }
      
      private function __onFocusin(param1:FocusEvent) : void
      {
         IMEManager.enable();
      }
      
      private function __onKeydownHandler(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == 13)
         {
            __onSerachHandler(null);
         }
         param1.stopPropagation();
      }
      
      private function __onSerachHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = int(_searchTxt.text);
         control.sendSearchRoomInfo(16,_loc2_);
      }
      
      private function __refreshRoomListHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.requestRoomInfo();
      }
      
      private function __refreshHandler(param1:TheseusRoomListEvent) : void
      {
         var _loc3_:TheseusDoubleRoomItem = null;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc2_:TheseusDoubleRoomItem = null;
         var _loc5_:int = 0;
         var _loc4_:int = int(model.roomList.length);
         if(_loc4_ > ROOM_LIST_num)
         {
            _loc6_ = ROOM_LIST_num;
            while(_loc6_ < _loc4_)
            {
               _loc3_ = ComponentFactory.Instance.creatCustomObject("theseusdoublepvproom.TheseusDoublePvpRoomItem");
               _listContain.appendItem(_loc3_);
               _loc6_++;
            }
         }
         else if(ROOM_LIST_num > _loc4_)
         {
            _loc7_ = ROOM_LIST_num - 1;
            while(_loc7_ >= _loc4_)
            {
               _loc2_ = _listContain.getChildAt(_loc7_) as TheseusDoubleRoomItem;
               if(_loc2_)
               {
                  _listContain.removeChild(_loc2_);
               }
               _loc7_--;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < _loc4_)
         {
            _loc3_ = _listContain.getChildAt(_loc5_) as TheseusDoubleRoomItem;
            if(model.roomList.length > _loc5_)
            {
               _loc3_.data = model.roomList[_loc5_];
            }
            else
            {
               _loc3_.data = null;
            }
            _loc5_++;
         }
         ROOM_LIST_num = _loc4_;
         _listPanel.invalidateViewport();
      }
      
      private function __selectedCampaignChange(param1:ListItemEvent) : void
      {
         control.model.searchId = param1.cellValue.CampaignId;
         _roomInfo = param1.cellValue.data;
      }
      
      private function get model() : ThsesusRoomListModel
      {
         return FrameControllerManager.instance.theseusRoomListControler.model;
      }
      
      private function get control() : TheseusRoomListControler
      {
         return FrameControllerManager.instance.theseusRoomListControler;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_back1)
         {
            _back1.dispose();
         }
         _back1 = null;
         if(_back2)
         {
            _back2.dispose();
         }
         _back2 = null;
         ObjectUtils.disposeObject(_filterBack);
         _filterBack = null;
         ObjectUtils.disposeObject(_filterTxt);
         _filterTxt = null;
         if(_refreshBtn)
         {
            _refreshBtn.dispose();
         }
         _refreshBtn = null;
         if(_listContain)
         {
            _listContain.dispose();
         }
         _listContain = null;
         ObjectUtils.disposeObject(_searchTxt);
         _searchTxt = null;
         ObjectUtils.disposeObject(_searchBt);
         _searchBt = null;
         ObjectUtils.disposeAllChildren(_searchContainer);
         _searchContainer = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

