package magicpub
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MagicSpringManager;
   import mvc.module.magicspring.MagicSpringSlotInfo;
   import ui.toptoolbar.TopBtnType;
   import ui.toptoolbar.view.TimeActiveBoxOpenTime;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.ArmyManager;
   import yishi.manager.CursorManagerII;
   import yishi.manager.MagicPubManager;
   import yishi.manager.NotificationManager;
   import yishi.view.community.MagicSpringBufferAddView;
   import yishi.view.tips.MessageTipManager;
   
   public class MagicPubListView extends Component
   {
      
      private var _back:DisplayObject;
      
      private var _topBg:DisplayObject;
      
      private var _itemList:Vector.<MagicPubListItem>;
      
      private var _vBox:VBox;
      
      private var _group:SelectedButtonGroup;
      
      private var _noticeNote:FilterFrameText;
      
      private var _openGiftBtn:IconButton;
      
      private var _bufferView:MagicSpringBufferAddView;
      
      public function MagicPubListView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:MagicPubListItem = null;
         _back = ComponentFactory.Instance.creatBitmap("asset.magicpub.list.Bg");
         _topBg = ComponentFactory.Instance.creatBitmap("asset.magicpub.topBg");
         _vBox = ComponentFactory.Instance.creatComponentByStylename("magicpub.magicpubVBox");
         _noticeNote = ComponentFactory.Instance.creatComponentByStylename("magicpub.MagicPubListView.noticeNote");
         _openGiftBtn = ComponentFactory.Instance.creatComponentByStylename("magicpub.giftWill.openGiftBtn");
         _itemList = new Vector.<MagicPubListItem>();
         _group = new SelectedButtonGroup();
         addChild(_back);
         addChild(_topBg);
         addChild(_vBox);
         addChild(_noticeNote);
         addChild(_openGiftBtn);
         if(!MagicPubManager.instance.listMsg)
         {
            return;
         }
         var _loc3_:Array = MagicPubManager.instance.listMsg.infos;
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new MagicPubListItem();
            _loc1_.data = _loc3_[_loc2_];
            _vBox.addChild(_loc1_);
            _group.addSelectItem(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
         _noticeNote.htmlText = LanguageMgr.GetTranslation("magicpub.MagicPubListView.noticeNote");
         _openGiftBtn.tipData = LanguageMgr.GetTranslation("magicpub.MagicPubListView.openTime",getTimeStr(ConfigInfoManager.instance.getGiftWillTime2()));
         var _loc4_:MagicSpringSlotInfo = MagicSpringManager.instance.model.checkIsExistBuffer(15);
         if(_loc4_)
         {
            _bufferView = new MagicSpringBufferAddView(_loc4_);
            _bufferView.setDescText(_loc4_.tempInfo.Desc);
            _bufferView.x = 660;
            _bufferView.y = 450;
            addChild(_bufferView);
         }
      }
      
      private function initEvent() : void
      {
         var _loc1_:int = 0;
         _openGiftBtn.addEventListener("click",__openGiftClick);
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].addEventListener("click",__itemClick);
            _loc1_++;
         }
      }
      
      private function removeEvent() : void
      {
         var _loc1_:int = 0;
         _openGiftBtn.removeEventListener("click",__openGiftClick);
         _loc1_ = 0;
         while(_loc1_ < _itemList.length)
         {
            _itemList[_loc1_].removeEventListener("click",__itemClick);
            _loc1_++;
         }
      }
      
      protected function __openGiftClick(param1:Event) : void
      {
         SoundManager.instance.play("022");
         if(thane.grades < 32)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",32));
            return;
         }
         NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_GIFTWILL_OPEN",3));
      }
      
      private function checkIsOpen(param1:int) : Boolean
      {
         var _loc2_:int = int(TimeActiveBoxOpenTime.instance.getOpenStateByIndex(param1));
         var _loc3_:int = 32;
         if(thane.grades < _loc3_)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("toptoolbar.topBtn.tipData.alert",_loc3_));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[3])
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.overTip"));
            return false;
         }
         if(_loc2_ == TopBtnType.TIME_ACTIVE_STATE[2])
         {
            return true;
         }
         MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.data.ConsortiaDemonInfo.unopenTip"));
         return false;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      protected function __itemClick(param1:Event) : void
      {
         SoundManager.instance.play("022");
         CursorManagerII.instance.showCursorByType("DEFAULT_CURSOR");
         var _loc2_:MagicPubListItem = param1.currentTarget as MagicPubListItem;
         if(_loc2_)
         {
            NotificationManager.instance.dispatchEvent(new NotificationEvent("MAGICPUB_OPEN_CHAT_VIEW",_loc2_.data));
         }
      }
      
      private function getTimeStr(param1:Array) : String
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc4_:String = "";
         _loc3_ = 0;
         while(_loc3_ < param1.length)
         {
            _loc2_ = String(param1[_loc3_]).replace(",","-").split("-");
            _loc4_ += _loc2_[0] + "~" + _loc2_[1] + "  ";
            _loc3_++;
         }
         return _loc4_;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_topBg);
         _topBg = null;
         ObjectUtils.disposeObject(_vBox);
         _vBox = null;
         ObjectUtils.disposeObject(_group);
         _group = null;
         ObjectUtils.disposeObject(_noticeNote);
         _noticeNote = null;
         ObjectUtils.disposeObject(_openGiftBtn);
         _openGiftBtn = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         ObjectUtils.disposeObject(_bufferView);
         _bufferView = null;
         super.dispose();
      }
   }
}

