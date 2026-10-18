package maze
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedIconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import manager.LanguageMgr;
   import managers.MopupManager;
   import map.campaign.view.frame.MazeFallItemsFrame;
   import maze.order.MazeOrderFrame;
   import maze.view.MazeFloorItem;
   import mvc.module.maze.MazeModel;
   import mvc.module.shop.ShopGoodsInfo;
   import room.net.RoomSocketOuterManager;
   import yishi.datas.VersionSwitch;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.playerinfo.TowerInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.scene.SceneManager;
   import yishi.service.managers.SocketSendManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.frame.BuyFrameI;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.tips.MessageTipManager;
   
   public class MazeFrame extends Frame
   {
      
      private var _maze1:SelectedIconButton;
      
      private var _maze2:SelectedIconButton;
      
      private var _maze3:SelectedIconButton;
      
      private var _buttonMc1:MovieClip;
      
      private var _maze2Mask:SelectedIconButton;
      
      private var _mazeGroup:SelectedButtonGroup;
      
      private var _back1:Scale9CornerImage;
      
      private var _back2:Scale9CornerImage;
      
      private var _back3:ScaleBitmapImage;
      
      private var _back4:ScaleBitmapImage;
      
      private var _back5:ScaleBitmapImage;
      
      private var _back6:ScaleFrameImage;
      
      private var _myRecord:Bitmap;
      
      private var _myRecordTxt:FilterFrameText;
      
      private var _floorPoint1:Array;
      
      private var _floorItems1:Array;
      
      private var _floorPoint2:Array;
      
      private var _floorItems2:Array;
      
      private var _buttonGroup:SelectedButtonGroup;
      
      private var _myOrder:Bitmap;
      
      private var _myOrderTxt:FilterFrameText;
      
      private var _helpBtn:BaseButton;
      
      private var _orderBtn:IconButton;
      
      private var _shopBtn:BaseButton;
      
      private var _descTxt:ScaleFrameImage;
      
      private var _spliceLine1:ScaleBitmapImage;
      
      private var _spliceLine2:ScaleBitmapImage;
      
      private var _todayFreeCount:Bitmap;
      
      private var _todayPropCount:Bitmap;
      
      private var _todayFreeCountValue:FilterFrameText;
      
      private var _todayPropCountValue:FilterFrameText;
      
      private var _curLayerBit:Bitmap;
      
      private var _totalGp:Bitmap;
      
      private var _doubleProfit:Bitmap;
      
      private var _doubleProfit2:Bitmap;
      
      private var _doubleProfitBtn:SelectedButton;
      
      private var _curLayerValue:FilterFrameText;
      
      private var _totalGpValue:FilterFrameText;
      
      private var _resetBtn:IconButton;
      
      private var _continueBtn:IconButton;
      
      private var _fallLinkTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _mopupBtn:IconButton;
      
      private var _showtipbtn:Component;
      
      private var _continueMopupBtn:IconButton;
      
      private var _currentIndex:int = 0;
      
      public function MazeFrame()
      {
         super();
         initView();
         initFloorPoint();
         _mazeGroup.selectIndex = 0;
         initEvent();
         refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","BAG_GROUP"];
      }
      
      private function initView() : void
      {
         _maze1 = ComponentFactory.Instance.creatComponentByStylename("maze.MazeBtn1");
         _maze2 = ComponentFactory.Instance.creatComponentByStylename("maze.MazeBtn2");
         _maze3 = ComponentFactory.Instance.creatComponentByStylename("maze.MazeBtn3");
         _buttonMc1 = ComponentFactory.Instance.creatCustomObject("maze.MazeBtn2Mc");
         _maze2Mask = ComponentFactory.Instance.creatComponentByStylename("maze.MazeBtn2");
         _maze2Mask.x = 2;
         _maze2Mask.y = 133;
         _mazeGroup = new SelectedButtonGroup();
         _mazeGroup.addSelectItem(_maze1);
         _mazeGroup.addSelectItem(_maze2);
         _mazeGroup.addSelectItem(_maze3);
         _back1 = ComponentFactory.Instance.creatComponentByStylename("maze.FrameBack1");
         _back2 = ComponentFactory.Instance.creatComponentByStylename("maze.FrameBack2");
         _back3 = ComponentFactory.Instance.creatComponentByStylename("maze.FrameBack3");
         _back4 = ComponentFactory.Instance.creatComponentByStylename("maze.FrameBack4");
         _back5 = ComponentFactory.Instance.creatComponentByStylename("maze.FrameBack5");
         _back6 = ComponentFactory.Instance.creatComponentByStylename("maze.BackAsset");
         _myRecord = ComponentFactory.Instance.creatBitmap("asset.maze.MyRecordTxt");
         _myRecordTxt = ComponentFactory.Instance.creatComponentByStylename("maze.MyRecordValueTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("maze.DeascribeTxt");
         _myOrderTxt = ComponentFactory.Instance.creatComponentByStylename("maze.MyOrderValueTxt");
         _todayFreeCountValue = ComponentFactory.Instance.creatComponentByStylename("maze.TodayFreeCountValue");
         _todayPropCountValue = ComponentFactory.Instance.creatComponentByStylename("maze.TodayPropCountValue");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("maze.HelpBtn");
         _orderBtn = ComponentFactory.Instance.creatComponentByStylename("maze.OrderBtn");
         _shopBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MazeShopBtn");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("maze.StartBtn");
         _mopupBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MopupStartBtn");
         _showtipbtn = ComponentFactory.Instance.creatComponentByStylename("maze.showTipBtn");
         _showtipbtn.addChild(_mopupBtn);
         _mopupBtn.x = _mopupBtn.y = 0;
         _spliceLine1 = ComponentFactory.Instance.creatComponentByStylename("maze.SpliceLine1");
         _spliceLine2 = ComponentFactory.Instance.creatComponentByStylename("maze.SpliceLine2");
         _doubleProfit = ComponentFactory.Instance.creatBitmap("asset.maze.GetDoubleProfit");
         _doubleProfit2 = ComponentFactory.Instance.creatBitmap("asset.maze.GetDoubleProfit2");
         _doubleProfitBtn = ComponentFactory.Instance.creatComponentByStylename("maze.DoubleProfitSelectButton");
         _myOrder = ComponentFactory.Instance.creatBitmap("asset.maze.MyOrderTxt");
         _todayFreeCount = ComponentFactory.Instance.creatBitmap("asset.maze.TodayFreeCountTxt");
         _todayPropCount = ComponentFactory.Instance.creatBitmap("asset.maze.TodayPropCountTxt");
         _curLayerBit = ComponentFactory.Instance.creatBitmap("asset.maze.CurrentFloorTxt");
         _totalGp = ComponentFactory.Instance.creatBitmap("asset.maze.TotalExpTxt");
         _curLayerValue = ComponentFactory.Instance.creatComponentByStylename("maze.CurLayerTxt");
         _totalGpValue = ComponentFactory.Instance.creatComponentByStylename("maze.TotalGpTxt");
         _resetBtn = ComponentFactory.Instance.creatComponentByStylename("maze.ResetBtn");
         _continueBtn = ComponentFactory.Instance.creatComponentByStylename("maze.ContinueBtn");
         _fallLinkTxt = ComponentFactory.Instance.creatComponentByStylename("maze.fall.FallItemsLinkTxt");
         _continueMopupBtn = ComponentFactory.Instance.creatComponentByStylename("maze.MopupContinueBtn");
         titleText = LanguageMgr.GetTranslation("maze.MazeFrame.title");
         addToContent(_maze1);
         _buttonMc1.gotoAndStop(1);
         _buttonMc1["pos"].addChild(_maze2);
         addToContent(_buttonMc1);
         addToContent(_maze3);
         addToContent(_back1);
         addToContent(_back2);
         addToContent(_back3);
         addToContent(_back4);
         addToContent(_back5);
         addToContent(_back6);
         addToContent(_orderBtn);
         addToContent(_shopBtn);
         addToContent(_startBtn);
         addToContent(_showtipbtn);
         addToContent(_spliceLine1);
         addToContent(_spliceLine2);
         addToContent(_myRecord);
         addToContent(_myOrder);
         addToContent(_descTxt);
         addToContent(_todayFreeCount);
         addToContent(_todayPropCount);
         addToContent(_myRecordTxt);
         _myRecordTxt.x = _myRecord.x + _myRecord.width + 5;
         addToContent(_myOrderTxt);
         addToContent(_todayFreeCountValue);
         addToContent(_todayPropCountValue);
         addToContent(_curLayerBit);
         addToContent(_totalGp);
         addToContent(_curLayerValue);
         addToContent(_totalGpValue);
         addToContent(_fallLinkTxt);
         addToContent(_resetBtn);
         addToContent(_continueBtn);
         addToContent(_continueMopupBtn);
         addToContent(_doubleProfit);
         addToContent(_doubleProfit2);
         addToContent(_doubleProfitBtn);
         _doubleProfitBtn.selected = true;
         var _loc2_:Boolean = Boolean(VersionSwitch.MAZE_SWTICH);
         var _loc1_:Boolean = PlayerManager.instance.currentPlayerModel.towerInfo2.campaignId != 0;
         _maze2.enable = _loc2_ && _loc1_;
         setBtnMcState();
         _helpBtn.tipData = LanguageMgr.GetTranslation("maze.MazeFrame.helpTipData");
         _showtipbtn.visible = false;
         if(_loc2_ && !_loc1_)
         {
            addToContent(_maze2Mask);
         }
         if(towerInfo.maxIndex < 10)
         {
            _mopupBtn.enable = false;
            _showtipbtn.visible = true;
            _continueMopupBtn.enable = false;
         }
         else if(towerInfo.maxIndex == towerInfo.towerIndex)
         {
            _continueMopupBtn.enable = false;
         }
         else
         {
            _mopupBtn.enable = true;
            _showtipbtn.visible = false;
            _continueMopupBtn.enable = true;
         }
         _showtipbtn.tipData = LanguageMgr.GetTranslation("Room.maze.MazeFrame.showtipbtn.tipData");
      }
      
      private function setBtnMcState() : void
      {
         if(_maze2.enable && !SharedManager.instance.difficultMazeBtnShine)
         {
            _buttonMc1.gotoAndPlay(1);
         }
      }
      
      private function initFloorPoint() : void
      {
         var _loc1_:int = 0;
         _floorPoint1 = [];
         _floorItems1 = [];
         _loc1_ = 1;
         while(_loc1_ <= 10)
         {
            _floorPoint1.push(ComponentFactory.Instance.creatCustomObject("maze.FloorPoint_1_" + _loc1_));
            _loc1_++;
         }
         _floorPoint2 = [];
         _floorItems2 = [];
         _loc1_ = 1;
         while(_loc1_ <= 6)
         {
            _floorPoint2.push(ComponentFactory.Instance.creatCustomObject("maze.FloorPoint_2_" + _loc1_));
            _loc1_++;
         }
      }
      
      public function get startBtn() : IconButton
      {
         return _startBtn;
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _mazeGroup.addEventListener("change",__mazePanelChangeHandler);
         _startBtn.addEventListener("click",__startTowerInfoHandler);
         _orderBtn.addEventListener("click",__openOrderHandler);
         _shopBtn.addEventListener("click",__onShopClick);
         _mopupBtn.addEventListener("click",__startMopupHandler);
         _continueMopupBtn.addEventListener("click",__continueMopupHandler);
         _resetBtn.addEventListener("click",__resetHandler);
         _continueBtn.addEventListener("click",__continueHandler);
         _maze2Mask.addEventListener("click",__mashClickHandler);
         _helpBtn.addEventListener("click",__helpBtnClickHandler);
         _fallLinkTxt.addEventListener("click",__fallLinkHandler);
         PlayerManager.instance.addEventListener("UPDATE_TOWER_INFO",__updateTowerInfoHandler);
         _maze3.addEventListener("click",__maze3BtnClickHandler,false,1000);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         _mazeGroup.removeEventListener("change",__mazePanelChangeHandler);
         _startBtn.removeEventListener("click",__startTowerInfoHandler);
         _orderBtn.removeEventListener("click",__openOrderHandler);
         _shopBtn.removeEventListener("click",__onShopClick);
         _mopupBtn.removeEventListener("click",__startMopupHandler);
         _continueMopupBtn.removeEventListener("click",__continueMopupHandler);
         _resetBtn.removeEventListener("click",__resetHandler);
         _continueBtn.removeEventListener("click",__continueHandler);
         _maze2Mask.removeEventListener("click",__mashClickHandler);
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__helpBtnClickHandler);
         }
         _fallLinkTxt.removeEventListener("click",__fallLinkHandler);
         PlayerManager.instance.removeEventListener("UPDATE_TOWER_INFO",__updateTowerInfoHandler);
         if(_maze3)
         {
            _maze3.removeEventListener("click",__maze3BtnClickHandler);
         }
      }
      
      private function __maze3BtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         SoundManager.instance.play("022");
         var _loc6_:Boolean = Boolean(VersionSwitch.MAZE_SWTICH);
         var _loc5_:Boolean = PlayerManager.instance.currentPlayerModel.towerInfo2.campaignId != 0;
         if(_loc6_ == false || _loc5_ == false)
         {
            _loc2_ = LanguageMgr.GetTranslation("maze.MazeFrame.Maze2openContent");
            MessageTipManager.instance().show(_loc2_);
            param1.stopImmediatePropagation();
            return;
         }
         var _loc4_:PlayerInfo = PlayerManager.instance.currentPlayerModel.playerInfo;
         if(_loc4_.vocationGrades <= 0)
         {
            _loc3_ = LanguageMgr.GetTranslation("store.view.StoreFrame.command02",80);
            MessageTipManager.instance().show(_loc3_);
            param1.stopImmediatePropagation();
         }
      }
      
      private function __helpBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = null;
         SoundManager.instance.play("022");
         _loc2_ = ComponentFactory.Instance.creatComponentByStylename("maze.MazeHelpFrame1");
         _loc2_.show();
      }
      
      private function __mashClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:String = LanguageMgr.GetTranslation("maze.MazeFrame.Maze2openContent");
         MessageTipManager.instance().show(_loc2_);
         _maze2Mask.selected = false;
      }
      
      private function __mazePanelChangeHandler(param1:Event) : void
      {
         SoundManager.instance.play("011");
         _currentIndex = _mazeGroup.selectIndex;
         SocketSendManager.instance.requestTowerInfo(_currentIndex);
         mazeModel.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         if(_currentIndex == 1)
         {
            stopMaze2BtnMc();
         }
      }
      
      private function stopMaze2BtnMc() : void
      {
         _buttonMc1.gotoAndStop(1);
         SharedManager.instance.difficultMazeBtnShine = true;
         SharedManager.instance.saveDifficultMazeBtnShine();
      }
      
      private function __onShopClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         FrameControllerManager.instance.openControllerByInfo("shop",4);
      }
      
      private function __fallLinkHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:MazeFallItemsFrame = ComponentFactory.Instance.creatComponentByStylename("campaign.maze.FallItemsFrame");
         _loc2_.show(this);
         _loc2_.data = "";
      }
      
      private function __openOrderHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         mazeModel.addEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         FrameControllerManager.instance.mazeControler.loadMazeOrderData(_currentIndex);
      }
      
      private function __orderDataLoadCompleteHandler(param1:Event) : void
      {
         mazeModel.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         var _loc2_:MazeOrderFrame = ComponentFactory.Instance.creatComponentByStylename("maze.order.MazeOrderFrame");
         _loc2_.show(_currentIndex);
      }
      
      private function __startMopupHandler(param1:MouseEvent) : void
      {
         var _loc3_:int = 0;
         SoundManager.instance.play("022");
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumBySonType(297));
         if(towerInfo.enterCount >= towerInfo.maxEnterCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("maze.MazeFrame.command01"));
            return;
         }
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mopup.MopupManager.noMopupAlert"));
            return;
         }
         if(_mazeGroup.selectIndex == 0)
         {
            if(_doubleProfitBtn.selected && _loc2_ <= 0)
            {
               openBuyKeyFrame();
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("mopup",3,0);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
         else if(_mazeGroup.selectIndex == 1)
         {
            if(_doubleProfitBtn.selected && _loc2_ < 3)
            {
               openBuyKeyFrame(208008,3);
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("mopup",3,1);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
         else if(_mazeGroup.selectIndex == 2)
         {
            _loc3_ = int(GoodsManager.instance.getGoodsNumByTempId(208037));
            if(_doubleProfitBtn.selected && _loc3_ < 3)
            {
               openBuyKeyFrame(208037,3);
               return;
            }
            FrameControllerManager.instance.openControllerByInfo("mopup",3,2);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
      }
      
      private function __continueMopupHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         if(SceneManager.instance.currentType == "OUTER_CITY_SCENE")
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("mopup.MopupManager.noMopupAlert"));
            return;
         }
         if(_mazeGroup.selectIndex == 0)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",3,0);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
         else if(_mazeGroup.selectIndex == 1)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",3,1);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
         else if(_mazeGroup.selectIndex == 2)
         {
            FrameControllerManager.instance.openControllerByInfo("mopup",3,2);
            MopupManager.instance.model.isDoubleProfit = _doubleProfitBtn.selected ? 2 : 1;
         }
      }
      
      private function __resetHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SimpleAlertHelper.instance.data = [__resetMazeLevel];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("maze.MazeFrame.content");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_,true);
      }
      
      private function __resetMazeLevel(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            RoomSocketOuterManager.resetTowerInfo(_currentIndex);
         }
      }
      
      private function __continueHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         RoomSocketOuterManager.enterTowerInfo(towerInfo.campaignId,0);
      }
      
      private function __startTowerInfoHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         if(towerInfo.enterCount >= towerInfo.maxEnterCount)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("maze.MazeFrame.command01"));
            return;
         }
         var _loc3_:int = int(GoodsManager.instance.getGoodsNumByTempId(208008));
         if(_currentIndex == 0)
         {
            if(_doubleProfitBtn.selected && _loc3_ <= 0)
            {
               openBuyKeyFrame();
               return;
            }
         }
         if(_currentIndex == 1)
         {
            if(_doubleProfitBtn.selected && _loc3_ < 3)
            {
               openBuyKeyFrame(208008,3);
               return;
            }
         }
         else if(_currentIndex == 2)
         {
            _loc2_ = int(GoodsManager.instance.getGoodsNumByTempId(208037));
            if(_doubleProfitBtn.selected && _loc2_ < 3)
            {
               openBuyKeyFrame(208037,3);
               return;
            }
         }
         RoomSocketOuterManager.enterTowerInfo(towerInfo.campaignId,1,_doubleProfitBtn.selected ? 2 : 1);
      }
      
      private function __updateTowerInfoHandler(param1:PlayerEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc2_:String = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         refreshFloors();
         _back6.setFrame(_currentIndex + 1);
         _descTxt.setFrame(_currentIndex + 1);
         _myRecordTxt.text = towerInfo.maxIndex < 0 ? "0" : towerInfo.maxIndex.toString();
         var _loc1_:String = LanguageMgr.GetTranslation("maze.MazeFrame.Order");
         _myOrderTxt.text = "" + (towerInfo.maxIndex == 0 || towerInfo.order == 0 ? _loc1_ : towerInfo.order);
         _descTxt.y = 142;
         _spliceLine1.y = 140;
         _spliceLine2.y = 200;
         _fallLinkTxt.y = 202;
         _startBtn.visible = false;
         _showtipbtn.visible = false;
         _doubleProfit.visible = false;
         _doubleProfit2.visible = false;
         _doubleProfitBtn.visible = false;
         _doubleProfitBtn.selected = false;
         _curLayerBit.visible = false;
         _totalGp.visible = false;
         _curLayerValue.visible = false;
         _totalGpValue.visible = false;
         _resetBtn.visible = false;
         _continueBtn.visible = false;
         _continueMopupBtn.visible = false;
         _fallLinkTxt.mouseEnabled = false;
         _todayFreeCount.visible = false;
         _todayFreeCountValue.visible = false;
         _todayPropCount.visible = false;
         _todayPropCountValue.visible = false;
         _todayFreeCountValue.text = "";
         _todayPropCountValue.text = "";
         _curLayerValue.text = "";
         _totalGpValue.text = "";
         _fallLinkTxt.htmlText = "";
         _curLayerBit.y = 239;
         _totalGp.y = 265;
         _curLayerValue.y = 235;
         _totalGpValue.y = 261;
         _todayFreeCount.y = 190;
         _todayFreeCountValue.y = 189;
         _curLayerBit.y = 222;
         _totalGp.y = 251;
         _curLayerValue.y = 220;
         _totalGpValue.y = 249;
         _todayFreeCount.y = 215;
         _todayFreeCountValue.y = 214;
         _doubleProfit.y = 240;
         _doubleProfitBtn.y = 250;
         _todayPropCount.y = 215;
         _todayPropCountValue.y = 215;
         if(towerInfo.towerIndex > 0)
         {
            _curLayerBit.visible = true;
            _totalGp.visible = true;
            _curLayerValue.visible = true;
            _curLayerValue.text = "" + towerInfo.towerIndex + "";
            _totalGpValue.visible = true;
            _totalGpValue.text = "" + towerInfo.totalGp + "";
            _resetBtn.visible = true;
            _resetBtn.x = 548;
            _resetBtn.y = 340;
            _continueBtn.visible = true;
            _continueBtn.x = 435;
            _continueBtn.y = 340;
            _continueMopupBtn.visible = true;
            _continueMopupBtn.x = 440;
            _continueMopupBtn.y = 295;
            _loc2_ = LanguageMgr.GetTranslation("maze.MazeFrame.fallLink");
            _fallLinkTxt.htmlText = "<a href =\'event: \'><u><b> " + _loc2_ + " </b></u></a>";
            _fallLinkTxt.mouseEnabled = true;
         }
         else
         {
            _startBtn.visible = true;
            _showtipbtn.visible = true;
            _loc5_ = towerInfo.freeEnterCount - towerInfo.enterCount;
            _loc5_ = int(_loc5_ > 0 ? _loc5_ : 0);
            _todayFreeCountValue.text = LanguageMgr.GetTranslation("public.slash",_loc5_,towerInfo.freeEnterCount);
            _loc3_ = towerInfo.maxEnterCount - towerInfo.freeEnterCount;
            _loc4_ = towerInfo.enterCount >= towerInfo.freeEnterCount ? towerInfo.maxEnterCount - towerInfo.enterCount : towerInfo.maxEnterCount - towerInfo.freeEnterCount;
            _loc4_ = int(_loc4_ < 0 ? 0 : _loc4_);
            _todayPropCountValue.text = LanguageMgr.GetTranslation("public.slash",_loc4_,_loc3_);
         }
         if(_currentIndex == 1)
         {
            _descTxt.y = 142;
            _spliceLine1.y = 140;
            _spliceLine2.y = 200;
            _fallLinkTxt.y = 202;
            if(towerInfo.towerIndex <= 0)
            {
               _todayPropCount.visible = true;
               _todayPropCountValue.visible = true;
               _doubleProfit.visible = true;
               _doubleProfitBtn.visible = true;
               _doubleProfitBtn.selected = true;
            }
         }
         else if(_currentIndex == 0)
         {
            if(towerInfo.towerIndex <= 0)
            {
               _todayFreeCount.visible = true;
               _todayFreeCountValue.visible = true;
               _doubleProfit.visible = true;
               _doubleProfitBtn.visible = true;
               _doubleProfitBtn.selected = true;
            }
         }
         else if(_currentIndex == 2)
         {
            _descTxt.y = 142;
            _spliceLine1.y = 140;
            _spliceLine2.y = 200;
            _fallLinkTxt.y = 202;
            _curLayerBit.y = 237;
            _totalGp.y = 266;
            _curLayerValue.y = 235;
            _totalGpValue.y = 264;
            _todayPropCount.y = 202;
            _todayPropCountValue.y = 202;
            _doubleProfit2.y = 260;
            _doubleProfitBtn.y = 270;
            if(towerInfo.towerIndex <= 0)
            {
               _todayPropCount.visible = true;
               _todayPropCountValue.visible = true;
               _doubleProfit2.visible = true;
               _doubleProfitBtn.visible = true;
               _doubleProfitBtn.selected = true;
            }
         }
         if(towerInfo.maxIndex >= 10 && towerInfo.towerIndex < towerInfo.maxIndex)
         {
            _mopupBtn.enable = true;
            _continueMopupBtn.enable = true;
            _showtipbtn.tipData = null;
         }
         else
         {
            _mopupBtn.enable = false;
            _continueMopupBtn.enable = false;
            _showtipbtn.tipData = LanguageMgr.GetTranslation("Room.maze.MazeFrame.showtipbtn.tipData");
         }
      }
      
      private function refreshFloors() : void
      {
         var _loc4_:int = 0;
         var _loc1_:MazeFloorItem = null;
         removeFloors();
         var _loc3_:int = towerInfo.maxIndex + 10;
         _loc3_ = Math.floor(_loc3_ / 10);
         var _loc2_:ColorMatrixFilter = new ColorMatrixFilter([0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0.3,0.59,0.11,0,0,0,0,0,1,0]);
         if(_currentIndex == 0)
         {
            _loc4_ = 1;
            while(_loc4_ <= 10)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("maze.FloorItem",[_loc4_ * 10,1]);
               _loc1_.x = _floorPoint1[_loc4_ - 1].x;
               _loc1_.y = _floorPoint1[_loc4_ - 1].y;
               _floorItems1.push(_loc1_);
               if(_loc4_ > _loc3_)
               {
                  _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
                  _loc1_.filters = [_loc2_];
               }
               else
               {
                  _loc1_.mouseChildren = _loc1_.mouseEnabled = true;
                  _loc1_.filters = null;
               }
               _loc4_++;
            }
         }
         else if(_currentIndex == 1)
         {
            _loc3_ = towerInfo.maxIndex + 5;
            _loc3_ = Math.floor(_loc3_ / 5);
            _loc4_ = 1;
            while(_loc4_ <= 6)
            {
               _loc1_ = ComponentFactory.Instance.creatCustomObject("maze.FloorItem",[_loc4_ * 5,2]);
               _loc1_.x = _floorPoint2[_loc4_ - 1].x;
               _loc1_.y = _floorPoint2[_loc4_ - 1].y;
               _floorItems2.push(_loc1_);
               if(_loc4_ > _loc3_)
               {
                  _loc1_.mouseChildren = _loc1_.mouseEnabled = false;
                  _loc1_.filters = [_loc2_];
               }
               else
               {
                  _loc1_.mouseChildren = _loc1_.mouseEnabled = true;
                  _loc1_.filters = null;
               }
               _loc4_++;
            }
         }
         else if(_currentIndex == 2)
         {
            return;
         }
      }
      
      private function removeFloors() : void
      {
         var _loc1_:MazeFloorItem = null;
         while(_floorItems1.length > 0)
         {
            _loc1_ = _floorItems1.pop();
            _loc1_.dispose();
         }
         while(_floorItems2.length > 0)
         {
            _loc1_ = _floorItems2.pop();
            _loc1_.dispose();
         }
      }
      
      private function openBuyKeyFrame(param1:int = 208008, param2:int = 1) : void
      {
         var keyTempId:int = param1;
         var buyNum:int = param2;
         var quickUIcallback:Function = function():void
         {
            var _loc1_:BuyFrameI = ComponentFactory.Instance.creatComponentByStylename("quickbuy.buyFrame");
            var _loc2_:ShopGoodsInfo = TempleteManager.instance.getShopTempInfoByItemId(keyTempId);
            _loc1_.data(_loc2_,buyNum);
            _loc1_.show();
         };
         CheckUIModuleUtil.instance.tryCall("quickbuy",quickUIcallback);
      }
      
      private function get mazeModel() : MazeModel
      {
         return MazeModel.instance;
      }
      
      private function get towerInfo() : TowerInfo
      {
         return PlayerManager.instance.currentPlayerModel.towerInfo;
      }
      
      public function show(param1:Boolean = false) : void
      {
         if(param1 && Boolean(_maze2.enable))
         {
            _buttonMc1.gotoAndPlay(1);
         }
         LayerManager.Instance.addToLayer(this,3,true,true);
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
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_mazeGroup);
         _mazeGroup = null;
         ObjectUtils.disposeObject(_buttonMc1);
         _buttonMc1 = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

