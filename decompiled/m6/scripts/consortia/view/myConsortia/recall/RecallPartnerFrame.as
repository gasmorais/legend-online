package consortia.view.myConsortia.recall
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.events.ListItemEvent;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.VectorListModel;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ConsortiaEvent;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import mvc.module.consortia.ConsortiaModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.ConsortiaManager;
   import yishi.utils.StringHelper;
   import yishi.view.component.WriteMailComboxBox;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class RecallPartnerFrame extends Frame
   {
      
      private var _bg:Bitmap;
      
      private var _inputTipImg:Bitmap;
      
      private var _inputBg:ScaleBitmapImage;
      
      private var _inputComBox:WriteMailComboxBox;
      
      private var _confirmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      private var _helpBtn:BaseButton;
      
      private var _tempStr:String = "";
      
      private var _selectIndex:int;
      
      private var _currentSelected:ThaneInfo;
      
      private var _playerList:Array;
      
      private var _model:ConsortiaModel = ConsortiaManager.instance.model;
      
      public function RecallPartnerFrame()
      {
         super();
         initView();
         addEvent();
         initData();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("consortia.view.myConsortia.recall.RecallPartnerFrame.title");
         _bg = ComponentFactory.Instance.creatBitmap("asset.consortia.RecallPartnerFrameBg");
         _inputTipImg = ComponentFactory.Instance.creatBitmap("asset.consortia.RecallPartnerFrameInputTipImg");
         _inputBg = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.InputBg");
         _inputComBox = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.InputComBox");
         _confirmBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.ConfirmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.CancleBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.HelpBtn");
         _playerList = [];
         _inputComBox.textValue = "";
         _inputComBox.searchRange = 99;
         (_inputComBox.button as TextButton).text = LanguageMgr.GetTranslation("emailII.view.ConsortiaEmailView.memberBtn.text");
         initComboBox(getPlayerNameList());
         StageReferance.stage.focus = _inputComBox.textField;
         addToContent(_bg);
         addToContent(_inputTipImg);
         addToContent(_inputBg);
         addToContent(_confirmBtn);
         addToContent(_cancelBtn);
         addToContent(_inputComBox);
         addToContent(_helpBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_inputTipImg);
         _inputTipImg = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_confirmBtn);
         _confirmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_inputComBox);
         _inputComBox = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function initData() : void
      {
         ConsortiaManager.instance.getConsortiaUserInfos();
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _confirmBtn.addEventListener("click",___confirmBtnClickHandler);
         _cancelBtn.addEventListener("click",__cancelBtnClickHandler);
         _inputComBox.addEventListener("select_textField",__selectFieldHandler);
         _inputComBox.textField.addEventListener("keyDown",__focusInHandler);
         _inputComBox.textField.addEventListener("change",__changeHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _model.addEventListener("UPDATA_CONSORTIA_MEMBER",__updataConsortiaMemberHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _confirmBtn.removeEventListener("click",___confirmBtnClickHandler);
         _cancelBtn.removeEventListener("click",__cancelBtnClickHandler);
         _inputComBox.removeEventListener("select_textField",__selectFieldHandler);
         _inputComBox.textField.removeEventListener("keyDown",__focusInHandler);
         _inputComBox.textField.removeEventListener("change",__changeHandler);
         _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         _model.removeEventListener("UPDATA_CONSORTIA_MEMBER",__updataConsortiaMemberHandler);
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
      
      private function ___confirmBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ThaneInfo = null;
         var _loc2_:String = StringHelper.trimAll(_inputComBox.textValue).toLowerCase();
         if(StringHelper.isNullOrEmpty(_loc2_))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.recall.RecallPartnerFrame.inputTip"));
            return;
         }
         if(_loc2_ == thane.nickName.toLowerCase())
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.view.myConsortia.recall.RecallPartnerFrame.inputTip"));
            return;
         }
         if(_currentSelected)
         {
            _loc4_ = int(_currentSelected.userId);
         }
         else
         {
            _loc3_ = getInfoByName(_loc2_);
            if(!_loc3_)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("friends.findfriend.FindResultFrame.unfindTip"));
               return;
            }
            _loc4_ = int(_loc3_.userId);
         }
         FunnyManager.instance.sendReturnOption(3,_loc4_);
      }
      
      private function getInfoByName(param1:String) : ThaneInfo
      {
         for each(var _loc2_:ThaneInfo in _playerList)
         {
            if(_loc2_.nickName.toLowerCase() == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
      
      private function __cancelBtnClickHandler(param1:MouseEvent) : void
      {
         dispose();
      }
      
      private function __focusInHandler(param1:KeyboardEvent) : void
      {
         param1.stopImmediatePropagation();
         param1.stopPropagation();
      }
      
      private function __selectFieldHandler(param1:Event) : void
      {
         _selectIndex = 0;
         _currentSelected = null;
      }
      
      private function __changeHandler(param1:Event) : void
      {
         if(StringHelper.checkStringLength(_inputComBox.textValue) > 12)
         {
            _inputComBox.textValue = _tempStr;
         }
         _tempStr = _inputComBox.textValue;
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("consortia.RecallPartnerFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __itemClick(param1:ListItemEvent) : void
      {
         _selectIndex = param1.index;
         _currentSelected = param1.cellValue;
      }
      
      private function __updataConsortiaMemberHandler(param1:ConsortiaEvent) : void
      {
         initComboBox(getPlayerNameList());
      }
      
      private function initComboBox(param1:Array) : void
      {
         _inputComBox.beginChanges();
         _inputComBox.selctedPropName = "text";
         var _loc3_:VectorListModel = _inputComBox.listPanel.vectorListModel;
         var _loc2_:int = int(param1.length);
         _loc3_.clear();
         for each(var _loc4_:ThaneInfo in param1)
         {
            if(_loc4_.userId != thane.userId)
            {
               _loc3_.append(_loc4_);
            }
         }
         _inputComBox.listPanel.list.updateListView();
         _inputComBox.listPanel.list.addEventListener("listItemClick",__itemClick);
         _inputComBox.commitChanges();
      }
      
      private function getPlayerNameList() : Array
      {
         _playerList.splice(0,_playerList.length);
         var _loc1_:Array = ConsortiaManager.instance.model.consortiaMemberList.getList();
         for each(var _loc2_:ThaneInfo in _loc1_)
         {
            if(_loc2_.isBackPlayer)
            {
               _playerList.push(_loc2_);
            }
         }
         return _playerList;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         super.dispose();
      }
   }
}

