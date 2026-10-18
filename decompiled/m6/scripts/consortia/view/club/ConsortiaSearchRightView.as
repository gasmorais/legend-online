package consortia.view.club
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.manager.NotificationManager;
   
   public class ConsortiaSearchRightView extends Sprite implements Disposeable
   {
      
      private var _rightBg:ScaleBitmapImage;
      
      private var _rightTitlebarBg:MutipleImage;
      
      private var _rightItemBg1:Bitmap;
      
      private var _inviteBtn:SelectedButton;
      
      private var _applyBtn:SelectedButton;
      
      private var _recordBtnGroup:SelectedButtonGroup;
      
      private var _chairmanTxt:FilterFrameText;
      
      private var _consortiaNameTxt:FilterFrameText;
      
      private var _operationTxt:FilterFrameText;
      
      private var _data:ConsortiaModel;
      
      private var _inviteItemList:Array = [];
      
      private var _applyItemList:Array = [];
      
      public function ConsortiaSearchRightView(param1:ConsortiaModel)
      {
         super();
         _data = param1;
         initView();
         addEvent();
         initData();
      }
      
      private function initData() : void
      {
         _inviteBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("consortia.rightDescribeBackground");
         _rightTitlebarBg = ComponentFactory.Instance.creatComponentByStylename("consortia.rightsideTitlebarImg");
         _rightItemBg1 = ComponentFactory.Instance.creatBitmap("asset.consortia.itemBg");
         _inviteBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.inviteBtn");
         _applyBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.applyBtn");
         _chairmanTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.chairman2TextStyle");
         _consortiaNameTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.consortiaName2TextStyle");
         _operationTxt = ComponentFactory.Instance.creatComponentByStylename("consortia.operationTextStyle");
         addChild(_rightBg);
         addChild(_rightTitlebarBg);
         addChild(_chairmanTxt);
         _chairmanTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchRightView.chairmanTxtText");
         addChild(_consortiaNameTxt);
         _consortiaNameTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSeachLeftView.consortiaNameTxt1Text");
         addChild(_operationTxt);
         _operationTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchRightView.operationTxtText");
         addChild(_rightItemBg1);
         addChild(_inviteBtn);
         addChild(_applyBtn);
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = new Bitmap(_rightItemBg1.bitmapData);
            _loc1_.x = _rightItemBg1.x;
            _loc1_.y = _rightItemBg1.y + (_loc2_ + 1) * 33;
            addChild(_loc1_);
            _loc2_++;
         }
         _recordBtnGroup = new SelectedButtonGroup();
         _recordBtnGroup.addSelectItem(_inviteBtn);
         _recordBtnGroup.addSelectItem(_applyBtn);
      }
      
      private function uninit() : void
      {
         _recordBtnGroup.dispose();
         _recordBtnGroup = null;
         ObjectUtils.disposeAllChildren(this);
         _data = null;
         _inviteBtn = null;
         _applyBtn = null;
      }
      
      private function addEvent() : void
      {
         _applyBtn.addEventListener("click",__onApplyHandler);
         _inviteBtn.addEventListener("click",__onInviteHandler);
         _data.addEventListener("UPDA_RECORD_LIST",__onRecordListUpdata);
         NotificationManager.instance.addEventListener("APPLY_CONSORTIA_SUCCESS",__onApplySuccess);
      }
      
      private function removeEvent() : void
      {
         if(_applyBtn)
         {
            _applyBtn.removeEventListener("click",__onApplyHandler);
         }
         if(_inviteBtn)
         {
            _inviteBtn.removeEventListener("click",__onInviteHandler);
         }
         _data.removeEventListener("UPDA_RECORD_LIST",__onRecordListUpdata);
         NotificationManager.instance.removeEventListener("APPLY_CONSORTIA_SUCCESS",__onApplySuccess);
      }
      
      private function __onApplyHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _chairmanTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchRightView.chairman");
         _chairmanTxt.x = 571;
         clearInviteRecordList();
         clearApplyRecordList();
         refreshApplyRecordList();
      }
      
      private function clearInviteRecordList() : void
      {
         for each(var _loc1_:RecordItem in _inviteItemList)
         {
            _loc1_.dispose();
         }
         _inviteItemList.length = 0;
      }
      
      private function refreshInviteRecordList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RecordItem = null;
         if(!_data)
         {
            return;
         }
         _loc2_ = 0;
         while(_loc2_ < _data.inviteList.length)
         {
            _loc1_ = new RecordItem();
            _loc1_.x = 475;
            _loc1_.y = 58 + _loc2_ * 33;
            _loc1_.data = _data.inviteList[_loc2_];
            addChild(_loc1_);
            _inviteItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function clearApplyRecordList() : void
      {
         for each(var _loc1_:RecordItem in _applyItemList)
         {
            _loc1_.dispose();
         }
         _applyItemList.length = 0;
      }
      
      private function __onInviteHandler(param1:Event) : void
      {
         SoundManager.instance.play("022");
         _chairmanTxt.text = LanguageMgr.GetTranslation("consortia.view.club.ConsortiaSearchRightView.chairman02");
         _chairmanTxt.x = 568;
         clearInviteRecordList();
         clearApplyRecordList();
         refreshInviteRecordList();
      }
      
      private function refreshApplyRecordList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:RecordItem = null;
         _loc2_ = 0;
         while(_loc2_ < _data.applyList.length)
         {
            _loc1_ = new RecordItem();
            _loc1_.x = 475;
            _loc1_.y = 58 + _loc2_ * 33;
            _loc1_.data = _data.applyList[_loc2_];
            addChild(_loc1_);
            _applyItemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __onRecordListUpdata(param1:ConsortiaEvent) : void
      {
         clearInviteRecordList();
         clearApplyRecordList();
         if(_applyBtn.selected)
         {
            refreshApplyRecordList();
         }
         else
         {
            refreshInviteRecordList();
         }
      }
      
      private function __onApplySuccess(param1:Event) : void
      {
         _applyBtn.dispatchEvent(new MouseEvent("click"));
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

