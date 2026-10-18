package rapidthrouh
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.RapidInfoEvent;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.RapidThroughPassManager;
   import mvc.controler.RapidThroughController;
   import mvc.module.rapidThrough.RapidThroughModel;
   import yishi.datas.ComponentGroupType;
   import yishi.manager.FrameControllerManager;
   
   public class RapidThrouhtRankFrame extends Frame implements IManualSize
   {
      
      private var _rankTxt:FilterFrameText;
      
      private var _captainNameTxt:FilterFrameText;
      
      private var _memberNameTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _nextBtn:IconButton;
      
      private var _preBtn:IconButton;
      
      private var _lastRefreshTimeTxt:FilterFrameText;
      
      private var _txtBg1:ScaleLeftRightImage;
      
      private var _pageBg:Image;
      
      private var _pageTxt:FilterFrameText;
      
      private var _myRankImg:Image;
      
      private var _rankBg:ScaleLeftRightImage;
      
      private var _rankTxtBottom:Image;
      
      private var _area1:SelectedButton;
      
      private var _bg:Image;
      
      private var _rankNumber:FilterFrameText;
      
      private var _localAreaBtn:SelectedButton;
      
      private var _vbox:VBox;
      
      private var _btnHBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _controller:RapidThroughController;
      
      private var _model:RapidThroughModel;
      
      private var _attenattentionTxt:FilterFrameText;
      
      private var _lookRewardBtn:TextButton;
      
      private var _tipView:RapidThrouhRewardTipsView;
      
      public function RapidThrouhtRankFrame()
      {
         super();
         _controller = FrameControllerManager.instance.rapidThroughController;
         _model = _controller.model;
         initView();
         addEvent();
         RapidThroughPassManager.instance.requestRapidStart(2);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,535,585);
      }
      
      private function initView() : void
      {
         _rankTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.rankTxt");
         _captainNameTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.captainNameTxt");
         _memberNameTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.memberNameTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.timeTxt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("topspeedrank.bg");
         _lastRefreshTimeTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.lastRefreshTimeTxt");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.LastPageBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.NextPageBtn");
         _pageBg = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.pageBg");
         _pageTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.pageTxt");
         _myRankImg = ComponentFactory.Instance.creatComponentByStylename("topspeedrank.myrank");
         _rankTxtBottom = ComponentFactory.Instance.creatComponentByStylename("topspeedrank.rankxt");
         _txtBg1 = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.textBg1");
         _rankNumber = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.rankNumber");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.itemContain");
         _btnHBox = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.btnHbox");
         _localAreaBtn = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.localArea");
         _attenattentionTxt = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.attenattentionTxt");
         _lookRewardBtn = ComponentFactory.Instance.creatComponentByStylename("topSpeedRankFrame.rewardBtn");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_localAreaBtn);
         _btnHBox.addChild(_localAreaBtn);
         _rankTxt.text = LanguageMgr.GetTranslation("rapid.rankFrame.rank");
         _captainNameTxt.text = LanguageMgr.GetTranslation("rapid.rankFrame.name");
         _memberNameTxt.text = LanguageMgr.GetTranslation("rapid.rankFrame.job");
         _timeTxt.text = LanguageMgr.GetTranslation("rapid.rankFrame.time");
         _attenattentionTxt.text = LanguageMgr.GetTranslation("raipthrough.attention");
         _lookRewardBtn.text = LanguageMgr.GetTranslation("raipthrough.lookreward");
         addToContent(_bg);
         addToContent(_btnHBox);
         addToContent(_rankTxt);
         addToContent(_captainNameTxt);
         addToContent(_memberNameTxt);
         addToContent(_timeTxt);
         addToContent(_lastRefreshTimeTxt);
         addToContent(_preBtn);
         addToContent(_nextBtn);
         addToContent(_pageBg);
         addToContent(_pageTxt);
         addToContent(_myRankImg);
         addToContent(_rankTxtBottom);
         addToContent(_txtBg1);
         addToContent(_rankNumber);
         addToContent(_vbox);
         addToContent(_attenattentionTxt);
         addToContent(_lookRewardBtn);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_rankTxt);
         _rankTxt = null;
         ObjectUtils.disposeObject(_captainNameTxt);
         _captainNameTxt = null;
         ObjectUtils.disposeObject(_memberNameTxt);
         _memberNameTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_lastRefreshTimeTxt);
         _lastRefreshTimeTxt = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBg);
         _pageBg = null;
         ObjectUtils.disposeObject(_pageTxt);
         _pageTxt = null;
         ObjectUtils.disposeObject(_myRankImg);
         _myRankImg = null;
         ObjectUtils.disposeObject(_rankTxtBottom);
         _rankTxtBottom = null;
         ObjectUtils.disposeObject(_txtBg1);
         _txtBg1 = null;
         ObjectUtils.disposeObject(_rankNumber);
         _rankNumber = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeObject(_btnHBox);
         _btnHBox = null;
         ObjectUtils.disposeObject(_localAreaBtn);
         _localAreaBtn = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_attenattentionTxt);
         _attenattentionTxt = null;
         ObjectUtils.disposeObject(_lookRewardBtn);
         _lookRewardBtn = null;
         if(_tipView)
         {
            ObjectUtils.disposeObject(_tipView);
         }
         _tipView = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__responseHandler);
         _preBtn.addEventListener("click",__onPageBtnHandler);
         _nextBtn.addEventListener("click",__onPageBtnHandler);
         _model.addEventListener("rapid_rank_update",__rankDataLoadCompleteHandler);
         _lookRewardBtn.addEventListener("mouseDown",__lookRewardHandler);
      }
      
      private function __onPageBtnHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _controller.pageBtnHandler(param1.currentTarget == _preBtn);
         refresh();
      }
      
      private function __rankDataLoadCompleteHandler(param1:RapidInfoEvent) : void
      {
         refresh();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         _preBtn.removeEventListener("click",__onPageBtnHandler);
         _nextBtn.removeEventListener("click",__onPageBtnHandler);
         _model.removeEventListener("rapid_rank_update",__rankDataLoadCompleteHandler);
         _lookRewardBtn.removeEventListener("mouseDown",__lookRewardHandler);
      }
      
      private function __lookRewardHandler(param1:MouseEvent) : void
      {
         if(_tipView && !_tipView.isDie)
         {
            _tipView.dispose();
            _tipView = null;
            return;
         }
         _tipView = new RapidThrouhRewardTipsView();
         var _loc2_:Point = new Point();
         _loc2_ = _lookRewardBtn.localToGlobal(_loc2_);
         _tipView.x = _loc2_.x - _tipView.displayWidth + 30;
         _tipView.y = _loc2_.y - 254;
         if(_tipView.y < 0)
         {
            _tipView.y = 20;
         }
         _tipView.show();
         param1.stopPropagation();
      }
      
      public function refresh() : void
      {
         var _loc3_:int = 0;
         var _loc1_:RapidThrouhtRankItemView = null;
         setButtonState();
         _pageTxt.text = _model.currentPage + "/" + _model.totalPage;
         if(_model.rankList.myOrder > 0)
         {
            _rankNumber.text = "" + _model.rankList.myOrder;
         }
         else
         {
            _rankNumber.text = LanguageMgr.GetTranslation("raipthrough.notonlist");
         }
         _lastRefreshTimeTxt.text = LanguageMgr.GetTranslation("rapid.rankFrame.refreshTime",_model.rankList.updateTime);
         var _loc4_:int = _model.currentPage - 1;
         _vbox.disposeAllChildren();
         var _loc2_:int = 0;
         if(_model.currentPage == _model.totalPage)
         {
            _loc2_ = _model.rankList.pass.length - _loc4_ * 8;
         }
         else
         {
            _loc2_ = 8;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = new RapidThrouhtRankItemView();
            _loc1_.data = _model.rankList.pass[_loc4_ * 8 + _loc3_];
            _vbox.addChild(_loc1_);
            _loc3_++;
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         titleText = LanguageMgr.GetTranslation("matelords.MatelordsRankFrame.str01");
      }
      
      private function setButtonState() : void
      {
         if(_model.currentPage == 1)
         {
            _preBtn.enable = false;
         }
         else
         {
            _preBtn.enable = true;
         }
         if(_model.currentPage == _model.totalPage)
         {
            _nextBtn.enable = false;
         }
         else
         {
            _nextBtn.enable = true;
         }
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

