package marry.room
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarryRoomInfo;
   import mvc.module.marry.MarrySender;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.manager.PlayerManager;
   import yishi.utils.MsgMan;
   import yishi.view.tips.MessageTipManager;
   
   public class MarryRoomListFrame extends Frame implements IManualSize
   {
      
      private var _leftView:MarryRoomLefttView;
      
      private var _infoList:Array;
      
      private var _itemList:Array;
      
      private var _itemSp:Sprite;
      
      private var _panel:ScrollPanel;
      
      private var _myBtn:IconButton;
      
      public function MarryRoomListFrame()
      {
         super();
         initItem();
         initView();
         initEvent();
         MarrySender.resquestRoomInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,740,520);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initItem() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MarryRoomItem = null;
         _itemList = [];
         _itemSp = new Sprite();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new MarryRoomItem();
            _loc1_.x = _loc2_ % 2 * 235;
            _loc1_.y = int(_loc2_ / 2) * 190;
            _itemSp.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.room.MarryRoomListFrame.titleText");
         _panel = ComponentFactory.Instance.creatComponentByStylename("MarryRoomListFrame.panel");
         _myBtn = ComponentFactory.Instance.creatComponentByStylename("MarryRoomListFrame.MyBtn");
         _leftView = new MarryRoomLefttView();
         addToContent(_leftView);
         _leftView.x = 10;
         _leftView.y = 10;
         addToContent(_panel);
         addToContent(_myBtn);
         _myBtn.enable = false;
         _panel.setView(_itemSp);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _myBtn.addEventListener("click",__myBtnHandler);
         MsgMan.addObserver("MarryEventType.ROOM_LIST_INFO",this,__roomListInfoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_myBtn)
         {
            _myBtn.removeEventListener("click",__myBtnHandler);
         }
         MsgMan.removeObserver("MarryEventType.ROOM_LIST_INFO",this,__roomListInfoHandler);
      }
      
      private function __roomListInfoHandler(param1:String, param2:Object) : void
      {
         _infoList = [];
         for each(var _loc3_:MarryRoomInfo in model.roomDic)
         {
            _infoList.push(_loc3_);
         }
         if(_infoList)
         {
            sortList();
            refreshView();
         }
      }
      
      private function sortList() : void
      {
         var _loc2_:MarryRoomInfo = null;
         var _loc1_:int = 0;
         _loc1_ = 0;
         while(_loc1_ < _infoList.length)
         {
            _loc2_ = _infoList[_loc1_] as MarryRoomInfo;
            if(_loc2_ && (_loc2_.userIdA == playerInfo.userId || _loc2_.userIdB == playerInfo.userId))
            {
               _infoList.splice(_loc1_,1);
               _infoList.unshift(_loc2_);
               break;
            }
            _loc1_++;
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MarryRoomItem = null;
         if(_infoList)
         {
            _loc2_ = 0;
            while(_loc2_ < _infoList.length)
            {
               if(_itemList[_loc2_])
               {
                  _itemList[_loc2_].info = _infoList[_loc2_];
               }
               else
               {
                  _loc1_ = new MarryRoomItem();
                  _loc1_.info = _infoList[_loc2_] as MarryRoomInfo;
                  _loc1_.x = _loc2_ % 2 * 235;
                  _loc1_.y = int(_loc2_ / 2) * 190;
                  _itemSp.addChild(_loc1_);
                  _itemList.push(_loc1_);
               }
               _loc2_++;
            }
            if(_infoList.length > 4)
            {
               _panel.vScrollProxy = 0;
            }
            else
            {
               _panel.vScrollProxy = 2;
            }
         }
         _myBtn.enable = MarryManager.instance.model.roomInfo != null;
         _panel.invalidateViewport();
      }
      
      private function __myBtnHandler(param1:MouseEvent) : void
      {
         if(MarryManager.instance.model.roomInfo)
         {
            MarrySender.enterWeddingRoom(MarryManager.instance.model.roomInfo.userIdA + "_" + MarryManager.instance.model.roomInfo.userIdB);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("marry.room.MarryRoomListFrame.roomIsEnd"));
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         cleanItemList();
         if(_leftView)
         {
            _leftView.dispose();
         }
         _leftView = null;
         super.dispose();
      }
      
      private function cleanItemList() : void
      {
         if(_itemList)
         {
            while(_itemList.length > 0)
            {
               _itemList.pop().dispose();
            }
            _itemList = null;
         }
      }
   }
}

