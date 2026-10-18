package dayguide.newleed
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import dayguide.ActiveBoxItem;
   import dayguide.ActiveProgressView;
   import events.DayGuideEvent;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.DayGuideManager;
   import managers.DayGuideSocketOutManager;
   import mvc.module.dayGuide.DayGuideCatecory;
   import mvc.module.dayGuide.LeedInfo;
   import utils.LogicUtils;
   import yishi.datas.ConfigInfoManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.utils.DateFormatter;
   import yishi.utils.SimpleAlertHelper;
   
   public class ActiveLeedFrame extends Frame implements IManualSize
   {
      
      private var _btnVbox:VBox;
      
      private var _dailyBtn:SelectedIconButton;
      
      private var _singleBtn:SelectedIconButton;
      
      private var _mutiBtn:SelectedIconButton;
      
      private var _mutiPkBtn:SelectedIconButton;
      
      private var _consortiaBtn:SelectedIconButton;
      
      private var _petAndChildBtn:SelectedIconButton;
      
      private var _investitureBtn:SelectedIconButton;
      
      private var _threeTurnBtn:SelectedIconButton;
      
      private var _fourTurnBtn:SelectedIconButton;
      
      private var _buttongroup:SelectedButtonGroup;
      
      private var _getActiveText2:FilterFrameText;
      
      private var _getActiveText1:FilterFrameText;
      
      private var _getActiveText3:FilterFrameText;
      
      private var _weekActiveText:FilterFrameText;
      
      private var _dayActiveText:FilterFrameText;
      
      private var _border:ScaleBitmapImage;
      
      private var _rightBack:MutipleImage;
      
      private var _activeProgress:ActiveProgressView;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _scrollPane2:ScrollPanel;
      
      private var _itemVBox:VBox;
      
      private var itemList:Vector.<ActiveLeedItem>;
      
      private var getBoxList:Vector.<ActiveBoxItem>;
      
      private var _doubleActiveTextBtn:TextButton;
      
      private var _remianTxt:FilterFrameText;
      
      private var allLeedDic:Dictionary;
      
      private var _doubleActiveCost:int;
      
      private var _countDownTime:Timer;
      
      private var _totalSecond:int;
      
      public function ActiveLeedFrame()
      {
         super();
         allLeedDic = cate.getShowAllList();
         initView();
         initWeekBoxView();
         addEvent();
         refreshView();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,780,538);
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _weekActiveText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc_n4_npxj");
         _dayActiveText = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.dayActiveText");
         _border = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc.border");
         _rightBack = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc.rightBack");
         _activeProgress = ComponentFactory.Instance.creatCustomObject("dayGuide.ActiveView.ActiveProgress");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.scrollPanel");
         _scrollPane2 = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.scrollPane2");
         _itemVBox = ComponentFactory.Instance.creatComponentByStylename("DailyProjectView.vBox");
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.btnVBox");
         _dailyBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.dailyBtn");
         _singleBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.singleBtn");
         _mutiBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.mutiBtn");
         _mutiPkBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.mutiPkBtn");
         _consortiaBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.consortiaBtn");
         _petAndChildBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.petAndChildBtn");
         _investitureBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.investitureBtn");
         _threeTurnBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.threeTurnBtn");
         _fourTurnBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.fourTurnBtn");
         _doubleActiveTextBtn = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.doubleActiveTextBtn");
         _remianTxt = ComponentFactory.Instance.creatComponentByStylename("ActiveLeedFrame.remianTxt");
         _doubleActiveTextBtn.text = LanguageMgr.GetTranslation("dayguide.newleed.doubleActiveTextBtn.text");
         addToContent(_border);
         addToContent(_rightBack);
         addToContent(_activeProgress);
         addToContent(_dayActiveText);
         addToContent(_scrollPanel);
         addToContent(_scrollPane2);
         addToContent(_weekActiveText);
         addToContent(_doubleActiveTextBtn);
         addToContent(_remianTxt);
         _scrollPanel.setView(_itemVBox);
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
         _btnVbox.addChild(_dailyBtn);
         _btnVbox.addChild(_singleBtn);
         _btnVbox.addChild(_mutiBtn);
         _btnVbox.addChild(_mutiPkBtn);
         _btnVbox.addChild(_consortiaBtn);
         _btnVbox.addChild(_petAndChildBtn);
         _btnVbox.addChild(_investitureBtn);
         _btnVbox.addChild(_threeTurnBtn);
         if(VersionSwitch.FOUR_TURN)
         {
            _btnVbox.addChild(_fourTurnBtn);
         }
         _scrollPane2.setView(_btnVbox);
         _scrollPane2.invalidateViewport();
         _scrollPane2.commitChanges();
         _buttongroup = new SelectedButtonGroup();
         _buttongroup.addSelectItem(_dailyBtn);
         _buttongroup.addSelectItem(_singleBtn);
         _buttongroup.addSelectItem(_mutiBtn);
         _buttongroup.addSelectItem(_mutiPkBtn);
         _buttongroup.addSelectItem(_consortiaBtn);
         _buttongroup.addSelectItem(_petAndChildBtn);
         _buttongroup.addSelectItem(_investitureBtn);
         _buttongroup.addSelectItem(_threeTurnBtn);
         if(VersionSwitch.FOUR_TURN)
         {
            _buttongroup.addSelectItem(_fourTurnBtn);
         }
         _buttongroup.selectIndex = 0;
         _remianTxt.visible = false;
         _doubleActiveTextBtn.visible = true;
         itemList = new Vector.<ActiveLeedItem>();
         _doubleActiveCost = ConfigInfoManager.instance.getLeedBuyBuffPoint();
         __onUpdataRemainTxtHandler(null);
      }
      
      private function initWeekBoxView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ActiveBoxItem = null;
         getBoxList = new Vector.<ActiveBoxItem>();
         _loc1_ = 1;
         while(_loc1_ <= 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("ActiveLeedFrame.ActiveBoxItem.week" + _loc1_,[2]);
            _loc2_.index = _loc1_ + 2;
            addToContent(_loc2_);
            _loc2_.state = 1;
            _loc2_.tipData = cate.getLeedRewardTipsStr(_loc1_,true);
            getBoxList.push(_loc2_);
            _loc1_++;
         }
         _getActiveText3 = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc_n7_npxj");
         _getActiveText2 = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc_n6_npxj");
         _getActiveText1 = ComponentFactory.Instance.creatComponentByStylename("ActiveLeed.npxjc_n5_npxj");
         addToContent(_getActiveText1);
         addToContent(_getActiveText2);
         addToContent(_getActiveText3);
      }
      
      private function addEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buttongroup.addEventListener("change",__btnChangeHandler);
         cate.addEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.addEventListener("LEED_PROGRESS_CHANGE",__onUpdataHandler);
         cate.addEventListener("BUFF_STOP_DATE",__onUpdataRemainTxtHandler);
         _doubleActiveTextBtn.addEventListener("click",__doubleActiveTextBtnHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_buttongroup)
         {
            _buttongroup.removeEventListener("change",__btnChangeHandler);
         }
         cate.removeEventListener("ACTIVE_CHANGE",__onUpdataHandler);
         cate.removeEventListener("LEED_PROGRESS_CHANGE",__onUpdataHandler);
         cate.removeEventListener("BUFF_STOP_DATE",__onUpdataRemainTxtHandler);
         _doubleActiveTextBtn.removeEventListener("click",__doubleActiveTextBtnHandler);
         if(_countDownTime)
         {
            _countDownTime.stop();
            _countDownTime.removeEventListener("timer",__onTimer);
            _countDownTime = null;
         }
      }
      
      private function __onUpdataHandler(param1:DayGuideEvent) : void
      {
         refreshView();
      }
      
      private function __onUpdataRemainTxtHandler(param1:DayGuideEvent) : void
      {
         var _loc2_:Date = DateFormatter.parse(cate.buffStopDate,"YYYY-MM-DD hh:mm:ss");
         if(!_loc2_)
         {
            return;
         }
         if(_loc2_.time > playerModel.nowDate)
         {
            _remianTxt.visible = true;
            _doubleActiveTextBtn.visible = false;
            _totalSecond = (_loc2_.time - playerModel.nowDate) / 1000;
            _countDownTime = new Timer(1000,_totalSecond);
            _countDownTime.addEventListener("timer",__onTimer);
            _countDownTime.start();
         }
         else
         {
            _remianTxt.visible = false;
            _doubleActiveTextBtn.visible = true;
         }
      }
      
      private function __onTimer(param1:TimerEvent) : void
      {
         var _loc2_:String = null;
         if(_totalSecond > 0)
         {
            _loc2_ = DateFormatter.getDefaultFullDateString(_totalSecond);
            _remianTxt.text = LanguageMgr.GetTranslation("dayguide.newleed.remianTxt",_loc2_);
            _totalSecond = _totalSecond - 1;
         }
      }
      
      private function __doubleActiveTextBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("dayguide.newleed.doubleActiveText",_doubleActiveCost);
         SimpleAlertHelper.instance.data = [_buyDoubleActiveHandler];
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true,true,true,2);
      }
      
      private function _buyDoubleActiveHandler(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            if(PlayerManager.instance.currentPlayerModel.playerInfo.point >= _doubleActiveCost)
            {
               DayGuideSocketOutManager.sendbuyDoubleBuff();
            }
            else
            {
               RechargeAlertMannager.show();
            }
         }
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("022",true);
         _scrollPanel.scrollToTop();
         refreshActiveView();
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
      
      private function refreshActiveView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:ActiveLeedItem = null;
         _itemVBox.removeAllChild();
         var _loc4_:Array = getListDataByIndex(_buttongroup.selectIndex);
         var _loc2_:int = int(_loc4_.length);
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = _loc3_ < itemList.length ? itemList[_loc3_] : null;
            if(!_loc1_)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("ActiveLeedFrame.leedItem");
               itemList[_loc3_] = _loc1_;
            }
            _loc1_.data = _loc4_[_loc3_];
            _itemVBox.addChild(_loc1_);
            _loc3_++;
         }
         _scrollPanel.invalidateViewport();
         _scrollPanel.commitChanges();
      }
      
      private function refreshView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:ActiveBoxItem = null;
         _activeProgress.data = cate.active;
         _dayActiveText.text = cate.active + "";
         _weekActiveText.text = cate.weekActive + "";
         _getActiveText1.text = cate.weekActiveConfigValue[0] + "";
         _getActiveText2.text = cate.weekActiveConfigValue[1] + "";
         _getActiveText3.text = cate.weekActiveConfigValue[2] + "";
         _loc2_ = 1;
         while(_loc2_ <= getBoxList.length)
         {
            _loc1_ = getBoxList[_loc2_ - 1] as ActiveBoxItem;
            if(cate.hasWeekPick(_loc2_))
            {
               _loc1_.state = 3;
            }
            else if(cate.canWeekPick(_loc2_))
            {
               _loc1_.state = 2;
            }
            else
            {
               _loc1_.state = 1;
            }
            _loc2_++;
         }
         refreshActiveView();
      }
      
      private function get cate() : DayGuideCatecory
      {
         return DayGuideManager.instance.cate;
      }
      
      private function getListDataByIndex(param1:int) : Array
      {
         var _loc2_:Array = [];
         for each(var _loc3_:LeedInfo in allLeedDic)
         {
            if(int(_loc3_.sort / 100) == param1)
            {
               if(!(_loc3_.templateId == 77 && !VersionSwitch.UNREALSHOOTING))
               {
                  _loc2_.push(_loc3_);
               }
            }
         }
         _loc2_.sort(sortByStateAndId);
         return _loc2_;
      }
      
      private function sortByStateAndId(param1:LeedInfo, param2:LeedInfo) : int
      {
         if(!param1.isComplete && Boolean(param2.isComplete))
         {
            return -1;
         }
         if(param1.isComplete && !param2.isComplete)
         {
            return 1;
         }
         if(param1.templateId < param2.templateId)
         {
            return -1;
         }
         if(param1.templateId < param2.templateId)
         {
            return 1;
         }
         return 0;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,0,0,true);
         titleText = LanguageMgr.GetTranslation("dayGuide.view.DayGuideFrame.title");
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_getActiveText2);
         _getActiveText2 = null;
         ObjectUtils.disposeObject(_getActiveText3);
         _getActiveText3 = null;
         ObjectUtils.disposeObject(_getActiveText1);
         _getActiveText1 = null;
         ObjectUtils.disposeObject(_weekActiveText);
         _weekActiveText = null;
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_rightBack);
         _rightBack = null;
         ObjectUtils.disposeObject(_activeProgress);
         _activeProgress = null;
         ObjectUtils.disposeObject(_itemVBox);
         _itemVBox = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         ObjectUtils.disposeObject(_scrollPane2);
         _scrollPane2 = null;
         ObjectUtils.disposeObject(_btnVbox);
         _btnVbox = null;
         ObjectUtils.disposeObject(_doubleActiveTextBtn);
         _doubleActiveTextBtn = null;
         ObjectUtils.disposeObject(_remianTxt);
         _remianTxt = null;
         ObjectUtils.disposeObject(_dailyBtn);
         _dailyBtn = null;
         ObjectUtils.disposeObject(_singleBtn);
         _singleBtn = null;
         ObjectUtils.disposeObject(_mutiBtn);
         _mutiBtn = null;
         ObjectUtils.disposeObject(_mutiPkBtn);
         _mutiPkBtn = null;
         ObjectUtils.disposeObject(_consortiaBtn);
         _consortiaBtn = null;
         ObjectUtils.disposeObject(_petAndChildBtn);
         _petAndChildBtn = null;
         ObjectUtils.disposeObject(_investitureBtn);
         _investitureBtn = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
         LogicUtils.disposeDisplayCollection(getBoxList);
         getBoxList = null;
         super.dispose();
      }
   }
}

