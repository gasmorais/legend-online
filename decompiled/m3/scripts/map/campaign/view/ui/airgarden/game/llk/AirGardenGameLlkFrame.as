package map.campaign.view.ui.airgarden.game.llk
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Rectangle;
   import flash.utils.Timer;
   import manager.LanguageMgr;
   import managers.AirGardenGameLlkManager;
   import managers.MonopolySocketOutManager;
   import map.campaign.view.ui.airgarden.game.llk.view.AirGardenGameLlkGoodsItem;
   import map.campaign.view.ui.airgarden.game.llk.view.AirGardenGameLlkNodeView;
   import mvc.ModuleFrameInfo;
   import mvc.module.llk.LlkDeleteData;
   import mvc.module.llk.LlkModel;
   import mvc.module.stararea.StarareaManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.templates.CarnivalPlayGroundTemplateInfo;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.SimpleAlertHelper;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class AirGardenGameLlkFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObjectContainer;
      
      private var _listView:Sprite;
      
      private var _nodeList:Vector.<AirGardenGameLlkNodeView>;
      
      private var _selected:AirGardenGameLlkNodeView;
      
      private var _goods1:AirGardenGameLlkGoodsItem;
      
      private var _goods2:AirGardenGameLlkGoodsItem;
      
      private var _combNumRes:BitmapData;
      
      private var _scoreNumRes:BitmapData;
      
      private var _deleMc:SimpleMovie;
      
      private var _frame:TodayNotAlertFrame;
      
      private var _txtTime:FilterFrameText;
      
      private var _txtMyscore:FilterFrameText;
      
      private var _btnStart:IconButton;
      
      private var _timer:Timer;
      
      private var tickTime:int = 0;
      
      private var _targetScoreTxt:FilterFrameText;
      
      public function AirGardenGameLlkFrame()
      {
         super();
         _timer = new Timer(1000);
         TempleteManager.instance.tollgateRewardCate.getTemplatesListByNeedScore();
         initView();
         initNode();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,796,450);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         var _loc1_:CarnivalPlayGroundTemplateInfo = null;
         if(StarareaManager.instance.isStarareaGame)
         {
            titleText = LanguageMgr.GetTranslation("stararea.str6");
            _bg = ComponentFactory.Instance.creat("asset.llk.monopoly.background");
         }
         else
         {
            _bg = ComponentFactory.Instance.creat("asset.llk.airGarden.background");
            titleText = LanguageMgr.GetTranslation("AirGardenGame.llk.title");
         }
         _txtTime = ComponentFactory.Instance.creatComponentByStylename("airGarden.llk.timeTxt");
         _txtMyscore = ComponentFactory.Instance.creatComponentByStylename("airGarden.llk.scoreTxt");
         _combNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.combNum");
         _scoreNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.scoreNum");
         _btnStart = ComponentFactory.Instance.creatComponentByStylename("airGarden.llk.startBtn");
         _targetScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.carnival.txtLineScore");
         _listView = new Sprite();
         _nodeList = new Vector.<AirGardenGameLlkNodeView>();
         _goods1 = new AirGardenGameLlkGoodsItem();
         _goods2 = new AirGardenGameLlkGoodsItem();
         _listView.x = -12;
         _listView.y = -10;
         _goods1.type = 1;
         _goods1.x = 615;
         _goods1.y = 107;
         _goods2.type = 2;
         _goods2.x = 615;
         _goods2.y = 222;
         addToContent(_bg);
         addToContent(_listView);
         addToContent(_goods1);
         addToContent(_goods2);
         addToContent(_btnStart);
         addToContent(_targetScoreTxt);
         _txtTime.text = "0";
         _txtMyscore.text = "0";
         if(StarareaManager.instance.isStarareaGame)
         {
            _goods1.visible = _goods2.visible = false;
         }
         else
         {
            _loc1_ = TempleteManager.instance.carnivalPlayGroundTemplateCate.getTempByType(1);
            if(_loc1_)
            {
               _targetScoreTxt.text = LanguageMgr.GetTranslation("samll.game.score",_loc1_.Target);
            }
            addToContent(_txtTime);
            addToContent(_txtMyscore);
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_selected);
         _selected = null;
         ObjectUtils.disposeObject(_goods1);
         _goods1 = null;
         ObjectUtils.disposeObject(_goods2);
         _goods2 = null;
         ObjectUtils.disposeObject(_combNumRes);
         _combNumRes = null;
         ObjectUtils.disposeObject(_scoreNumRes);
         _scoreNumRes = null;
         ObjectUtils.disposeObject(_deleMc);
         _deleMc = null;
         ObjectUtils.disposeObject(_frame);
         _frame = null;
         ObjectUtils.disposeObject(_txtTime);
         _txtTime = null;
         ObjectUtils.disposeObject(_txtMyscore);
         _txtMyscore = null;
         ObjectUtils.disposeObject(_btnStart);
         _btnStart = null;
         ObjectUtils.disposeObject(_targetScoreTxt);
         _targetScoreTxt = null;
         while(_nodeList && _nodeList.length > 0)
         {
            _nodeList.pop().dispose();
         }
      }
      
      private function initNode() : void
      {
         var _loc1_:AirGardenGameLlkNodeView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < LlkModel.ROW * LlkModel.COLUMN)
         {
            _loc1_ = new AirGardenGameLlkNodeView();
            _loc1_.data = model.list[_loc2_];
            _loc1_.x = _loc2_ % LlkModel.COLUMN * AirGardenGameLlkNodeView.WIDTH;
            _loc1_.y = Math.floor(_loc2_ / LlkModel.COLUMN) * AirGardenGameLlkNodeView.HEIGHT;
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
      
      private function initEvent() : void
      {
         addEventListener("response",__responseHandler);
         if(_listView)
         {
            _listView.addEventListener("click",__clickHandler);
         }
         if(_btnStart)
         {
            _btnStart.addEventListener("click",__clickStart);
         }
         MsgMan.addObserver(LlkModel.LLK_INFO,this,__infoHandler);
         _timer.addEventListener("timer",tick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_listView)
         {
            _listView.removeEventListener("click",__clickHandler);
         }
         if(_btnStart)
         {
            _btnStart.removeEventListener("click",__clickStart);
         }
         MsgMan.removeObserver(LlkModel.LLK_INFO,this,__infoHandler);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",tick);
         }
      }
      
      private function requestInfo(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(!StarareaManager.instance.isStarareaGame)
         {
            AirGardenGameLlkManager.llkOp(1);
         }
         else
         {
            StarareaManager.instance.sendPlayGame(1,2);
         }
      }
      
      private function tick(param1:TimerEvent) : void
      {
         if(StarareaManager.instance.isStarareaGame)
         {
            return;
         }
         if(model.info.time == 0)
         {
            return;
         }
         var _loc2_:int = model.info.time - tickTime;
         _txtTime.text = _loc2_ + "";
         tickTime = tickTime + 1;
         if(_loc2_ <= 0)
         {
            dispose();
         }
      }
      
      private function __infoHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         _goods1.refresh();
         _goods2.refresh();
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
         }
         else
         {
            _listView.visible = true;
         }
         _txtMyscore.text = model.info.score + "";
      }
      
      private function deleteNode(param1:LlkDeleteData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MovieClip = null;
         if(AirGardenGameLlkManager.instance.model.checkByPos(param1.node1,param1.node2,true))
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
            _deleMc.x = param1.node2.col * AirGardenGameLlkNodeView.WIDTH + 10;
            _deleMc.y = param1.node2.row * AirGardenGameLlkNodeView.HEIGHT - 10;
            _listView.addChild(_deleMc);
         }
      }
      
      private function checkNullMap() : void
      {
         if(isNullMap)
         {
            _deleMc.clearCallBack();
            if(StarareaManager.instance.isStarareaGame)
            {
               StarareaManager.instance.isStarareaGame = false;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("MonopolyManager.GameTip02"));
               StarareaManager.instance.sendEvent("GAME_PASS");
            }
            else
            {
               MonopolySocketOutManager.sendTriggerConfirm();
            }
            dispose();
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
               check();
         }
      }
      
      private function check() : void
      {
         if(StarareaManager.instance.isStarareaGame)
         {
            dispose();
            return;
         }
         SimpleAlertHelper.instance.data = [realDispose];
         var _loc1_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc3_:String = LanguageMgr.GetTranslation("AirGardenGame.exit.hint");
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc3_,_loc1_,_loc2_,true,true);
      }
      
      private function realDispose(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            dispose();
         }
      }
      
      private function __clickStart(param1:MouseEvent) : void
      {
         _btnStart.visible = false;
         requestInfo();
         _timer.start();
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:AirGardenGameLlkNodeView = null;
         if(_listView)
         {
            if(_listView.mouseX < AirGardenGameLlkNodeView.WIDTH || _listView.mouseX >= (LlkModel.COLUMN - 1) * AirGardenGameLlkNodeView.WIDTH)
            {
               return;
            }
            if(_listView.mouseY < AirGardenGameLlkNodeView.HEIGHT || _listView.mouseY >= (LlkModel.ROW - 1) * AirGardenGameLlkNodeView.HEIGHT)
            {
               return;
            }
            _loc4_ = Math.floor((_listView.mouseY - 5) / AirGardenGameLlkNodeView.HEIGHT);
            _loc2_ = Math.floor((_listView.mouseX - 10) / AirGardenGameLlkNodeView.WIDTH);
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
                  if(StarareaManager.instance.isStarareaGame)
                  {
                     StarareaManager.instance.sendPlayGame(2,2,_selected.data.row + "," + _selected.data.col + "," + _loc3_.data.row + "," + _loc3_.data.col);
                  }
                  else
                  {
                     AirGardenGameLlkManager.llkDelete(_selected.data,_loc3_.data);
                  }
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
         return AirGardenGameLlkManager.instance.model;
      }
      
      public function show(param1:ModuleFrameInfo = null) : void
      {
         if(StarareaManager.instance.isStarareaGame)
         {
            LayerManager.Instance.addToLayer(this,3,true,true,1);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,true,2);
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         model.info.time = 0;
         model.clear();
         if(isDie == false)
         {
            AirGardenGameLlkManager.llkOp(5);
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

