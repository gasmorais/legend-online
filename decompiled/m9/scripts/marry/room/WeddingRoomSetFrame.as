package marry.room
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.SoundManager;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import mvc.ModuleFrameInfo;
   import mvc.module.marry.MarryGuestInfo;
   import mvc.module.marry.MarryModel;
   import mvc.module.marry.MarrySender;
   import yishi.datas.ComponentGroupType;
   import yishi.utils.MsgMan;
   import yishi.view.RoomPasswordFrame;
   
   public class WeddingRoomSetFrame extends Frame implements IManualSize
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _titleBg:ScaleLeftRightImage;
      
      private var _list:Dictionary;
      
      private var _infoTitle:FilterFrameText;
      
      private var _lockBtn:SelectedIconButton;
      
      private var _vBox:VBox;
      
      private var _panel:ScrollPanel;
      
      private var _btnGroup:SelectedButtonGroup;
      
      public function WeddingRoomSetFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,330,390);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("marry.room.WeddingRoomSetFrame.titleText");
         _bg = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.bg");
         _titleBg = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.titleBg");
         _infoTitle = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.infoTitle");
         _lockBtn = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.lockbtn");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.vBox");
         _panel = ComponentFactory.Instance.creatComponentByStylename("WeddingRoomSetFrame.panel");
         addToContent(_bg);
         addToContent(_titleBg);
         addToContent(_infoTitle);
         addToContent(_lockBtn);
         addToContent(_panel);
         _panel.setView(_vBox);
         _btnGroup = new SelectedButtonGroup();
         _lockBtn.tipData = LanguageMgr.GetTranslation("room.view.pve.RoomRightView.lockBtn.tipData");
         _infoTitle.text = LanguageMgr.GetTranslation("marry.room.WeddingRoomSetFrame.infoTitle");
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:MarryRoomGuestItem = null;
         var _loc3_:int = 0;
         _list = model.guestDic;
         _vBox.disposeAllChildren();
         _btnGroup.removeAllItem();
         var _loc2_:int = 0;
         for each(var _loc4_:MarryGuestInfo in _list)
         {
            _loc2_++;
            _loc1_ = new MarryRoomGuestItem();
            _loc1_.data = _loc4_;
            _vBox.addChild(_loc1_);
            _btnGroup.addSelectItem(_loc1_);
         }
         if(_loc2_ < 8)
         {
            _loc3_ = 0;
            while(_loc3_ < 8 - _loc2_)
            {
               _loc1_ = new MarryRoomGuestItem();
               _loc1_.data = null;
               _vBox.addChild(_loc1_);
               _loc3_++;
            }
         }
         _lockBtn.selected = MarryManager.instance.model.roomInfo.property1;
         _vBox.refreshChildPos();
         _panel.invalidateViewport();
      }
      
      private function __infoHandler1(param1:String, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         refreshView();
      }
      
      private function __infoHandler2(param1:String, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         refreshView();
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _lockBtn.addEventListener("click",__lockHandler);
         MsgMan.addObserver("MarryEventType.GUEST_INFO",this,__infoHandler1);
         MsgMan.addObserver("MarryEventType.ROOM_LIST_INFO",this,__infoHandler2);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_lockBtn)
         {
            _lockBtn.removeEventListener("click",__lockHandler);
         }
         MsgMan.removeObserver("MarryEventType.GUEST_INFO",this,__infoHandler1);
         MsgMan.removeObserver("MarryEventType.ROOM_LIST_INFO",this,__infoHandler2);
      }
      
      private function __lockHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _lockBtn.selected = MarryManager.instance.model.roomInfo.property1;
         var _loc2_:RoomPasswordFrame = ComponentFactory.Instance.creatComponentByStylename("core.RoomPasswordFrame");
         _loc2_.backCall = changePassWordCall;
         _loc2_.show(0);
      }
      
      private function changePassWordCall(param1:int, param2:String) : void
      {
         if(param1 == 0)
         {
            MarrySender.changeRoomPassWord(param2);
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
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,2,0,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_titleBg)
         {
            _titleBg.dispose();
         }
         _titleBg = null;
         if(_infoTitle)
         {
            _infoTitle.dispose();
         }
         _infoTitle = null;
         if(_lockBtn)
         {
            _lockBtn.dispose();
         }
         _lockBtn = null;
         if(_vBox)
         {
            _vBox.dispose();
         }
         _vBox = null;
         if(_panel)
         {
            _panel.dispose();
         }
         _panel = null;
         _list = null;
         super.dispose();
      }
   }
}

