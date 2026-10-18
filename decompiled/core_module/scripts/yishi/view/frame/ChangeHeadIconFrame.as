package yishi.view.frame
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.simple.SNSInfoMsg;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.DragonTalkerManager;
   import yishi.comm.PackageOut;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.PathManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.view.community.HeadIconCell;
   
   public class ChangeHeadIconFrame extends Frame
   {
      
      public static const COLUMN_NUM:int = 5;
      
      private var _selectHeadTxt:FilterFrameText;
      
      private var _bg:ScaleBitmapImage;
      
      private var _headContainer:SimpleTileList;
      
      private var _headScroll:ScrollPanel;
      
      private var _line:Bitmap;
      
      private var _previewTxt:FilterFrameText;
      
      private var _previewSmallIcon:HeadIconCell;
      
      private var _previewBigIcon:HeadIconCell;
      
      private var _confirmBtn:TextButton;
      
      private var _cancleBtn:TextButton;
      
      private var _currentHeadId:int = -1;
      
      private var _openFromBag:Boolean;
      
      public function ChangeHeadIconFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("yishi.view.ChangeHeadIconFrame.title");
         _selectHeadTxt = ComponentFactory.Instance.creatComponentByStylename("core.SelectHeadTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("core.ChangeHeadIconBg");
         _headContainer = ComponentFactory.Instance.creatCustomObject("core.HeadIconContainer",[5]);
         _headScroll = ComponentFactory.Instance.creatComponentByStylename("core.HeadIconScroll");
         _line = ComponentFactory.Instance.creatBitmap("asset.core.ChangeHeadIconLine");
         _previewTxt = ComponentFactory.Instance.creatComponentByStylename("core.PreviewTxt");
         _previewSmallIcon = ComponentFactory.Instance.creatCustomObject("core.PreviewSmallIconCell");
         _previewBigIcon = ComponentFactory.Instance.creatCustomObject("core.PreviewBigIconCell");
         _previewBigIcon.type = "head";
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("core.ChangeHeadIconConfirmBtn");
         _cancleBtn = ComponentFactory.Instance.creatComponentByStylename("core.ChangeHeadIconCancleBtn");
         _selectHeadTxt.text = LanguageMgr.GetTranslation("yishi.view.ChangeHeadIconFrame.select");
         _previewTxt.text = LanguageMgr.GetTranslation("yishi.view.ChangeHeadIconFrame.preview");
         _confirmBtn.text = LanguageMgr.GetTranslation("public.confirm");
         _cancleBtn.text = LanguageMgr.GetTranslation("public.cancel");
         currentHeadId = thane.snsInfo.headId;
         _headScroll.setView(_headContainer);
         addHeadIconList();
         addToContent(_bg);
         addToContent(_line);
         addToContent(_selectHeadTxt);
         addToContent(_headScroll);
         addToContent(_previewTxt);
         addToContent(_previewSmallIcon);
         addToContent(_previewBigIcon);
         addToContent(_confirmBtn);
         addToContent(_cancleBtn);
      }
      
      private function addHeadIconList() : void
      {
         var _loc1_:HeadIconCell = null;
         var _loc2_:int = 0;
         _headScroll.beginChanges();
         var _loc3_:int = PathManager.getFaceNum();
         if(DragonTalkerManager.instance.model.isOpen)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.HeadIconCell");
            _loc1_.headId = 101;
            _headContainer.addChild(_loc1_);
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.HeadIconCell");
            _loc1_.headId = 102;
            _headContainer.addChild(_loc1_);
         }
         _loc2_ = 1;
         while(_loc2_ <= _loc3_)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("core.HeadIconCell");
            _loc1_.headId = _loc2_;
            _headContainer.addChild(_loc1_);
            _loc2_++;
         }
         _headScroll.invalidateViewport();
         _headScroll.commitChanges();
      }
      
      private function refreshView() : void
      {
         _previewSmallIcon.headId = _currentHeadId;
         _previewBigIcon.headId = _currentHeadId;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponseHandler);
         _headContainer.addEventListener("LIST_ITEM_CLICK",__headIconSelectedHandler);
         _confirmBtn.addEventListener("click",__onConfirmClick);
         _cancleBtn.addEventListener("click",__onCancleClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponseHandler);
         _headContainer.removeEventListener("LIST_ITEM_CLICK",__headIconSelectedHandler);
         _confirmBtn.removeEventListener("click",__onConfirmClick);
         _cancleBtn.removeEventListener("click",__onCancleClick);
      }
      
      private function __frameResponseHandler(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
            case 4:
               dispose();
         }
      }
      
      private function __onCancleClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispose();
      }
      
      private function __onConfirmClick(param1:MouseEvent) : void
      {
         var _loc3_:PackageOut = null;
         var _loc2_:SNSInfoMsg = null;
         SoundManager.instance.play("022");
         if(_currentHeadId != thane.snsInfo.headId)
         {
            _loc3_ = new PackageOut(15033);
            _loc2_ = new SNSInfoMsg();
            _loc2_.headId = _currentHeadId;
            SocketSendManager.instance.sendProtoBuffer(_loc3_,_loc2_);
         }
         dispose();
      }
      
      private function __headIconSelectedHandler(param1:Event) : void
      {
         var _loc2_:HeadIconCell = _headContainer.selectedItem as HeadIconCell;
         if(_loc2_)
         {
            currentHeadId = _loc2_.headId;
         }
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      public function get currentHeadId() : int
      {
         return _currentHeadId;
      }
      
      public function set currentHeadId(param1:int) : void
      {
         if(_currentHeadId == param1)
         {
            return;
         }
         _currentHeadId = param1;
         refreshView();
      }
      
      public function set openFromBag(param1:Boolean) : void
      {
         _openFromBag = param1;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,false,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         if(_selectHeadTxt)
         {
            _selectHeadTxt.dispose();
         }
         _selectHeadTxt = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         if(_headContainer)
         {
            _headContainer.dispose();
         }
         _headContainer = null;
         if(_headScroll)
         {
            _headScroll.dispose();
         }
         _headScroll = null;
         if(_previewTxt)
         {
            _previewTxt.dispose();
         }
         _previewTxt = null;
         if(_previewSmallIcon)
         {
            _previewSmallIcon.dispose();
         }
         _previewSmallIcon = null;
         if(_previewBigIcon)
         {
            _previewBigIcon.dispose();
         }
         _previewBigIcon = null;
         if(_confirmBtn)
         {
            _confirmBtn.dispose();
         }
         _confirmBtn = null;
         if(_cancleBtn)
         {
            _cancleBtn.dispose();
         }
         _cancleBtn = null;
         _line = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_openFromBag)
         {
            FrameControllerManager.instance.armyController.show();
         }
      }
   }
}

