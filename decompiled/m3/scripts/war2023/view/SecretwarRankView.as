package war2023.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import mvc.module.war2023.SecretWarModel;
   import mvc.module.war2023.info.SecretWarRankInfo;
   import war2023.item.SecretwarRankListItem;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.SecretWarManager;
   
   public class SecretwarRankView extends Sprite
   {
      
      protected var _bagBack:Scale9CornerImage;
      
      private var _btnHBox:HBox;
      
      private var _allBtn:SelectedIconButton;
      
      private var _selfBtn:SelectedIconButton;
      
      private var _otherSideBtn:SelectedIconButton;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _listBg:Scale9CornerImage;
      
      private var _rankTxt:FilterFrameText;
      
      private var _rankNameTxt:FilterFrameText;
      
      private var _serverNameTxt:FilterFrameText;
      
      private var _attackCountTxt:FilterFrameText;
      
      private var _getBiuldTxt:FilterFrameText;
      
      private var _getResTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _rankInfoList:SecretwarRankListItem;
      
      public function SecretwarRankView()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get btnGroup() : SelectedButtonGroup
      {
         return _btnGroup;
      }
      
      protected function initView() : void
      {
         _bagBack = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame.bg");
         _btnHBox = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankView.btnHbox");
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankView.AllBtn");
         _selfBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankView.selfbtn");
         _otherSideBtn = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankView.othersidebtn");
         _btnGroup = new SelectedButtonGroup();
         _listBg = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame.pointrankListBG");
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankTxt");
         _rankNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankNameTxt");
         _serverNameTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameRankServerTxt");
         _attackCountTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameAttackCountTxt");
         _getBiuldTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameGetBiuldTxtTxt");
         _getResTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameGetResTxtTxt");
         _rankInfoList = ComponentFactory.Instance.creatCustomObject("war2023.item.SecretwarRankListItem");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame.ScrollPanel");
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
         addChild(_bagBack);
         addChild(_listBg);
         addChild(_btnHBox);
         addChild(_rankTxt);
         _rankTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankTxt");
         addChild(_rankNameTxt);
         _rankNameTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankNameTxt");
         addChild(_serverNameTxt);
         _serverNameTxt.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName");
         addChild(_attackCountTxt);
         _attackCountTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.attackCountTxt");
         addChild(_getBiuldTxt);
         _getBiuldTxt.text = LanguageMgr.GetTranslation("secretwar.rank.zl");
         addChild(_getResTxt);
         _getResTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.getResTxt");
         addChild(_scrollPanel);
         _btnHBox.addChild(_allBtn);
         _btnHBox.addChild(_selfBtn);
         _btnHBox.addChild(_otherSideBtn);
         _btnGroup.addSelectItem(_allBtn);
         _btnGroup.addSelectItem(_selfBtn);
         _btnGroup.addSelectItem(_otherSideBtn);
      }
      
      private function initEvent() : void
      {
         _btnGroup.addEventListener("change",__tabChangeHandler);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      private function get model() : SecretWarModel
      {
         return SecretWarManager.Instance.model;
      }
      
      private function __tabChangeHandler(param1:Event = null) : void
      {
         var _loc4_:Array = null;
         var _loc5_:SecretWarRankInfo = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _loc4_ = model.resultInfo.allkList;
               break;
            case 1:
               _loc4_ = model.resultInfo.blueList;
               break;
            case 2:
               _loc4_ = model.resultInfo.redList;
         }
         if(_loc4_ != null)
         {
            _loc2_ = int(_loc4_.length);
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc5_ = _loc4_[_loc3_];
               _loc5_.rank = _loc3_ + 1;
               _loc3_++;
            }
            _rankInfoList.refreshMemberList(_loc4_);
         }
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
      }
      
      public function changeBgHeight(param1:int) : void
      {
         this._bagBack.height = param1;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bagBack);
         _bagBack = null;
         ObjectUtils.disposeObject(_btnHBox);
         _btnHBox = null;
         ObjectUtils.disposeObject(_allBtn);
         _allBtn = null;
         ObjectUtils.disposeObject(_selfBtn);
         _selfBtn = null;
         ObjectUtils.disposeObject(_otherSideBtn);
         _otherSideBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_listBg);
         _listBg = null;
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_rankNameTxt);
         _rankNameTxt = null;
         ObjectUtils.disposeObject(_attackCountTxt);
         _attackCountTxt = null;
         ObjectUtils.disposeObject(_rankInfoList);
         _rankInfoList = null;
         ObjectUtils.disposeObject(_getResTxt);
         _getResTxt = null;
         ObjectUtils.disposeObject(_getBiuldTxt);
         _getBiuldTxt = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

