package llk.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.LlkManager;
   import mvc.module.llk.LlkDeleteData;
   import mvc.module.llk.LlkModel;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.timer.TimerTicker;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.base.Progress;
   import yishi.view.frame.SimpleHelpFrame;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tools.SimpleMovie;
   
   public class LlkFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObjectContainer;
      
      private var _listView:Sprite;
      
      private var _nodeList:Vector.<LlkNodeView>;
      
      private var _selected:LlkNodeView;
      
      private var _progress:Progress;
      
      private var _gateSp:Sprite;
      
      private var _gateNumRes:BitmapData;
      
      private var _gateNum:int;
      
      private var _scoreTxt:FilterFrameText;
      
      private var _physicalTxt:FilterFrameText;
      
      private var _timeTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _sortBtn:IconButton;
      
      private var _allGetBtn:IconButton;
      
      private var _tidyBtn:IconButton;
      
      private var _goods1:LlkGoodsItem;
      
      private var _goods2:LlkGoodsItem;
      
      private var _timer:TimerTicker;
      
      private var _bagView:LlkBagView;
      
      private var _boxView:Sprite;
      
      private var _boxList:Vector.<LlkBoxItem>;
      
      private var _physicalPoint:int;
      
      private var _combNumRes:BitmapData;
      
      private var _scoreNumRes:BitmapData;
      
      private var _deleMc:SimpleMovie;
      
      private var _helpBtn:BaseButton;
      
      private var _frame:TodayNotAlertFrame;
      
      public function LlkFrame()
      {
         super();
         TempleteManager.instance.tollgateRewardCate.getTemplatesListByNeedScore();
         initView();
         initNode();
         initEvent();
         requestInfo();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,590);
      }
      
      override public function get groups() : Array
      {
         return ["BAG_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:LlkBoxItem = null;
         titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_llk");
         _bg = ComponentFactory.Instance.creat("asset.llk.background");
         _gateNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.gateNum");
         _combNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.combNum");
         _scoreNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.scoreNum");
         _progress = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.progress");
         _scoreTxt = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.scoreTxt");
         _physicalTxt = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.physicalTxt");
         _timeTxt = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.timeTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.startBtn");
         _sortBtn = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.sortBtn");
         _allGetBtn = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.allGetBtn");
         _tidyBtn = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.tidyBtn");
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.HelpBtn");
         _listView = new Sprite();
         _nodeList = new Vector.<LlkNodeView>();
         _gateSp = new Sprite();
         _goods1 = new LlkGoodsItem();
         _goods2 = new LlkGoodsItem();
         _timer = new TimerTicker(1000);
         _bagView = new LlkBagView();
         _boxView = new Sprite();
         _boxList = new Vector.<LlkBoxItem>();
         _listView.x = -12;
         _listView.y = 28;
         _gateSp.x = 240;
         _gateSp.y = 6;
         _goods1.type = 1;
         _goods1.x = 616;
         _goods1.y = 155;
         _goods2.type = 2;
         _goods2.x = 616;
         _goods2.y = 283;
         _bagView.x = 7;
         _bagView.y = 417;
         _boxView.y = 365;
         _loc1_ = 0;
         while(_loc1_ < 5)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("LlkFrame.LlkBoxItem" + _loc1_);
            _loc2_.tipData = TempleteManager.instance.tollgateRewardCate.arr[_loc1_];
            _boxList.push(_loc2_);
            _boxView.addChild(_loc2_);
            _loc1_++;
         }
         _physicalPoint = 10;
         var _loc3_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("linkgame_strength_need");
         if(_loc3_ && parseInt(_loc3_.ConfigValue))
         {
            _physicalPoint = parseInt(_loc3_.ConfigValue);
         }
         _helpBtn.tipData = LanguageMgr.GetTranslation("public.help");
         _startBtn.visible = false;
         addToContent(_bg);
         addToContent(_gateSp);
         addToContent(_listView);
         addToContent(_progress);
         addToContent(_scoreTxt);
         addToContent(_physicalTxt);
         addToContent(_timeTxt);
         addToContent(_startBtn);
         addToContent(_sortBtn);
         addToContent(_allGetBtn);
         addToContent(_tidyBtn);
         addToContent(_goods1);
         addToContent(_goods2);
         addToContent(_bagView);
         addToContent(_boxView);
         addToContent(_helpBtn);
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeAllChildren(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_gateSp);
         _gateSp = null;
         ObjectUtils.disposeAllChildren(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_progress);
         _progress = null;
         ObjectUtils.disposeObject(_scoreTxt);
         _scoreTxt = null;
         ObjectUtils.disposeObject(_physicalTxt);
         _physicalTxt = null;
         ObjectUtils.disposeObject(_timeTxt);
         _timeTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_sortBtn);
         _sortBtn = null;
         ObjectUtils.disposeObject(_allGetBtn);
         _allGetBtn = null;
         ObjectUtils.disposeObject(_tidyBtn);
         _tidyBtn = null;
         ObjectUtils.disposeObject(_goods1);
         _goods1 = null;
         ObjectUtils.disposeObject(_goods2);
         _goods2 = null;
         ObjectUtils.disposeObject(_bagView);
         _bagView = null;
         ObjectUtils.disposeObject(_boxView);
         _boxView = null;
         ObjectUtils.disposeObject(_combNumRes);
         _combNumRes = null;
         ObjectUtils.disposeObject(_helpBtn);
         _helpBtn = null;
         if(_combNumRes)
         {
            _combNumRes.dispose();
         }
         _combNumRes = null;
         if(_scoreNumRes)
         {
            _scoreNumRes.dispose();
         }
         _scoreNumRes = null;
         if(_gateNumRes)
         {
            _gateNumRes.dispose();
         }
         _gateNumRes = null;
         if(_frame)
         {
            _frame.dispose();
         }
         _frame = null;
         if(_deleMc)
         {
            _deleMc.dispose();
         }
         _deleMc = null;
         while(_nodeList && _nodeList.length > 0)
         {
            _nodeList.pop().dispose();
         }
         while(_boxList && _boxList.length > 0)
         {
            _boxList.pop().dispose();
         }
      }
      
      private function initNode() : void
      {
         var _loc1_:LlkNodeView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < LlkModel.ROW * LlkModel.COLUMN)
         {
            _loc1_ = new LlkNodeView();
            _loc1_.data = model.list[_loc2_];
            _loc1_.x = _loc2_ % LlkModel.COLUMN * LlkNodeView.WIDTH;
            _loc1_.y = Math.floor(_loc2_ / LlkModel.COLUMN) * LlkNodeView.HEIGHT;
            _nodeList.push(_loc1_);
            _loc2_++;
         }
         _loc2_ = LlkModel.COLUMN - 1;
         while(_loc2_ >= 0)
         {
            _loc3_ = 0;
            while(_loc3_ < LlkModel.ROW)
            {
               _listView.addChild(_nodeList[_loc3_ * LlkModel.COLUMN + _loc2_]);
               _loc3_++;
            }
            _loc2_--;
         }
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         if(_gateNum <= 0)
         {
            return;
         }
         if(isNullMap)
         {
            model.info.time = 0;
         }
         _timeTxt.text = model.info.time + "S";
         if(model.info.time > 0)
         {
            model.info.time -= 1;
         }
      }
      
      private function startTimer() : void
      {
         if(_timer && !_timer.hasEventListener("timer"))
         {
            _timer.addEventListener("timer",__timerHandler);
            _timer.start();
         }
      }
      
      private function stopTimer() : void
      {
         if(_timer)
         {
            _timer.removeEventListener("timer",__timerHandler);
            _timer.stop();
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_listView)
         {
            _listView.addEventListener("click",__clickHandler);
         }
         if(_startBtn)
         {
            _startBtn.addEventListener("click",__startBtnHandler);
         }
         if(_sortBtn)
         {
            _sortBtn.addEventListener("click",__sortBtnHandler);
         }
         if(_allGetBtn)
         {
            _allGetBtn.addEventListener("click",__allGetBtnHandler);
         }
         if(_tidyBtn)
         {
            _tidyBtn.addEventListener("click",__tidyBtnHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.addEventListener("click",__openHelpHandler);
         }
         MsgMan.addObserver(LlkModel.LLK_INFO,this,__infoHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4738,__resetHandler);
         startTimer();
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_listView)
         {
            _listView.removeEventListener("click",__clickHandler);
         }
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__startBtnHandler);
         }
         if(_sortBtn)
         {
            _sortBtn.removeEventListener("click",__sortBtnHandler);
         }
         if(_allGetBtn)
         {
            _allGetBtn.removeEventListener("click",__allGetBtnHandler);
         }
         if(_tidyBtn)
         {
            _tidyBtn.removeEventListener("click",__tidyBtnHandler);
         }
         if(_helpBtn)
         {
            _helpBtn.removeEventListener("click",__openHelpHandler);
         }
         MsgMan.removeObserver(LlkModel.LLK_INFO,this,__infoHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4738,__resetHandler);
         stopTimer();
      }
      
      private function __resetHandler(param1:SLGSocketEvent) : void
      {
         SimpleAlertHelper.instance.data = [requestInfo];
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc2_:String = LanguageMgr.GetTranslation("llk.view.LlkFrame.reset.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("public.confirm");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc2_,_loc3_,"",false,true,true);
      }
      
      private function requestInfo(param1:Boolean = false, param2:Boolean = false) : void
      {
         LlkManager.llkOp(1);
      }
      
      private function __startBtnHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(model.info.strength > 0)
         {
            _startBtn.enable = false;
            LlkManager.llkOp(12);
         }
         else
         {
            _frame = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.PhysicalAlertFrame");
            _loc2_ = LanguageMgr.GetTranslation("llk.view.LlkFrame.noEnoughPhysical",_physicalPoint);
            _frame.show(_loc2_,"",confirmCall);
         }
      }
      
      private function __openHelpHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("LlkFrame.HelpFrame");
         _loc2_.show();
      }
      
      private function __sortBtnHandler(param1:MouseEvent) : void
      {
         LlkManager.instance.opSortFrame();
         LlkManager.llkOp(8);
      }
      
      private function __allGetBtnHandler(param1:MouseEvent) : void
      {
         LlkManager.llkOp(9);
      }
      
      private function __tidyBtnHandler(param1:MouseEvent) : void
      {
         _bagView.tidy();
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _scoreTxt.text = model.info.score + "";
         _physicalTxt.text = model.info.strength + "";
         _goods1.refresh();
         _goods2.refresh();
         if(_gateNum != model.info.gate)
         {
            _selected = null;
            _gateNum = model.info.gate;
            if(_gateNum < 10)
            {
               _gateSp.x = 240;
            }
            else if(_gateNum < 100)
            {
               _gateSp.x = 225;
            }
            NumberViewUtils.refreshValue(_gateNum,_gateSp,_gateNumRes,31,32,16,31,"0123456789");
         }
         while(model.info.deleteList.length > 0)
         {
            deleteNode(model.info.deleteList.shift());
         }
         _loc3_ = 0;
         while(_loc3_ < LlkModel.ROW * LlkModel.COLUMN)
         {
            _nodeList[_loc3_].data = model.list[_loc3_];
            _loc3_++;
         }
         if(StringHelper.isNullOrEmpty(model.info.points))
         {
            _listView.visible = false;
            _startBtn.visible = true;
            _startBtn.enable = true;
         }
         else
         {
            _listView.visible = true;
            _startBtn.visible = false;
         }
         setProgress();
      }
      
      private function setProgress() : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _boxList[_loc2_].level = _loc2_;
            _loc2_++;
         }
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            if(model.info.score < model.info.boxList[_loc2_].score)
            {
               if(_loc2_ > 0)
               {
                  _loc1_ += (model.info.score - model.info.boxList[_loc2_ - 1].score) * (_boxList[_loc2_].x - _loc1_) / (model.info.boxList[_loc2_].score - model.info.boxList[_loc2_ - 1].score);
               }
               else
               {
                  _loc1_ = model.info.score / model.info.boxList[0].score * _boxList[0].x;
               }
               break;
            }
            _loc1_ = int(_boxList[_loc2_].x);
            _loc2_++;
         }
         _progress.setData(_loc1_,545);
      }
      
      private function confirmCall(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = int(PlayerManager.instance.currentPlayerModel.playerInfo.point);
         if(param2)
         {
            _loc3_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
         }
         if(_loc3_ < _physicalPoint)
         {
            RechargeAlertMannager.show();
            return;
         }
         LlkManager.llkBuy(5,param2);
         _frame = null;
         LlkManager.llkOp(12);
      }
      
      private function deleteNode(param1:LlkDeleteData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MovieClip = null;
         if(LlkManager.instance.model.checkByPos(param1.node1,param1.node2,true))
         {
            model.list[param1.node1.row * LlkModel.COLUMN + param1.node1.col].mcType = 3;
            model.list[param1.node2.row * LlkModel.COLUMN + param1.node2.col].mcType = 4;
            _loc3_ = 0;
            while(_loc3_ < _nodeList.length)
            {
               _nodeList[_loc3_].play();
               _loc3_++;
            }
            _loc2_ = ComponentFactory.Instance.creat("asset.llk.addScoreMc");
            NumberViewUtils.refreshValue(param1.addScore,_loc2_["effect"]["sp2"],_scoreNumRes,11,17,11,11,"0123456789");
            if(param1.combCount > 0)
            {
               NumberViewUtils.refreshValue(param1.combCount,_loc2_["effect"]["sp1"],_combNumRes,13,19,13,13,"0123456789");
            }
            else
            {
               _loc2_["effect"]["combTxt"].visible = false;
            }
            if(isNullMap)
            {
               _deleMc = new SimpleMovie(_loc2_,checkNullMap);
            }
            else
            {
               _deleMc = new SimpleMovie(_loc2_);
            }
            _deleMc.x = param1.node2.col * LlkNodeView.WIDTH + 10;
            _deleMc.y = param1.node2.row * LlkNodeView.HEIGHT - 10;
            _listView.addChild(_deleMc);
         }
      }
      
      private function checkNullMap() : void
      {
         if(isNullMap)
         {
            _listView.visible = false;
            _startBtn.visible = true;
            _startBtn.enable = true;
         }
         else
         {
            _listView.visible = true;
            _startBtn.visible = false;
         }
      }
      
      private function get isNullMap() : Boolean
      {
         var _loc3_:int = 0;
         if(StringHelper.isNullOrEmpty(model.info.points))
         {
            return true;
         }
         var _loc1_:Array = [];
         var _loc2_:Boolean = true;
         _loc1_ = model.info.points.split(",");
         _loc3_ = 0;
         while(_loc3_ < _loc1_.length)
         {
            if(_loc1_[_loc3_] != 0)
            {
               _loc2_ = false;
            }
            _loc3_++;
         }
         return _loc2_;
      }
      
      private function __responseHandler(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:LlkNodeView = null;
         if(_listView)
         {
            if(_listView.mouseX < LlkNodeView.WIDTH || _listView.mouseX >= (LlkModel.COLUMN - 1) * LlkNodeView.WIDTH)
            {
               return;
            }
            if(_listView.mouseY < LlkNodeView.HEIGHT || _listView.mouseY >= (LlkModel.ROW - 1) * LlkNodeView.HEIGHT)
            {
               return;
            }
            _loc4_ = Math.floor((_listView.mouseY - 5) / LlkNodeView.HEIGHT);
            _loc2_ = Math.floor((_listView.mouseX - 10) / LlkNodeView.WIDTH);
            _loc4_ = int(_loc4_ < 1 ? 1 : _loc4_);
            _loc4_ = int(_loc4_ > LlkModel.ROW - 1 ? LlkModel.ROW - 1 : _loc4_);
            _loc2_ = int(_loc2_ < 1 ? 1 : _loc2_);
            _loc2_ = int(_loc2_ > LlkModel.COLUMN - 1 ? LlkModel.COLUMN - 1 : _loc2_);
            _loc3_ = _nodeList[_loc4_ * LlkModel.COLUMN + _loc2_];
            if(_loc3_.data.val <= 0)
            {
               return;
            }
            if(_selected)
            {
               _selected.selected = false;
               if(model.checkByPos(_selected.data,_loc3_.data))
               {
                  LlkManager.llkDelete(_selected.data,_loc3_.data);
                  _selected = null;
               }
               else
               {
                  _selected = _loc3_;
                  _loc3_.selected = true;
               }
            }
            else
            {
               _selected = _loc3_;
               _loc3_.selected = true;
            }
         }
      }
      
      private function get model() : LlkModel
      {
         return LlkManager.instance.model;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         model.info.time = 0;
         if(isDie == false)
         {
            LlkManager.llkOp(11);
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

