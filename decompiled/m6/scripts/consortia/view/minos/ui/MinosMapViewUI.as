package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.item.MinosNodeItem;
   import flash.display.Bitmap;
   import flash.display.InteractiveObject;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.MinosManager;
   import mvc.module.minos.MinosLevelInfo;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosNodeInfo;
   import mvc.module.minos.MinosPlayerInfo;
   import mvc.module.minos.MinosPos;
   import utils.LogicUtils;
   import yishi.datas.templates.ConfigInfosTempInfo;
   import yishi.datas.templates.MinosLevelTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.CursorManagerII;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.TweenDrag;
   import yishi.view.tips.MessageTipManager;
   
   public class MinosMapViewUI extends Sprite
   {
      
      protected var _mapbg:MovieClip;
      
      protected var _mapCardTxt:FilterFrameText;
      
      protected var _mapFightTxt:FilterFrameText;
      
      protected var _bigProBar:Bitmap;
      
      protected var _mapBuyAddBtn:BaseButton;
      
      protected var _lvmapProTxt:FilterFrameText;
      
      private var _samllView:MinosSamllMapView;
      
      private var _chooseNodeDiffView:MinosCardChoseViewUI;
      
      private var _lvProMask:Shape;
      
      private var _nodeContainer:Sprite;
      
      private var _nodeMask:Shape;
      
      private var _nodeDic:Dictionary = new Dictionary();
      
      private var _dragObj:TweenDrag;
      
      private var _isDraging:Boolean;
      
      private var _mapWidth:int = 2250;
      
      private var _mapHeight:int = 1497;
      
      private var _temp:MinosLevelTempInfo;
      
      private var _rewardNodeList:Array = [];
      
      private var _rewardHbox:HBox;
      
      private var _baseChallenge:int;
      
      private var _buyPrice:int;
      
      private var _buyMax:int;
      
      private const MAP_WIDTH:int = 750;
      
      private const MAP_HEIGHT:int = 475;
      
      private const ITEM_SIZE:int = 91;
      
      private const MAP_X:int = 5;
      
      private const MAP_Y:int = 35;
      
      public function MinosMapViewUI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         var _loc2_:Array = null;
         var _loc1_:ConfigInfosTempInfo = TempleteManager.instance.getConfigInfoByConfigName("Minos_ChallengePrice");
         if(_loc1_)
         {
            _loc2_ = _loc1_.ConfigValue.split(",");
            _buyMax = int(_loc2_[0]);
            _buyPrice = int(_loc2_[1]);
         }
         _baseChallenge = TempleteManager.instance.getConfigValue("Minos_ChallengeCount");
         _mapbg = ComponentFactory.Instance.creatCustomObject("ui.minos.mapbg");
         _mapCardTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.mapCardTxt");
         _mapFightTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.mapFightTxt");
         _bigProBar = ComponentFactory.Instance.creatBitmap("asset.minos.map.bigProBar");
         _mapBuyAddBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.mapBuyAddBtn");
         _lvmapProTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.lvmapProTxt");
         _samllView = ComponentFactory.Instance.creatCustomObject("ui.minos.MinosSamllMapView");
         _chooseNodeDiffView = ComponentFactory.Instance.creatCustomObject("ui.minos.MinosCardChoseViewUI");
         _rewardHbox = ComponentFactory.Instance.creatCustomObject("ui.minos.nodeReward.Hbox");
         _nodeContainer = new Sprite();
         _nodeMask = new Shape();
         _lvProMask = new Shape();
         addChild(_mapbg);
         addChild(_nodeContainer);
         addChild(_nodeMask);
         addChild(_mapCardTxt);
         addChild(_mapFightTxt);
         addChild(_bigProBar);
         addChild(_mapBuyAddBtn);
         addChild(_lvProMask);
         addChild(_lvmapProTxt);
         addChild(_samllView);
         addChild(_chooseNodeDiffView);
         addChild(_rewardHbox);
         initItems();
         _chooseNodeDiffView.visible = false;
         _nodeContainer.x = 5;
         _nodeContainer.y = 35;
         _nodeMask.x = _nodeContainer.x;
         _nodeMask.y = _nodeContainer.y;
         _nodeMask.graphics.beginFill(16711680);
         _nodeMask.graphics.drawRect(0,0,750,475);
         _nodeMask.graphics.endFill();
         _nodeContainer.mask = _nodeMask;
         _lvProMask.x = _bigProBar.x;
         _lvProMask.y = _bigProBar.y;
         _bigProBar.mask = _lvProMask;
         _dragObj = new TweenDrag(_nodeContainer,_nodeContainer as InteractiveObject);
         _dragObj.onDragStart = dragStartCallBack;
         _dragObj.onDraging = dragingCallBack;
         _dragObj.onDragDrop = dropCallBack;
         _dragObj.upNoMove = true;
         _lvmapProTxt.text = LanguageMgr.GetTranslation("minos.cardPro",0);
      }
      
      private function initItems() : void
      {
         var _loc1_:MinosNodeItem = null;
         var _loc5_:String = null;
         var _loc4_:int = 0;
         var _loc3_:MinosRwardNodeUI = null;
         var _loc2_:int = 0;
         _mapWidth = 91 * 16 - 5;
         _mapHeight = 91 * 10 - 35;
         _loc2_ = 0;
         while(_loc2_ < 10)
         {
            _loc4_ = 0;
            while(_loc4_ < 16)
            {
               _loc5_ = _loc4_ + "_" + _loc2_;
               _loc1_ = new MinosNodeItem();
               _nodeDic[_loc5_] = _loc1_;
               _nodeContainer.addChild(_loc1_);
               _loc1_.x = _loc4_ * 91;
               _loc1_.y = _loc2_ * 91;
               _loc1_.data = null;
               _loc4_++;
            }
            _loc2_++;
         }
         _rewardHbox.beginChanges();
         _loc2_ = 0;
         while(_loc2_ < 5)
         {
            _loc3_ = new MinosRwardNodeUI(_loc2_ + 1);
            _rewardNodeList[_loc2_] = _loc3_;
            _rewardHbox.addChild(_loc3_);
            _loc2_++;
         }
         _rewardHbox.commitChanges();
      }
      
      public function set temp(param1:MinosLevelTempInfo) : void
      {
         _temp = param1;
         if(_temp)
         {
            _mapCardTxt.text = _temp.LevelName;
            updateLvPross();
            updateReawrdNodeState();
         }
      }
      
      private function unSelectNode(param1:MinosNodeInfo) : void
      {
         var _loc3_:String = param1.x + "_" + param1.y;
         var _loc2_:MinosNodeItem = _nodeDic[_loc3_];
         _loc2_.isChoose = false;
      }
      
      private function updateLvPross() : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc1_:MinosLevelInfo = model.mapLvInfoDic[_temp.Id];
         if(_loc1_)
         {
            _loc2_ = _bigProBar.width * _loc1_.progress / _loc1_.progressMax;
            _lvProMask.graphics.clear();
            _lvProMask.graphics.beginFill(16711680);
            _lvProMask.graphics.drawRect(0,0,_loc2_,_bigProBar.height);
            _lvProMask.graphics.endFill();
            _loc3_ = _loc1_.progress / _loc1_.progressMax * 100;
            _lvmapProTxt.text = LanguageMgr.GetTranslation("minos.cardPro",_loc3_);
         }
      }
      
      private function dragStartCallBack() : void
      {
         CursorManagerII.instance.showCursorByType("DRAG_CURSOR");
      }
      
      private function dragingCallBack() : void
      {
         mapMoveCheck(_nodeContainer.x,_nodeContainer.y);
      }
      
      private function dropCallBack() : void
      {
         if(CursorManagerII.instance.currentState == "DRAG_CURSOR")
         {
            CursorManagerII.instance.resetCursor();
         }
      }
      
      private function mapMoveCheck(param1:int, param2:int) : void
      {
         var _loc3_:int = 750 - _mapWidth;
         var _loc4_:int = 475 - _mapHeight;
         if(param1 >= 5)
         {
            param1 = 5;
         }
         else if(param1 <= _loc3_)
         {
            param1 = _loc3_;
         }
         if(param2 >= 35)
         {
            param2 = 35;
         }
         else if(param2 <= _loc4_)
         {
            param2 = _loc4_;
         }
         _nodeContainer.x = param1;
         _nodeContainer.y = param2;
         model.mapx = param1;
         model.mapy = param2;
         _samllView.updateRect(-param1,-param2);
      }
      
      private function updateView(param1:Array, param2:String) : void
      {
         var _loc3_:MinosNodeItem = null;
         var _loc10_:String = null;
         var _loc5_:MinosPos = null;
         var _loc4_:MinosNodeInfo = null;
         var _loc6_:Array = null;
         var _loc7_:int = 0;
         var _loc9_:MinosRwardNodeUI = null;
         _samllView.updateView(param1);
         var _loc11_:Array = [];
         for each(var _loc12_:MinosNodeInfo in param1)
         {
            _loc10_ = _loc12_.x + "_" + _loc12_.y;
            _loc3_ = _nodeDic[_loc10_];
            if(_loc3_ == null)
            {
               _loc3_ = new MinosNodeItem();
               _nodeDic[_loc10_] = _loc3_;
               _nodeContainer.addChild(_loc3_);
               _loc3_.x = _loc12_.x * 91;
               _loc3_.y = _loc12_.y * 91;
            }
            if(param2 == "init")
            {
               if(_loc12_.nodeTemp.NodeType == 4)
               {
                  _loc11_.push(_loc12_);
               }
               else if(_loc12_.nodeTemp.NodeType == 5)
               {
                  _loc4_ = _loc12_;
               }
            }
            _loc3_.data = _loc12_;
            if(model.selectedNode == _loc12_)
            {
               _loc3_.isChoose = true;
               _samllView.chooseNode(_loc12_,true);
               _chooseNodeDiffView.data = _loc12_;
            }
            if(_loc12_.nodeTemp.size == 4)
            {
               _loc5_ = model.getPos(_loc12_.x,_loc12_.y);
               _loc6_ = _loc5_.getDownRightBox4();
               if(_loc6_)
               {
                  _loc7_ = 1;
                  while(_loc7_ < _loc6_.length)
                  {
                     _loc5_ = _loc6_[_loc7_];
                     _loc10_ = _loc5_.x + "_" + _loc5_.y;
                     _loc3_ = _nodeDic[_loc10_];
                     if(_loc3_)
                     {
                        delete _nodeDic[_loc10_];
                        ObjectUtils.disposeObject(_loc3_);
                     }
                     _loc7_++;
                  }
               }
            }
         }
         var _loc8_:int = 0;
         if(param2 == "init")
         {
            _loc11_.sortOn(["y","x"],[16,16]);
            _loc11_.push(_loc4_);
            _loc8_ = 0;
            while(_loc8_ < _rewardNodeList.length)
            {
               _loc9_ = _rewardNodeList[_loc8_];
               _loc9_.data = _loc11_[_loc8_];
               _loc8_++;
            }
            mapMoveCheck(model.mapx,model.mapy);
         }
         else if(param2 == "update")
         {
            _loc8_ = 0;
            while(_loc8_ < _rewardNodeList.length)
            {
               _loc9_ = _rewardNodeList[_loc8_];
               _loc9_.refreshView();
               _loc8_++;
            }
         }
      }
      
      private function updateReawrdNodeState() : void
      {
         var _loc4_:int = 0;
         var _loc7_:MinosRwardNodeUI = null;
         if(!_temp)
         {
            return;
         }
         var _loc1_:MinosPlayerInfo = model.playInfo;
         var _loc3_:int = _baseChallenge + _loc1_.buyCount - _loc1_.challengeCount;
         if(_loc3_ < 0)
         {
            _loc3_ = 0;
         }
         _mapFightTxt.text = LanguageMgr.GetTranslation("warSoulTowerFrame.challengeNumTxt.text",_loc3_);
         var _loc6_:int = int(_temp.Id);
         var _loc2_:Array = _loc1_.levelRewardGets[_loc6_];
         for each(var _loc5_:String in _loc2_)
         {
            _loc4_ = int(_loc5_);
            _loc7_ = _rewardNodeList[_loc4_ - 1];
            _loc7_.hasRewardState();
         }
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      private function initEvent() : void
      {
         _mapBuyAddBtn.addEventListener("click",addClickHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_NODE_UPDATE",nodeUpdateHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_LV_UPDATE",lvUpdateHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_CHOOSE_NODE",chooseNodeHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_PALYER_UPDATE",playInfoHandler);
      }
      
      private function removeEvent() : void
      {
         _mapBuyAddBtn.removeEventListener("click",addClickHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_NODE_UPDATE",nodeUpdateHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_LV_UPDATE",lvUpdateHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_CHOOSE_NODE",chooseNodeHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_PALYER_UPDATE",playInfoHandler);
      }
      
      private function playInfoHandler(param1:NotificationEvent) : void
      {
         updateReawrdNodeState();
      }
      
      private function lvUpdateHandler(param1:NotificationEvent) : void
      {
         updateLvPross();
      }
      
      private function chooseNodeHandler(param1:NotificationEvent) : void
      {
         var _loc3_:Array = param1.data as Array;
         var _loc4_:MinosNodeInfo = _loc3_[1];
         _chooseNodeDiffView.data = _loc4_;
         _samllView.chooseNode(_loc4_,true);
         var _loc2_:MinosNodeInfo = _loc3_[0];
         if(_loc2_)
         {
            unSelectNode(_loc2_);
            _samllView.chooseNode(_loc2_,false);
         }
      }
      
      private function nodeUpdateHandler(param1:NotificationEvent) : void
      {
         var _loc5_:Array = param1.data as Array;
         var _loc4_:int = int(_loc5_[0]);
         var _loc3_:Array = _loc5_[1];
         var _loc2_:String = _loc5_[2];
         if(_loc4_ == _temp.Id)
         {
            updateView(_loc5_[1],_loc2_);
            _chooseNodeDiffView.refreshProgress();
         }
      }
      
      private function addClickHandler(param1:MouseEvent) : void
      {
         param1.stopPropagation();
         if(model.playInfo.buyCount >= _buyMax)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("minos.nobuy"));
            return;
         }
         var _loc2_:String = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         var _loc3_:String = LanguageMgr.GetTranslation("minos.buy.time",_buyPrice);
         SharedManagerHelper.ins.needAlert("view.minos.buyTime",buyConfirm,_loc2_,_loc3_);
      }
      
      private function buyConfirm() : void
      {
         if(PlayerManager.instance.currentPlayerModel.playerInfo.point < _buyPrice)
         {
            RechargeAlertMannager.show();
            return;
         }
         MinosManager.ins.doSomething(8);
      }
      
      public function dispose() : void
      {
         removeEvent();
         for each(var _loc1_:MinosNodeItem in _nodeDic)
         {
            ObjectUtils.disposeObject(_loc1_);
         }
         LogicUtils.disposeDisplayCollection(_rewardNodeList);
         _rewardNodeList = null;
         ObjectUtils.disposeObject(_rewardHbox);
         _rewardHbox = null;
         ObjectUtils.disposeObject(_dragObj);
         _dragObj = null;
         ObjectUtils.disposeViolentMc(_mapbg);
         _mapbg = null;
         ObjectUtils.disposeObject(_mapCardTxt);
         _mapCardTxt = null;
         ObjectUtils.disposeObject(_mapFightTxt);
         _mapFightTxt = null;
         ObjectUtils.disposeObject(_bigProBar);
         _bigProBar = null;
         ObjectUtils.disposeObject(_mapBuyAddBtn);
         _mapBuyAddBtn = null;
         ObjectUtils.disposeObject(_lvmapProTxt);
         _lvmapProTxt = null;
         ObjectUtils.disposeObject(_samllView);
         _samllView = null;
         ObjectUtils.disposeObject(_chooseNodeDiffView);
         _chooseNodeDiffView = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _temp = null;
         _nodeDic = null;
      }
   }
}

