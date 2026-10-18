package map.campaign.view.frame.duskarea
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import map.campaign.CampaignManager;
   import map.campaign.data.PvpWarFightModel;
   import map.campaign.data.WarFightOrderInfo;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   
   public class DuskAreaPointRankFrame extends Frame
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
      
      private var _getResTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _rankInfoList:DuskAreaPointRankList;
      
      private var _data:Array;
      
      protected var mapId:int;
      
      public function DuskAreaPointRankFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.titleText");
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
         _getResTxt = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrameGetResTxtTxt");
         _rankInfoList = ComponentFactory.Instance.creatCustomObject("duskarea.DuskAreaPointRankList");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("duskarea.DuskAreaPointRankFrame.ScrollPanel");
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
         addToContent(_bagBack);
         addToContent(_listBg);
         addToContent(_btnHBox);
         addToContent(_rankTxt);
         _rankTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankTxt");
         addToContent(_rankNameTxt);
         _rankNameTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.rankNameTxt");
         addToContent(_serverNameTxt);
         _serverNameTxt.text = LanguageMgr.GetTranslation("sort.view.MemberTitleView.serverName");
         addToContent(_attackCountTxt);
         _attackCountTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.attackCountTxt");
         addToContent(_getResTxt);
         _getResTxt.text = LanguageMgr.GetTranslation("map.campaign.view.frame.duskarea.DuskAreaPointRankFrame.getResTxt");
         addToContent(_scrollPanel);
         _btnHBox.addChild(_allBtn);
         _btnHBox.addChild(_selfBtn);
         _btnHBox.addChild(_otherSideBtn);
         _btnGroup.addSelectItem(_allBtn);
         _btnGroup.addSelectItem(_selfBtn);
         _btnGroup.addSelectItem(_otherSideBtn);
         _attackCountTxt.x = 430;
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,703,440);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",_frameResponse);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      private function removeEvent() : void
      {
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         removeEventListener("response",_frameResponse);
         KeyBoardRegister.instance.keyEnable = true;
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show(param1:Object = null) : void
      {
         if(param1)
         {
            mapId = param1.mapId;
         }
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         _btnGroup.selectIndex = 0;
      }
      
      private function __tabChangeHandler(param1:Event = null) : void
      {
         var _loc2_:int = 0;
         switch(int(_btnGroup.selectIndex))
         {
            case 0:
               _data.sortOn(["score","hitCount"],[16,16]);
               _data.reverse();
               _loc2_ = 0;
               while(_loc2_ < _data.length)
               {
                  _data[_loc2_].order = _loc2_ + 1;
                  _loc2_++;
               }
               _rankInfoList.refreshMemberList(_data);
               break;
            case 1:
               _rankInfoList.refreshMemberList(getDataByFlag(true));
               break;
            case 2:
               _rankInfoList.refreshMemberList(getDataByFlag(false));
         }
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
      }
      
      public function setDate(param1:Array) : void
      {
         var _loc2_:int = 0;
         _data = param1;
         _data.sortOn(["score","hitCount"],[16,16]);
         _data.reverse();
         _loc2_ = 0;
         while(_loc2_ < _data.length)
         {
            _data[_loc2_].order = _loc2_ + 1;
            _loc2_++;
         }
         _btnGroup.addEventListener("change",__tabChangeHandler);
         _rankInfoList.refreshMemberList(_data);
         _scrollPanel.setView(_rankInfoList);
         _scrollPanel.invalidateViewport();
      }
      
      private function getDataByFlag(param1:Boolean) : Array
      {
         var _loc2_:Array = null;
         var _loc4_:int = 0;
         var _loc6_:WarFightOrderInfo = null;
         var _loc5_:Array = [];
         var _loc3_:Array = [];
         _loc4_ = 0;
         while(_loc4_ < _data.length)
         {
            _loc6_ = _data[_loc4_];
            if(_loc6_.teamId == pvpWarFightModel.pvpWarFightInfo.teamId)
            {
               _loc5_.push(_loc6_);
            }
            else
            {
               _loc3_.push(_loc6_);
            }
            _loc4_++;
         }
         _loc2_ = _loc5_;
         if(!param1)
         {
            _loc2_ = _loc3_;
         }
         _loc2_.sortOn(["score","hitCount"],[16,16]);
         _loc2_.reverse();
         _loc4_ = 0;
         while(_loc4_ < _loc2_.length)
         {
            _loc2_[_loc4_].order = _loc4_ + 1;
            _loc4_++;
         }
         return _loc2_;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function get pvpWarFightModel() : PvpWarFightModel
      {
         return CampaignManager.instance.pvpWarFightModel;
      }
      
      override public function dispose() : void
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
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

