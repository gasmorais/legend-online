package monopoly.llk
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.display.DisplayObjectContainer;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import managers.MonopolyLlkManager;
   import managers.MonopolySocketOutManager;
   import monopoly.llk.view.MonopolyLlkGoodsItem;
   import monopoly.llk.view.MonopolyLlkNodeView;
   import mvc.module.llk.LlkDeleteData;
   import mvc.module.llk.LlkModel;
   import mvc.module.stararea.StarareaManager;
   import yishi.datas.ComponentGroupType;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.utils.StringHelper;
   import yishi.view.frame.TodayNotAlertFrame;
   import yishi.view.tips.MessageTipManager;
   import yishi.view.tools.SimpleMovie;
   
   public class MonopolyLlkFrame extends Frame implements IManualSize
   {
      
      private var _bg:DisplayObjectContainer;
      
      private var _listView:Sprite;
      
      private var _nodeList:Vector.<MonopolyLlkNodeView>;
      
      private var _selected:MonopolyLlkNodeView;
      
      private var _goods1:MonopolyLlkGoodsItem;
      
      private var _goods2:MonopolyLlkGoodsItem;
      
      private var _combNumRes:BitmapData;
      
      private var _scoreNumRes:BitmapData;
      
      private var _deleMc:SimpleMovie;
      
      private var _frame:TodayNotAlertFrame;
      
      public function MonopolyLlkFrame()
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
         return new Rectangle(0,0,796,450);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      private function initView() : void
      {
         if(StarareaManager.instance.isStarareaGame)
         {
            titleText = LanguageMgr.GetTranslation("stararea.str6");
         }
         else
         {
            titleText = LanguageMgr.GetTranslation("ui.toptoolbar.TopToolsBar.tipData_llk");
         }
         _bg = ComponentFactory.Instance.creat("asset.llk.monopoly.background");
         _combNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.combNum");
         _scoreNumRes = ComponentFactory.Instance.creatBitmapData("asset.llk.scoreNum");
         _listView = new Sprite();
         _nodeList = new Vector.<MonopolyLlkNodeView>();
         _goods1 = new MonopolyLlkGoodsItem();
         _goods2 = new MonopolyLlkGoodsItem();
         _listView.x = -12;
         _listView.y = -10;
         _goods1.type = 1;
         _goods1.x = 616;
         _goods1.y = 55;
         _goods2.type = 2;
         _goods2.x = 616;
         _goods2.y = 183;
         addToContent(_bg);
         addToContent(_listView);
         addToContent(_goods1);
         addToContent(_goods2);
         if(StarareaManager.instance.isStarareaGame)
         {
            _goods1.visible = _goods2.visible = false;
         }
      }
      
      private function unInitView() : void
      {
         ObjectUtils.disposeAllChildren(_bg);
         _bg = null;
         ObjectUtils.disposeAllChildren(_listView);
         _listView = null;
         ObjectUtils.disposeObject(_goods1);
         _goods1 = null;
         ObjectUtils.disposeObject(_goods2);
         _goods2 = null;
         ObjectUtils.disposeObject(_combNumRes);
         _combNumRes = null;
         ObjectUtils.disposeObject(_scoreNumRes);
         _scoreNumRes = null;
         ObjectUtils.disposeObject(_frame);
         _frame = null;
         ObjectUtils.disposeObject(_deleMc);
         _deleMc = null;
         while(_nodeList && _nodeList.length > 0)
         {
            _nodeList.pop().dispose();
         }
      }
      
      private function initNode() : void
      {
         var _loc1_:MonopolyLlkNodeView = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < LlkModel.ROW * LlkModel.COLUMN)
         {
            _loc1_ = new MonopolyLlkNodeView();
            _loc1_.data = model.list[_loc2_];
            _loc1_.x = _loc2_ % LlkModel.COLUMN * MonopolyLlkNodeView.WIDTH;
            _loc1_.y = Math.floor(_loc2_ / LlkModel.COLUMN) * MonopolyLlkNodeView.HEIGHT;
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
         MsgMan.addObserver(LlkModel.LLK_INFO,this,__infoHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__responseHandler);
         if(_listView)
         {
            _listView.removeEventListener("click",__clickHandler);
         }
         MsgMan.removeObserver(LlkModel.LLK_INFO,this,__infoHandler);
      }
      
      private function requestInfo(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(!StarareaManager.instance.isStarareaGame)
         {
            MonopolyLlkManager.llkOp(12);
         }
         else
         {
            StarareaManager.instance.sendPlayGame(1,2);
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
      }
      
      private function deleteNode(param1:LlkDeleteData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:MovieClip = null;
         if(MonopolyLlkManager.instance.model.checkByPos(param1.node1,param1.node2,true))
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
            _deleMc.x = param1.node2.col * MonopolyLlkNodeView.WIDTH + 10;
            _deleMc.y = param1.node2.row * MonopolyLlkNodeView.HEIGHT - 10;
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
               dispose();
         }
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc3_:MonopolyLlkNodeView = null;
         if(_listView)
         {
            if(_listView.mouseX < MonopolyLlkNodeView.WIDTH || _listView.mouseX >= (LlkModel.COLUMN - 1) * MonopolyLlkNodeView.WIDTH)
            {
               return;
            }
            if(_listView.mouseY < MonopolyLlkNodeView.HEIGHT || _listView.mouseY >= (LlkModel.ROW - 1) * MonopolyLlkNodeView.HEIGHT)
            {
               return;
            }
            _loc4_ = Math.floor((_listView.mouseY - 5) / MonopolyLlkNodeView.HEIGHT);
            _loc2_ = Math.floor((_listView.mouseX - 10) / MonopolyLlkNodeView.WIDTH);
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
                     MonopolyLlkManager.llkDelete(_selected.data,_loc3_.data);
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
         return MonopolyLlkManager.instance.model;
      }
      
      public function show() : void
      {
         closeButton.visible = false;
         if(StarareaManager.instance.isStarareaGame)
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
         else
         {
            LayerManager.Instance.addToLayer(this,3,true,true);
         }
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         model.info.time = 0;
         if(isDie == false)
         {
            MonopolyLlkManager.llkOp(11);
         }
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         unInitView();
         super.dispose();
      }
   }
}

