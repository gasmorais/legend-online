package luckyexchange
{
   import bag.events.BagEvent;
   import com.greensock.TweenMax;
   import com.greensock.easing.Quart;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import com.road.yishi.proto.active.LuckExchangeTempMsg;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flash.utils.clearInterval;
   import flash.utils.getTimer;
   import flash.utils.setInterval;
   import manager.LanguageMgr;
   import ui.maintoolbar.MainToolBar;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.manager.GoodsManager;
   import yishi.manager.LuckyExchangeManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.scene.SceneManager;
   import yishi.utils.DateFormatter;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class LuckyExchangeRightView extends Component
   {
      
      private var _rightViewNote:Bitmap;
      
      private var _inputBg:Bitmap;
      
      private var _data:LuckExchangeTempMsg;
      
      private var _currentLuckValue:int;
      
      private var _num:int;
      
      private var _count:int = 1;
      
      private var _materialTxt:FilterFrameText;
      
      private var _progressText:FilterFrameText;
      
      private var _exchangeText:FilterFrameText;
      
      private var _exchangeNoteTxt:FilterFrameText;
      
      private var _materialNoteTxt:FilterFrameText;
      
      private var _progressMc:MovieClip;
      
      private var _iconMaterial:BaseItemView;
      
      private var _scrollPanel1:ScrollPanel;
      
      private var _totalVBox1:VBox;
      
      private var _scrollPanel2:ScrollPanel;
      
      private var _totalVBox2:VBox;
      
      private var _exchangeBtn:IconButton;
      
      private var _remainTimeText:FilterFrameText;
      
      private var _barEffect:MovieImage;
      
      private var _btnEffect:MovieImage;
      
      private var _timer:Timer;
      
      private var _clickTime:int = 0;
      
      private var _newGoodsInfo:GoodsInfo;
      
      private var _timeId:int;
      
      private var _goodsList:Array = [];
      
      private var _newGoodsCount:int;
      
      private var _isPopGoods:Boolean;
      
      private var showEffect:Boolean;
      
      private var callBack:Function;
      
      private var _effectIcons:Dictionary = new Dictionary();
      
      public function LuckyExchangeRightView()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _rightViewNote = ComponentFactory.Instance.creatBitmap("asset.luckyexchange.rightViewNote");
         _inputBg = ComponentFactory.Instance.creatBitmap("asset.luckyexchange.rightViewInputBg");
         _progressMc = ComponentFactory.Instance.creatCustomObject("luckyexchange.ProgressMc");
         _progressText = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.progressText");
         _iconMaterial = ComponentFactory.Instance.creatCustomObject("luckyexchange.iconMaterialView");
         _materialTxt = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.materialTxt");
         _exchangeText = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.exchangeTxt");
         _exchangeBtn = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.exchangeBtn");
         _exchangeNoteTxt = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.exchangeNoteTxt");
         _materialNoteTxt = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.materialNoteTxt");
         _remainTimeText = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.remainTimeText");
         _scrollPanel1 = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.ScrollPanel1");
         _totalVBox1 = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.totalVBox1");
         _scrollPanel2 = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.ScrollPanel2");
         _totalVBox2 = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.totalVBox2");
         _barEffect = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.barEffect");
         _btnEffect = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.btnEffect");
         addChild(_rightViewNote);
         addChild(_inputBg);
         addChild(_exchangeNoteTxt);
         addChild(_materialNoteTxt);
         addChild(_iconMaterial);
         addChild(_materialTxt);
         addChild(_exchangeText);
         addChild(_progressMc);
         addChild(_exchangeBtn);
         addChild(_remainTimeText);
         addChild(_scrollPanel1);
         addChild(_scrollPanel2);
         addChild(_barEffect);
         addChild(_btnEffect);
         addChild(_progressText);
         _scrollPanel1.setView(_totalVBox1);
         _scrollPanel2.setView(_totalVBox2);
         _exchangeText.text = String(_count);
         _barEffect.mouseEnabled = _barEffect.mouseChildren = false;
         _btnEffect.mouseEnabled = _btnEffect.mouseChildren = false;
         _exchangeNoteTxt.text = LanguageMgr.GetTranslation("luckyexchange.LuckyExchangeRightView.exchangeNoteTxt");
         _materialNoteTxt.text = LanguageMgr.GetTranslation("luckyexchange.LuckyExchangeRightView.materialNoteTxt");
      }
      
      public function set data(param1:LuckExchangeTempMsg) : void
      {
         var _loc4_:LuckyexchangeBagItem = null;
         var _loc3_:Boolean = false;
         _data = param1;
         _currentLuckValue = LuckyExchangeManager.instance.getLuckyValueById(param1.id);
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.consumeItemId;
         _iconMaterial.data = _loc2_;
         ObjectUtils.disposeAllChildren(_totalVBox1);
         ObjectUtils.disposeAllChildren(_totalVBox2);
         if(LuckyExchangeManager.instance.getGoodsByRare(_data).length > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyexchangeBagItem",[0]);
            _loc4_.data = LuckyExchangeManager.instance.getGoodsByRare(_data);
            _loc4_.multi = _loc3_;
            _totalVBox1.addChild(_loc4_);
         }
         if(LuckyExchangeManager.instance.getGoodsByDropType(_data,1).length > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyexchangeBagItem",[1]);
            _loc4_.data = LuckyExchangeManager.instance.getGoodsByDropType(_data,1);
            _loc4_.multi = _loc3_;
            _totalVBox2.addChild(_loc4_);
            _loc3_ = true;
         }
         if(LuckyExchangeManager.instance.getGoodsByDropType(_data,2).length > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyexchangeBagItem",[2]);
            _loc4_.data = LuckyExchangeManager.instance.getGoodsByDropType(_data,2);
            _loc4_.multi = _loc3_;
            _totalVBox2.addChild(_loc4_);
            _loc3_ = true;
         }
         if(LuckyExchangeManager.instance.getGoodsByDropType(_data,3).length > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyexchangeBagItem",[3]);
            _loc4_.data = LuckyExchangeManager.instance.getGoodsByDropType(_data,3);
            _loc4_.multi = _loc3_;
            _totalVBox2.addChild(_loc4_);
            _loc3_ = true;
         }
         if(LuckyExchangeManager.instance.getGoodsByDropType(_data,4).length > 0)
         {
            _loc4_ = ComponentFactory.Instance.creatCustomObject("luckyexchange.LuckyexchangeBagItem",[4]);
            _loc4_.data = LuckyExchangeManager.instance.getGoodsByDropType(_data,4);
            _loc4_.multi = _loc3_;
            _totalVBox2.addChild(_loc4_);
            _loc3_ = true;
         }
         _totalVBox1.refreshChildPos();
         _totalVBox2.refreshChildPos();
         _scrollPanel1.invalidateViewport();
         _scrollPanel2.invalidateViewport();
         __bagItemDeleteHandler(null);
         __refreshHandler(null);
         __onNumTxtChange(null);
         setRemainTime();
      }
      
      private function initEvent() : void
      {
         _exchangeBtn.addEventListener("click",__exchangeClickHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.addEventListener("NEW_GOODS",__newGoodsHandler);
         NotificationManager.instance.addEventListener("LUCKY_INFO_CHANGE",__refreshHandler);
         _exchangeText.addEventListener("change",__onNumTxtChange);
         _timer = new Timer(1000);
         _timer.addEventListener("timer",__timerHandler);
         _timer.start();
      }
      
      private function removeEvent() : void
      {
         _exchangeBtn.removeEventListener("click",__exchangeClickHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         GoodsManager.instance.removeEventListener("NEW_GOODS",__newGoodsHandler);
         NotificationManager.instance.removeEventListener("LUCKY_INFO_CHANGE",__refreshHandler);
         _exchangeText.removeEventListener("change",__onNumTxtChange);
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",__timerHandler);
         }
      }
      
      private function __exchangeClickHandler(param1:MouseEvent) : void
      {
         if(getTimer() - _clickTime < 500)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("activity.view.ActivityItem.command01"));
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         LuckyExchangeManager.instance.OperateLuckyExchange(_data.id,int(_exchangeText.text));
      }
      
      private function __refreshHandler(param1:Event) : void
      {
         _currentLuckValue = LuckyExchangeManager.instance.getLuckyValueById(_data.id);
         var _loc2_:int = _currentLuckValue / _data.luckValue * 200;
         _progressText.text = _currentLuckValue + "/" + _data.luckValue;
         _progressMc.gotoAndStop(_loc2_);
         _barEffect.visible = false;
         _btnEffect.visible = false;
         if(_loc2_ >= 200)
         {
            _barEffect.visible = true;
            _btnEffect.visible = true;
         }
      }
      
      private function __onNumTxtChange(param1:Event) : void
      {
         _count = int(_exchangeText.text);
         if(_num > 0)
         {
            if(_count > _num)
            {
               _count = _num;
            }
            if(_count > _data.luckValue - _currentLuckValue)
            {
               if(_currentLuckValue == _data.luckValue)
               {
                  _count = 1;
               }
               else
               {
                  _count = _data.luckValue - _currentLuckValue;
               }
            }
         }
         else
         {
            _count = 1;
         }
         _exchangeText.text = String(_count);
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         _num = GoodsManager.instance.getBagCountByTempId(1,_data.consumeItemId);
         _materialTxt.text = LanguageMgr.GetTranslation("luckyexchange.LuckyExchangeRightView.materialTxt",_num);
         _exchangeText.text = "1";
      }
      
      public function setRemainTime() : void
      {
         var _loc1_:Date = DateFormatter.parse(_data.startTime,"YYYY-MM-DD hh:mm:ss");
         var _loc3_:Date = DateFormatter.parse(_data.endTime,"YYYY-MM-DD hh:mm:ss");
         var _loc2_:Number = _loc3_.time / 1000 - playerModel.sysCurTimeBySecond;
         if(_loc2_ >= 60)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullTimeString(_loc2_));
         }
         else if(_loc2_ > 0)
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("funny.FunnyRightView.active.remainTime",DateFormatter.getFullDateString(_loc2_));
         }
         else
         {
            _remainTimeText.text = LanguageMgr.GetTranslation("feedback.FeedBackItem.outDate");
         }
         if(_loc1_.time > playerModel.nowDate)
         {
            _remainTimeText.visible = false;
         }
         else
         {
            _remainTimeText.visible = true;
         }
      }
      
      private function __newGoodsHandler(param1:BagEvent) : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            return;
         }
         if(_goodsList.length > 0)
         {
            _goodsList = _goodsList.concat(param1.list);
         }
         else
         {
            _goodsList = param1.list;
            _timeId = setInterval(popGoods,500);
         }
      }
      
      private function popGoods() : void
      {
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            clearInterval(_timeId);
            _goodsList = [];
            return;
         }
         _newGoodsInfo = _goodsList.pop();
         _newGoodsCount += 1;
         if(_newGoodsInfo && _newGoodsInfo.bagType != 22)
         {
            playNewGoodsEffect(_newGoodsInfo);
         }
         if(_goodsList.length == 0)
         {
            clearInterval(_timeId);
            _goodsList = [];
            _newGoodsCount = 0;
         }
         if(_newGoodsCount >= 3)
         {
            clearInterval(_timeId);
            _goodsList = [];
            _newGoodsCount = 0;
         }
      }
      
      public function playNewGoodsEffect(param1:GoodsInfo, param2:Function = null) : void
      {
         var _loc4_:int = 0;
         callBack = param2;
         var _loc3_:BaseIconView = ComponentFactory.Instance.creatCustomObject("core.BaseIcon",[iconComplete]);
         if(_loc3_.isDie)
         {
            return;
         }
         if(!_data)
         {
            return;
         }
         var _loc5_:Array = LuckyExchangeManager.instance.getGoodsByRare(_data);
         _loc4_ = 0;
         while(_loc4_ < _loc5_.length)
         {
            if(_loc5_[_loc4_].itemId == param1.templateId)
            {
               _effectIcons[_loc3_] = true;
            }
            _loc4_++;
         }
         _loc3_.icon = IconFactory.getGoodsIconByTID(param1.templateId);
      }
      
      private function iconComplete(param1:BaseIconView = null) : void
      {
         var _loc4_:MovieImage = null;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(param1)
            {
               param1.dispose();
            }
            delete _effectIcons[param1];
            param1 = null;
            return;
         }
         var _loc2_:Component = new Component();
         if(_effectIcons[param1])
         {
            delete _effectIcons[param1];
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("luckyexchange.rewardEffect");
            _loc2_.addChild(_loc4_);
            _loc4_.x = 30;
            _loc4_.y = 30;
         }
         _loc2_.addChild(param1);
         var _loc3_:MovieClip = ComponentFactory.Instance.creatCustomObject("core.GetGoodsEffect");
         _loc3_.gotoAndStop(1);
         _loc3_["contain"].addChild(_loc2_);
         var _loc5_:Point = param1.parent.localToGlobal(new Point(param1.x,param1.y));
         _loc3_.x = StageReferance.stageWidth / 2;
         _loc3_.y = StageReferance.stageHeight / 2;
         _loc3_.gotoAndPlay(1);
         StageReferance.stage.addChild(_loc3_);
         _loc3_.addEventListener("complete",__complete);
      }
      
      private function __complete(param1:Event) : void
      {
         (param1.currentTarget as MovieClip).removeEventListener("complete",__complete);
         var _loc4_:Component = param1.currentTarget["contain"].getChildAt(0) as Component;
         if(SceneManager.instance.currentType == "BATTLE_SCENE")
         {
            if(_loc4_)
            {
               _loc4_.dispose();
            }
            _loc4_ = null;
            return;
         }
         var _loc5_:Point = _loc4_.parent.localToGlobal(new Point(_loc4_.x,_loc4_.y));
         _loc4_.x = _loc5_.x;
         _loc4_.y = _loc5_.y;
         _loc4_.mouseChildren = _loc4_.mouseEnabled = false;
         StageReferance.stage.addChild(_loc4_);
         ObjectUtils.disposeObject(param1.currentTarget);
         var _loc2_:DisplayObject = MainToolBar.instance.getButtnByType(2) as DisplayObject;
         var _loc3_:Point = _loc2_.parent.localToGlobal(new Point(_loc2_.getBounds(_loc2_.parent).x,_loc2_.getBounds(_loc2_.parent).y));
         TweenMax.to(_loc4_,2,{
            "bezierThrough":[{
               "x":_loc5_.x + 200,
               "y":_loc5_.y
            },{
               "x":_loc3_.x,
               "y":_loc3_.y
            }],
            "scaleX":0.6,
            "scaleY":0.6,
            "orientToBezier":false,
            "ease":Quart.easeOut,
            "onComplete":_moveComplete,
            "onCompleteParams":[_loc4_]
         });
      }
      
      private function _moveComplete(param1:Component) : void
      {
         TweenMax.to(param1,0.5,{
            "alpha":0,
            "onComplete":disapearComplete,
            "onCompleteParams":[param1]
         });
      }
      
      private function disapearComplete(param1:Component) : void
      {
         if(callBack != null)
         {
            callBack();
         }
         callBack = null;
         ObjectUtils.disposeObject(param1);
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      private function __timerHandler(param1:TimerEvent) : void
      {
         setRemainTime();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearInterval(_timeId);
         _effectIcons = null;
         ObjectUtils.disposeObject(_rightViewNote);
         _rightViewNote = null;
         ObjectUtils.disposeObject(_inputBg);
         _inputBg = null;
         ObjectUtils.disposeObject(_materialTxt);
         _materialTxt = null;
         ObjectUtils.disposeObject(_progressText);
         _progressText = null;
         ObjectUtils.disposeObject(_exchangeText);
         _exchangeText = null;
         ObjectUtils.disposeObject(_exchangeNoteTxt);
         _exchangeNoteTxt = null;
         ObjectUtils.disposeObject(_materialNoteTxt);
         _materialNoteTxt = null;
         ObjectUtils.disposeViolentMc(_progressMc);
         _progressMc = null;
         ObjectUtils.disposeObject(_iconMaterial);
         _iconMaterial = null;
         ObjectUtils.disposeObject(_scrollPanel1);
         _scrollPanel1 = null;
         ObjectUtils.disposeObject(_totalVBox1);
         _totalVBox1 = null;
         ObjectUtils.disposeObject(_scrollPanel2);
         _scrollPanel2 = null;
         ObjectUtils.disposeObject(_totalVBox2);
         _totalVBox2 = null;
         ObjectUtils.disposeObject(_exchangeBtn);
         _exchangeBtn = null;
         ObjectUtils.disposeObject(_remainTimeText);
         _remainTimeText = null;
         ObjectUtils.disposeObject(_barEffect);
         _barEffect = null;
         ObjectUtils.disposeObject(_btnEffect);
         _btnEffect = null;
         _data = null;
         super.dispose();
      }
   }
}

