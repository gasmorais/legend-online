package consortia.view.minos.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import consortia.view.minos.item.MinosDiffChoseItem;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import managers.MinosManager;
   import mvc.module.minos.MinosModel;
   import mvc.module.minos.MinosNodeInfo;
   import mvc.module.theseus.AttributeUtils;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.MinosNodeTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class MinosCardChoseViewUI extends Sprite
   {
      
      protected var _bg:Bitmap;
      
      protected var _guai3:Bitmap;
      
      protected var _probg:Bitmap;
      
      protected var _namebg:Bitmap;
      
      protected var _probar1:Bitmap;
      
      protected var _cardNameTxt:FilterFrameText;
      
      protected var _nodeFightBtn:IconButton;
      
      protected var _tback:Bitmap;
      
      protected var _pre:Bitmap;
      
      protected var _nodeDiffVbox:VBox;
      
      protected var _nodeDiffHbox:HBox;
      
      protected var _cardpronTxt:FilterFrameText;
      
      private var _itemList:Array = [];
      
      private var _proStyle1:BitmapData;
      
      private var _proStyle2:BitmapData;
      
      private var _guaiStyle1:BitmapData;
      
      private var _guaiStyle2:BitmapData;
      
      private var _guaiStyle3:BitmapData;
      
      private var _proMask:Shape;
      
      private var _rewardItems:Array = [];
      
      private var _data:MinosNodeInfo;
      
      public function MinosCardChoseViewUI()
      {
         super();
         initView();
         initEvent();
      }
      
      protected function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.minos.card.bg");
         _guai3 = ComponentFactory.Instance.creatBitmap("asset.minos.guai3");
         _probg = ComponentFactory.Instance.creatBitmap("asset.minos.card.probg");
         _namebg = ComponentFactory.Instance.creatBitmap("asset.minos.card.namebg");
         _cardNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.cardNameTxt");
         _nodeFightBtn = ComponentFactory.Instance.creatComponentByStylename("ui.minos.nodeFightBtn");
         _tback = ComponentFactory.Instance.creatBitmap("asset.minos.nodeRewadPrebg");
         _pre = ComponentFactory.Instance.creatBitmap("asset.minos.card.pre");
         _nodeDiffVbox = ComponentFactory.Instance.creatCustomObject("ui.minos.nodeDiffVbox");
         _nodeDiffHbox = ComponentFactory.Instance.creatCustomObject("ui.minos.nodeDiffHbox");
         _cardpronTxt = ComponentFactory.Instance.creatComponentByStylename("ui.minos.cardpronTxt");
         _probar1 = ComponentFactory.Instance.creatBitmap("asset.minos.card.probar1");
         _proStyle1 = ComponentFactory.Instance.creatBitmap("asset.minos.card.probar1").bitmapData;
         _proStyle2 = ComponentFactory.Instance.creatBitmap("asset.minos.card.probar2").bitmapData;
         _guaiStyle1 = ComponentFactory.Instance.creatBitmap("asset.minos.guai1").bitmapData;
         _guaiStyle2 = ComponentFactory.Instance.creatBitmap("asset.minos.guai2").bitmapData;
         _guaiStyle3 = ComponentFactory.Instance.creatBitmap("asset.minos.guai3").bitmapData;
         _proMask = new Shape();
         addChild(_bg);
         addChild(_guai3);
         addChild(_probg);
         addChild(_namebg);
         addChild(_probar1);
         addChild(_proMask);
         addChild(_cardNameTxt);
         addChild(_nodeFightBtn);
         addChild(_tback);
         addChild(_pre);
         addChild(_nodeDiffVbox);
         addChild(_nodeDiffHbox);
         addChild(_cardpronTxt);
         initItems();
         _proMask.x = _probar1.x;
         _proMask.y = _probar1.y;
         _probar1.mask = _proMask;
         _nodeFightBtn.enable = false;
      }
      
      public function set data(param1:MinosNodeInfo) : void
      {
         var _loc2_:MinosDiffChoseItem = null;
         var _loc4_:MinosNodeTempInfo = null;
         var _loc3_:MinosNodeTempInfo = null;
         var _loc5_:int = 0;
         _data = param1;
         if(_data)
         {
            this.visible = true;
            _loc4_ = _data.nodeTemp;
            _cardNameTxt.text = _loc4_.NodeName;
            if(_loc4_.NodeType == 5)
            {
               _probar1.bitmapData = _proStyle2;
            }
            else
            {
               _probar1.bitmapData = _proStyle1;
            }
            switch(int(_loc4_.NodeType) - 3)
            {
               case 0:
               case 1:
                  _guai3.bitmapData = _guaiStyle2;
                  _guai3.x = 92;
                  _guai3.y = -10;
                  break;
               case 2:
                  _guai3.bitmapData = _guaiStyle3;
                  _guai3.x = 88;
                  _guai3.y = -10;
                  break;
               default:
                  _guai3.bitmapData = _guaiStyle1;
                  _guai3.x = 97;
                  _guai3.y = -1;
            }
            _loc5_ = 0;
            while(_loc5_ < 4)
            {
               _loc3_ = TempleteManager.instance.minosNodeCate.getDiffTempBy(_loc4_.ForLevel,_loc4_.NodeId,_loc4_.NodeType,_loc5_ + 1);
               _loc2_ = _itemList[_loc5_];
               _loc2_.temp = _loc3_;
               _loc5_++;
            }
            refreshProgress();
         }
      }
      
      private function updateShowReward(param1:MinosNodeTempInfo) : void
      {
         _nodeDiffHbox.beginChanges();
         _nodeDiffHbox.removeAllChild();
         var _loc2_:int = 0;
         if(param1.RewardNum1 > 0)
         {
            showRewardIcon(_loc2_,param1.RewardItem1,param1.RewardNum1);
            _loc2_++;
         }
         if(param1.RewardNum2 > 0)
         {
            showRewardIcon(_loc2_,param1.RewardItem2,param1.RewardNum2);
            _loc2_++;
         }
         if(param1.RewardNum3 > 0)
         {
            showRewardIcon(_loc2_,param1.RewardItem3,param1.RewardNum3);
         }
         _nodeDiffHbox.commitChanges();
      }
      
      private function showRewardIcon(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:BaseItemView = _rewardItems[param1];
         _nodeDiffHbox.addChild(_loc4_);
         var _loc5_:GoodsInfo = _loc4_.data;
         if(_loc5_ == null)
         {
            _loc5_ = new GoodsInfo();
         }
         _loc5_.templateId = param2;
         _loc5_.count = param3;
         _loc4_.data = _loc5_;
      }
      
      private function initEvent() : void
      {
         _nodeFightBtn.addEventListener("click",fightClickHandler);
         NotificationManager.instance.addEventListener("minos_EVENT_CHOOSE_DIFF",minosDiffSelectHandler);
      }
      
      private function removeEvent() : void
      {
         _nodeFightBtn.removeEventListener("click",fightClickHandler);
         NotificationManager.instance.removeEventListener("minos_EVENT_CHOOSE_DIFF",minosDiffSelectHandler);
      }
      
      private function minosDiffSelectHandler(param1:NotificationEvent) : void
      {
         var _loc2_:int = int(param1.data);
         var _loc3_:MinosDiffChoseItem = _itemList[_loc2_ - 1];
         if(_loc3_)
         {
            _loc3_.isSelect = false;
         }
         refreshProgress();
      }
      
      public function refreshProgress() : void
      {
         var _loc1_:MinosDiffChoseItem = _itemList[model.currDiff - 1];
         if(_data == null || !_loc1_)
         {
            return;
         }
         _loc1_.isSelect = true;
         var _loc4_:Array = ["#0099CC","#9900CC","#FF9900","#FF0000"];
         var _loc2_:MinosNodeTempInfo = _loc1_.temp;
         updateShowReward(_loc2_);
         var _loc3_:String = "+" + _loc2_.GardenValue;
         _cardpronTxt.htmlText = _data.progress + AttributeUtils.getColorStr(_loc3_,_loc4_[_loc2_.NodeGrade - 1]) + "/" + _loc2_.NodeValueMax;
         var _loc5_:int = _data.progress / _loc2_.NodeValueMax * _probar1.width;
         _proMask.graphics.clear();
         _proMask.graphics.beginFill(16711680);
         _proMask.graphics.drawRect(0,0,_loc5_,_probar1.height);
         _proMask.graphics.endFill();
         _nodeFightBtn.enable = _data.progress < _loc2_.NodeValueMax;
      }
      
      private function get model() : MinosModel
      {
         return MinosManager.ins.model;
      }
      
      private function fightClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:int = int(MinosManager.ins.model.currDiff);
         MinosManager.ins.doSomething(5,_data.nodeTemp.ForLevel,_data.x,_data.y,_loc2_);
      }
      
      private function initItems() : void
      {
         var _loc1_:MinosDiffChoseItem = null;
         var _loc2_:BaseItemView = null;
         _nodeDiffVbox.beginChanges();
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = new MinosDiffChoseItem();
            _nodeDiffVbox.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc3_++;
         }
         _nodeDiffVbox.commitChanges();
         _loc3_ = 0;
         while(_loc3_ < 3)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("feedBackFrame.BaseItemView");
            _rewardItems.push(_loc2_);
            _loc3_++;
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         LogicUtils.disposeDisplayCollection(_rewardItems);
         _rewardItems = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_guai3);
         _guai3 = null;
         ObjectUtils.disposeObject(_probg);
         _probg = null;
         ObjectUtils.disposeObject(_namebg);
         _namebg = null;
         ObjectUtils.disposeObject(_probar1);
         _probar1 = null;
         ObjectUtils.disposeObject(_cardNameTxt);
         _cardNameTxt = null;
         ObjectUtils.disposeObject(_nodeFightBtn);
         _nodeFightBtn = null;
         ObjectUtils.disposeObject(_tback);
         _tback = null;
         ObjectUtils.disposeObject(_pre);
         _pre = null;
         ObjectUtils.disposeObject(_nodeDiffVbox);
         _nodeDiffVbox = null;
         ObjectUtils.disposeObject(_nodeDiffHbox);
         _nodeDiffHbox = null;
         ObjectUtils.disposeObject(_cardpronTxt);
         _cardpronTxt = null;
         ObjectUtils.disposeObject(_proStyle1);
         _proStyle1 = null;
         ObjectUtils.disposeObject(_proStyle2);
         _proStyle2 = null;
         ObjectUtils.disposeObject(_guaiStyle1);
         _guaiStyle1 = null;
         ObjectUtils.disposeObject(_guaiStyle2);
         _guaiStyle2 = null;
         ObjectUtils.disposeObject(_guaiStyle3);
         _guaiStyle3 = null;
         if(parent)
         {
            parent.removeChild(this);
         }
         _data = null;
      }
   }
}

