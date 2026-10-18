package luckylottery
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.LuckyLotteryManager;
   import mvc.module.luckylottery.LuckyLotteryModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class LuckyLotteryFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _leftBg:Image;
      
      private var _rightBg:MutipleImage;
      
      private var _ruleDescTxt:FilterFrameText;
      
      private var _specialAwardsItemView:BaseItemView;
      
      private var _specialAwardsItemTxt:FilterFrameText;
      
      private var _refreshAwardsBtn:IconButton;
      
      private var _extractionBtn:IconButton;
      
      private var _costItemView:BaseItemView;
      
      private var _costNumberTxt:FilterFrameText;
      
      private var _costDescTxt:FilterFrameText;
      
      private var _costItemNumberTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _canRefreshMc:MovieClip;
      
      private var _vbox:VBox;
      
      private var _model:LuckyLotteryModel;
      
      private var _count:int = 1;
      
      private var _costGoodsCount:int;
      
      private var _itemList:Vector.<LuckyLotteryLeftItem>;
      
      private var _leftTimeTxt:FilterFrameText;
      
      private var _leftCountTxt:FilterFrameText;
      
      public function LuckyLotteryFrame()
      {
         super();
         _model = LuckyLotteryManager.instance.model;
         initView();
         initData();
         initEvent();
         LuckyLotteryManager.instance.frameOperation(3);
      }
      
      private function initView() : void
      {
         _leftBg = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.leftBg");
         _rightBg = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.rightBg");
         _ruleDescTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.ruleDescTxt");
         _specialAwardsItemView = ComponentFactory.Instance.creatCustomObject("LuckyLotteryFrame.specialAwardsItemView");
         _specialAwardsItemTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.specialAwardsItemTxt");
         _refreshAwardsBtn = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.refreshAwardsBtn");
         _extractionBtn = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.extractionBtn");
         _costItemView = ComponentFactory.Instance.creatCustomObject("LuckyLotteryFrame.costItemView");
         _costNumberTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.costNumberTxt");
         _costDescTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.costDescTxt");
         _vbox = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.vbox");
         _canRefreshMc = ComponentFactory.Instance.creatCustomObject("LuckyLotteryFrame.canRefreshMc");
         _costItemNumberTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.costItemNumberTxt");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.scrollPanel");
         _leftTimeTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.leftTimeTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("LuckyLotteryFrame.leftCountTxt");
         addToContent(_leftBg);
         addToContent(_rightBg);
         addToContent(_specialAwardsItemView);
         addToContent(_specialAwardsItemTxt);
         addToContent(_refreshAwardsBtn);
         addToContent(_extractionBtn);
         addToContent(_costItemView);
         addToContent(_costNumberTxt);
         addToContent(_costDescTxt);
         addToContent(_vbox);
         addToContent(_scrollPanel);
         addToContent(_canRefreshMc);
         addToContent(_costItemNumberTxt);
         addToContent(_leftTimeTxt);
         addToContent(_leftCountTxt);
         _scrollPanel.setView(_ruleDescTxt);
         _ruleDescTxt.text = LanguageMgr.GetTranslation("LuckyLotteryFrame.ruleDescTxt");
         _scrollPanel.invalidateViewport();
         _canRefreshMc.visible = false;
         _canRefreshMc.mouseChildren = _canRefreshMc.mouseEnabled = false;
         _canRefreshMc.gotoAndStop(1);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_leftBg);
         _leftBg = null;
         ObjectUtils.disposeObject(_rightBg);
         _rightBg = null;
         ObjectUtils.disposeObject(_ruleDescTxt);
         _ruleDescTxt = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_specialAwardsItemView);
         _specialAwardsItemView = null;
         ObjectUtils.disposeObject(_specialAwardsItemTxt);
         _specialAwardsItemTxt = null;
         ObjectUtils.disposeObject(_refreshAwardsBtn);
         _refreshAwardsBtn = null;
         ObjectUtils.disposeObject(_extractionBtn);
         _extractionBtn = null;
         ObjectUtils.disposeObject(_costItemView);
         _costItemView = null;
         ObjectUtils.disposeObject(_costNumberTxt);
         _costNumberTxt = null;
         ObjectUtils.disposeObject(_costDescTxt);
         _costDescTxt = null;
         ObjectUtils.disposeObject(_vbox);
         _vbox = null;
         ObjectUtils.disposeViolentMc(_canRefreshMc);
         _canRefreshMc = null;
         ObjectUtils.disposeObject(_costItemNumberTxt);
         _costItemNumberTxt = null;
         ObjectUtils.disposeObject(_leftTimeTxt);
         _leftTimeTxt = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         if(_costNumberTxt)
         {
            _costNumberTxt.addEventListener("change",__buyNumChange);
         }
         if(_refreshAwardsBtn)
         {
            _refreshAwardsBtn.addEventListener("click",__refreshAwardsBtnHandler);
         }
         if(_extractionBtn)
         {
            _extractionBtn.addEventListener("click",__extractionBtnHandler);
         }
         NotificationManager.instance.addEventListener("LUCKY_LOTTERY_RECORD",__refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_costNumberTxt)
         {
            _costNumberTxt.removeEventListener("change",__buyNumChange);
         }
         if(_refreshAwardsBtn)
         {
            _refreshAwardsBtn.removeEventListener("click",__refreshAwardsBtnHandler);
         }
         if(_extractionBtn)
         {
            _extractionBtn.removeEventListener("click",__extractionBtnHandler);
         }
         NotificationManager.instance.removeEventListener("LUCKY_LOTTERY_RECORD",__refreshView);
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         _count = int(_costNumberTxt.text);
         _count = _count < 1 ? 1 : _count;
         var _loc2_:int = _costGoodsCount / _model.needGoodsCount;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         _count = _count > _loc2_ ? _loc2_ : _count;
         _count = _count > 50 ? 50 : _count;
         _costNumberTxt.text = _count.toString();
      }
      
      private function initData() : void
      {
         var _loc1_:LuckyLotteryLeftItem = null;
         var _loc2_:int = 0;
         _refreshAwardsBtn.enable = false;
         _costNumberTxt.text = _count.toString();
         _itemList = new Vector.<LuckyLotteryLeftItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new LuckyLotteryLeftItem();
            _loc1_.type = _loc2_ + 1;
            _loc1_.dataArray = null;
            _vbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function __refreshView(param1:NotificationEvent) : void
      {
         var count:int;
         var item:LuckyLotteryLeftItem;
         var i:int;
         var event:NotificationEvent = param1;
         _costDescTxt.htmlText = LanguageMgr.GetTranslation("LuckyLotteryFrame.costDescTxt",_model.needGoodsCount);
         _costGoodsCount = GoodsManager.instance.getGoodsNumByTempId(_model.needGoodsTempId);
         _costItemView.data = initGoods(_model.needGoodsTempId,_costGoodsCount);
         _costItemNumberTxt.text = _costGoodsCount.toString();
         if(activeLeftCount < 60)
         {
            _leftTimeTxt.htmlText = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime03",LanguageMgr.GetTranslation("ui.tasktracebar.view.petboss.PetBossSortView.endStr"));
         }
         else
         {
            _leftTimeTxt.htmlText = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime03",DateFormatter.getFullTimeString(activeLeftCount));
         }
         count = _model.refreshCountTimes - _model.refreshedCountTimes;
         count = int(count < 0 ? 0 : count);
         _leftCountTxt.text = LanguageMgr.GetTranslation("luckyLotteryFrame.leftCountTimes.text",count);
         if(_model.specialAwardInfo)
         {
            _specialAwardsItemView.data = initGoods(_model.specialAwardInfo.templateId,_model.specialAwardInfo.count);
            _specialAwardsItemTxt.text = _model.specialAwardInfo.currentNum + "/" + _model.specialAwardInfo.maxNum;
            if(_model.specialAwardInfo.currentNum == _model.specialAwardInfo.maxNum && count > 0)
            {
               _refreshAwardsBtn.enable = true;
               _canRefreshMc.visible = true;
               _canRefreshMc.gotoAndPlay(1);
               _canRefreshMc.addFrameScript(23,function():void
               {
                  _canRefreshMc.gotoAndStop(1);
                  _canRefreshMc.visible = false;
               });
            }
         }
         _model.initAllItemInfoDic();
         i = 1;
         while(i < 5)
         {
            item = _itemList[i - 1];
            item.type = i;
            item.dataArray = _model.allItemInfoDic[i];
            i = i + 1;
         }
      }
      
      private function get activeLeftCount() : Number
      {
         var _loc1_:Date = DateFormatter.parse(_model.endDate,"YYYY-MM-DD hh:mm:ss");
         var _loc2_:Number = (_loc1_.time - PlayerManager.instance.currentPlayerModel.sysCurtime.time) / 1000;
         return _loc2_ > 0 ? _loc2_ : 0;
      }
      
      private function initGoods(param1:int, param2:int) : GoodsInfo
      {
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1;
         _loc3_.count = param2;
         return _loc3_;
      }
      
      private function __refreshAwardsBtnHandler(param1:MouseEvent) : void
      {
         LuckyLotteryManager.instance.frameOperation(2);
         _refreshAwardsBtn.enable = false;
      }
      
      private function __extractionBtnHandler(param1:MouseEvent) : void
      {
         if(_costGoodsCount < _count * _model.needGoodsCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("consortia.ConsortiaControler.noGoodsInBag"));
            return;
         }
         LuckyLotteryManager.instance.frameOperation(1,_count);
         _count = 1;
         _costNumberTxt.text = _count.toString();
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
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("LuckyLotteryFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,885,645);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uninitView();
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

