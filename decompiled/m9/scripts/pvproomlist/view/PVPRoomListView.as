package pvproomlist.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.PVPRoomListEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import mvc.controler.PVPRoomListControler;
   import mvc.module.pvproomlist.PVPRoomListModel;
   import yishi.manager.FrameControllerManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.view.component.TileContainer;
   import yishi.view.frame.pvpleague.PVPLeagueRankListFrame;
   
   public class PVPRoomListView extends Component
   {
      
      private static const ROOM_LIST_CAPICITY:int = 8;
      
      private var _back1:Scale9CornerImage;
      
      private var _back:Bitmap;
      
      private var _preBtn:IconButton;
      
      private var _nextBtn:IconButton;
      
      private var _leagueRankBtn:IconButton;
      
      private var _listContain:TileContainer;
      
      private var _itemGroup:SelectedButtonGroup;
      
      public function PVPRoomListView()
      {
         super();
         initView();
         initList();
         initEvent();
      }
      
      private function initView() : void
      {
         _back1 = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.RoomListBack1");
         _back = ComponentFactory.Instance.creatBitmap("asset.pvproomlist.RoomListBack");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.PreBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.NextBtn");
         _listContain = new TileContainer();
         _leagueRankBtn = ComponentFactory.Instance.creatComponentByStylename("pvproomlist.LeagueRankButton");
         addChild(_back1);
         addChild(_back);
         addChild(_preBtn);
         addChild(_nextBtn);
         addChild(_leagueRankBtn);
         addChild(_listContain);
         _listContain.paddingH = 0;
         _listContain.paddingV = -3;
         _listContain.rowCount = 4;
         _listContain.columnCount = 2;
         _listContain.width = 500;
         _listContain.x = 12;
         _listContain.y = 8;
      }
      
      private function initList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:PVPRoomItem = null;
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("pvproomlist.PVPRoomItem");
            _listContain.appendItem(_loc1_);
            _loc2_++;
         }
      }
      
      private function initEvent() : void
      {
         _preBtn.addEventListener("click",__refreshRoomListHandler);
         _nextBtn.addEventListener("click",__refreshRoomListHandler);
         model.addEventListener("REFRESH_ROOM_LIST",__refreshHandler);
         _leagueRankBtn.addEventListener("click",__showLeagueRankListFrame);
      }
      
      private function removeEvent() : void
      {
         _preBtn.removeEventListener("click",__refreshRoomListHandler);
         _nextBtn.removeEventListener("click",__refreshRoomListHandler);
         model.removeEventListener("REFRESH_ROOM_LIST",__refreshHandler);
         _leagueRankBtn.removeEventListener("click",__showLeagueRankListFrame);
      }
      
      private function __refreshRoomListHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         control.requestRoomInfo();
      }
      
      private function __refreshHandler(param1:PVPRoomListEvent) : void
      {
         var _loc2_:PVPRoomItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = int(_listContain.numChildren);
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            _loc2_ = _listContain.getChildAt(_loc4_) as PVPRoomItem;
            if(model.roomList.length > _loc4_)
            {
               _loc2_.data = model.roomList[_loc4_];
            }
            else
            {
               _loc2_.data = null;
            }
            _loc4_++;
         }
      }
      
      private function __showLeagueRankListFrame(param1:Event) : void
      {
         var e:Event = param1;
         CheckUIModuleUtil.instance.tryCall("sort",function():void
         {
            var _loc1_:PVPLeagueRankListFrame = ComponentFactory.Instance.createComponentGroupByStylename("sort.league.PVPLeagueRankListFrame");
            _loc1_.show();
         });
      }
      
      private function get model() : PVPRoomListModel
      {
         return FrameControllerManager.instance.pvpRoomlistControler.model;
      }
      
      private function get control() : PVPRoomListControler
      {
         return FrameControllerManager.instance.pvpRoomlistControler;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leagueRankBtn);
         _leagueRankBtn = null;
         ObjectUtils.disposeObject(_listContain);
         _listContain = null;
         super.dispose();
      }
   }
}

