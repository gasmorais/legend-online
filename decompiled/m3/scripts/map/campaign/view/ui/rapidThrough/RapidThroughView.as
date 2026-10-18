package map.campaign.view.ui.rapidThrough
{
   import com.greensock.TweenLite;
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.RapidInfoEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import managers.GameHallManager;
   import managers.RapidThroughPassManager;
   import map.campaign.CampaignManager;
   import map.campaign.CampaignMapController;
   import map.campaign.data.CampaignArmy;
   import map.campaign.data.CampaignMapModel;
   import map.campaign.view.layer.CampaignMainBuidingLayer;
   import mvc.module.gamehall.GameHallModel;
   import mvc.module.rapidThrough.RapidPassInfo;
   import mvc.module.rapidThrough.RapidThroughModel;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.utils.DateFormatter;
   import yishi.view.community.TimeCountView;
   import yishi.view.community.TimeDownView;
   
   public class RapidThroughView extends Component
   {
      
      private static const MAX_LAYER:int = 9;
      
      public var txtBg:Bitmap;
      
      public var image_Layer:Bitmap;
      
      public var imageLine:Bitmap;
      
      public var lbl_layer:FilterFrameText;
      
      public var lbl_describle:FilterFrameText;
      
      public var image_line2:Bitmap;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _rapidBox:VBox;
      
      private var _passMove:MovieClip;
      
      private var _startButton:IconButton;
      
      private var _passTimeBg:MutipleImage;
      
      private var _timeDownView:TimeDownView;
      
      private var _timeOutBg:MutipleImage;
      
      private var _timeOutView:TimeCountView;
      
      private var _timeOutComponent:Component;
      
      private var _items:Array = [];
      
      private var _showBtn:IconButton;
      
      private var _hideBtn:IconButton;
      
      private var _container:Component;
      
      private var _isInit:Boolean = false;
      
      private var _timeInterval:int = 0;
      
      private var _campaignMainBuilderLayer:CampaignMainBuidingLayer;
      
      private var _effect:MovieClip;
      
      public function RapidThroughView()
      {
         super();
         mouseEnabled = false;
         mouseChildren = true;
         initView();
      }
      
      public function resize() : void
      {
         var _loc1_:Number = StageReferance.gameStageWidth >> 1;
         if(_passMove)
         {
            _passMove.x = _loc1_ - this.x;
            _passMove.y = 0;
         }
         _timeOutComponent.x = _loc1_ - this.x - _timeOutComponent.width;
         _timeOutComponent.y = 600;
      }
      
      override public function set x(param1:Number) : void
      {
         super.x = param1;
         resize();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         removeEffect();
         if(txtBg)
         {
            ObjectUtils.disposeObject(txtBg);
         }
         txtBg = null;
         if(image_Layer)
         {
            ObjectUtils.disposeObject(image_Layer);
         }
         image_Layer = null;
         if(imageLine)
         {
            ObjectUtils.disposeObject(imageLine);
         }
         imageLine = null;
         if(lbl_layer)
         {
            ObjectUtils.disposeObject(lbl_layer);
         }
         lbl_layer = null;
         if(lbl_describle)
         {
            ObjectUtils.disposeObject(lbl_describle);
         }
         lbl_describle = null;
         if(image_line2)
         {
            ObjectUtils.disposeObject(image_line2);
         }
         lbl_describle = null;
         if(_passMove)
         {
            ObjectUtils.disposeViolentMc(_passMove);
         }
         _passMove = null;
         if(_timeOutComponent)
         {
            ObjectUtils.disposeObject(_timeOutComponent);
         }
         _timeOutComponent = null;
         if(_timeOutBg)
         {
            ObjectUtils.disposeObject(_timeOutBg);
         }
         _timeOutBg = null;
         if(_timeOutView)
         {
            ObjectUtils.disposeObject(_timeOutView);
         }
         _timeOutView = null;
         _isInit = false;
      }
      
      private function onClick(param1:MouseEvent) : void
      {
         switch(param1.target)
         {
            case _startButton:
               RapidThroughPassManager.instance.requestRapidStart();
               break;
            case _hideBtn:
               showOrHidePanel(true);
               break;
            case _showBtn:
               showOrHidePanel(false);
         }
      }
      
      private function showOrHidePanel(param1:Boolean) : void
      {
         if(param1)
         {
            TweenLite.to(_container,0.5,{
               "x":292,
               "onComplete":showComplete
            });
            return;
         }
         TweenLite.to(_container,0.5,{
            "x":0,
            "onComplete":hideComplete
         });
      }
      
      private function showComplete() : void
      {
         _hideBtn.visible = false;
         _showBtn.visible = true;
      }
      
      private function hideComplete() : void
      {
         _hideBtn.visible = true;
         _showBtn.visible = false;
      }
      
      private function addEvent() : void
      {
         NotificationManager.instance.addEventListener("rapid_update",updateRapidInfo);
         NotificationManager.instance.addEventListener("rapid_collect_complete",onCollectComplete);
         _startButton.addEventListener("click",onClick);
         _showBtn.addEventListener("click",onClick);
         _hideBtn.addEventListener("click",onClick);
         _timeDownView.addEventListener("timerDown_complete",onTimeDowncompleteHandler);
      }
      
      private function removeEvent() : void
      {
         _timeDownView.stopTimer();
         _timeOutView.stopTimer();
         _startButton.removeEventListener("click",onClick);
         _timeDownView.removeEventListener("timerDown_complete",onTimeDowncompleteHandler);
         _timeOutView.removeEventListener("timerDown_complete",onTimeOutcompleteHandler);
         NotificationManager.instance.removeEventListener("rapid_collect_complete",onCollectComplete);
         NotificationManager.instance.removeEventListener("rapid_update",updateRapidInfo);
      }
      
      private function onCollectComplete(param1:RapidInfoEvent) : void
      {
         if(!param1.data)
         {
            removeEffect();
            return;
         }
         var _loc3_:int = int(CampaignManager.instance.mapModel.selfMemberData.teamId);
         var _loc4_:Object = param1.data;
         if(_loc4_ || _loc4_["info"] || _loc4_.info.param1 || _loc4_.info.param1 != _loc3_)
         {
            return;
         }
         if(_campaignMainBuilderLayer)
         {
            _campaignMainBuilderLayer.addChild(_effect);
         }
         _effect.play();
         _effect.x = _loc4_.x;
         _effect.y = _loc4_.y;
         var _loc2_:int = _effect.totalFrames * 33;
         _timeInterval = setTimeout(removeEffect,_loc2_);
      }
      
      private function removeEffect() : void
      {
         clearTimeout(_timeInterval);
         if(_campaignMainBuilderLayer && _campaignMainBuilderLayer.contains(_effect))
         {
            _campaignMainBuilderLayer.removeChild(_effect);
         }
      }
      
      private function getActiveTime(param1:String) : Number
      {
         var _loc2_:Number = NaN;
         if(!param1)
         {
            return 0;
         }
         return PlayerManager.instance.currentPlayerModel.sysCurTimeBySecond - DateFormatter.parse(param1 + " 00:00:00","YYYY-MM-DD hh:mm:ss").time / 1000;
      }
      
      private function updateRapidInfo(param1:Event = null) : void
      {
         var _loc3_:int = 0;
         var _loc4_:RapidItem = null;
         var _loc5_:RapidPassInfo = null;
         if(!_isInit)
         {
            return;
         }
         var _loc2_:RapidThroughModel = RapidThroughPassManager.instance.rapidThroughInfo;
         this.lbl_layer.text = _loc2_.pass.toString();
         _loc2_.activityTime = getActiveTime(_loc2_.beginDate);
         if(_loc2_.isStart)
         {
            showActivityTime(_loc2_.activityTime);
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.passInfos.length)
         {
            _loc4_ = _items[_loc3_];
            _loc5_ = _loc2_.passInfos[_loc3_];
            _loc4_.refreshData(_loc5_.process,_loc5_.total);
            _loc3_++;
         }
         if(Math.ceil(_loc2_.passTime) == 120)
         {
            playPassMovie(_loc2_.pass);
         }
         showPassDownTime(_loc2_.passTime,true);
         scrollTopass(_loc2_.pass);
         _scrollPanel.commitChanges();
         _scrollPanel.invalidateViewport();
         _scrollPanel.vScrollbar.visible = true;
         resize();
         this._startButton.enable = !_loc2_.isStart;
      }
      
      public function scrollTopass(param1:int) : void
      {
         var _loc3_:IntPoint = null;
         if(!_scrollPanel || !_scrollPanel.viewPort)
         {
            return;
         }
         if(param1 == 0)
         {
            return;
         }
         if(!_items || _items && _items.length == 0)
         {
            return;
         }
         var _loc2_:RapidItem = _items[param1 - 1];
         if(_loc2_)
         {
            _loc3_ = new IntPoint();
            _loc3_.x = 0;
            _loc3_.y = _loc2_.y;
            _scrollPanel.viewPort.viewPosition = _loc3_;
         }
      }
      
      private function translateToSecond(param1:String) : int
      {
         var _loc3_:Number = PlayerManager.instance.currentPlayerModel.sysSecond / 1000;
         var _loc2_:int = parseInt(param1);
         return _loc3_ - _loc2_;
      }
      
      private function onTimeDowncompleteHandler(param1:Event = null) : void
      {
         showPassDownTime(0,false);
      }
      
      private function onTimeOutcompleteHandler(param1:Event) : void
      {
      }
      
      private function playPassMovie(param1:int) : void
      {
         if(!_passMove)
         {
            _passMove = ComponentFactory.Instance.creat("asset.movie.pass") as MovieClip;
            this.addChild(_passMove);
            resize();
         }
         _passMove.numMovie.gotoAndStop(param1);
         _passMove.play();
      }
      
      private function showPassDownTime(param1:int, param2:Boolean) : void
      {
         _passTimeBg.visible = param2;
         _timeDownView.visible = param2;
         _timeDownView.timeCount = param1;
      }
      
      private function showActivityTime(param1:int) : void
      {
         _timeOutView.timeCount = param1;
         _timeOutComponent.visible = true;
      }
      
      private function initView() : void
      {
         var _loc4_:RapidItem = null;
         var _loc5_:int = 0;
         _campaignMainBuilderLayer = (CampaignManager.instance.controller as CampaignMapController).view.mainBuidingLayer;
         _container = new Component();
         this.addChild(_container);
         txtBg = ComponentFactory.Instance.creatBitmap("asset.rapid.txtBg");
         _container.addChild(txtBg);
         image_Layer = ComponentFactory.Instance.creatBitmap("asset.rapid.currentLayer");
         _container.addChild(image_Layer);
         imageLine = ComponentFactory.Instance.creatBitmap("asset.rapid.rawLine");
         _container.addChild(imageLine);
         lbl_layer = ComponentFactory.Instance.creatComponentByStylename("rapidThroughView.FilterFrameText.lbl_layer") as FilterFrameText;
         _container.addChild(lbl_layer);
         lbl_describle = ComponentFactory.Instance.creatComponentByStylename("rapidThroughView.FilterFrameText.describle") as FilterFrameText;
         _container.addChild(lbl_describle);
         image_line2 = ComponentFactory.Instance.creatBitmap("asset.rapid.rawLine");
         _container.addChild(image_line2);
         image_line2.x = 31;
         image_line2.y = 188;
         _startButton = ComponentFactory.Instance.creatComponentByStylename("rapid.startButton") as IconButton;
         addChild(_startButton);
         _passTimeBg = ComponentFactory.Instance.creatComponentByStylename("rapid.downTime") as MutipleImage;
         addChild(_passTimeBg);
         _hideBtn = ComponentFactory.Instance.creatComponentByStylename("rapid.show") as IconButton;
         _container.addChild(_hideBtn);
         _showBtn = ComponentFactory.Instance.creatComponentByStylename("rapid.hide") as IconButton;
         _container.addChild(_showBtn);
         _showBtn.visible = false;
         _rapidBox = ComponentFactory.Instance.creatComponentByStylename("rapid.layerBox");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("rapid.scrollPanel");
         _scrollPanel.setView(_rapidBox);
         _container.addChild(_scrollPanel);
         _scrollPanel.beginChanges();
         _scrollPanel.vScrollProxy = 0;
         _scrollPanel.invalidateViewport();
         _scrollPanel.vScrollbar.visible = true;
         _timeDownView = ComponentFactory.Instance.creatComponentByStylename("rapid.timeDown");
         this.addChild(_timeDownView);
         _timeOutComponent = new Component();
         _timeOutView = ComponentFactory.Instance.creatComponentByStylename("rapid.timeOut");
         _timeOutBg = ComponentFactory.Instance.creatComponentByStylename("rapid.timer");
         _timeOutComponent.addChild(_timeOutBg);
         _timeOutComponent.addChild(_timeOutView);
         _timeOutComponent.visible = false;
         this.addChild(_timeOutComponent);
         _effect = ComponentFactory.Instance.creatCustomObject("asset.campaign.rapidfire");
         var _loc6_:int = 1;
         var _loc2_:GameHallModel = GameHallManager.instance.model;
         if(_loc2_ && _loc2_.selfTeam && _loc2_.selfTeam.players)
         {
            _loc6_ = int(_loc2_.selfTeam.players.length);
         }
         var _loc3_:CampaignMapModel = CampaignManager.instance.mapModel;
         if(_loc2_ && _loc2_.allArmyDict)
         {
            _loc6_ = 0;
            for each(var _loc1_:CampaignArmy in _loc3_.allUserArmy)
            {
               _loc6_++;
            }
         }
         _loc5_ = 0;
         while(_loc5_ < 9)
         {
            _loc4_ = new RapidItem();
            _loc4_.layer = _loc5_ + 1;
            _loc4_.teamNum = _loc6_;
            _rapidBox.addChild(_loc4_);
            _items.push(_loc4_);
            _loc5_++;
         }
         lbl_describle.text = LanguageMgr.GetTranslation("rapid.createcopy.describle");
         lbl_layer.text = "1{invalid_utf8=229}{invalid_utf8=177}?";
         addEvent();
         resize();
         _isInit = true;
         updateRapidInfo();
      }
   }
}

import com.pickgliss.ui.ComponentFactory;
import com.pickgliss.ui.core.Component;
import com.pickgliss.ui.text.FilterFrameText;
import com.pickgliss.utils.ObjectUtils;
import manager.LanguageMgr;
import yishi.utils.StringUtil;

class RapidItem extends Component
{
   
   private static const items:Array = [LanguageMgr.GetTranslation("rapid.createCopy.Chest"),LanguageMgr.GetTranslation("rapid.createCopy.Egg"),LanguageMgr.GetTranslation("rapid.createCopy.aperture")];
   
   private static var target:String = LanguageMgr.GetTranslation("rapid.createCopy.alreadyComplete");
   
   private var _lbl_detail:FilterFrameText;
   
   private var _lbl_layer:FilterFrameText;
   
   private var _layer:int;
   
   private var _teamNum:int = 4;
   
   private var _takenum:int = 0;
   
   public function RapidItem()
   {
      super();
      initView();
   }
   
   public function get teamNum() : int
   {
      return _teamNum;
   }
   
   public function set teamNum(param1:int) : void
   {
      _teamNum = param1;
      refreshUI();
   }
   
   public function get layer() : int
   {
      return _layer;
   }
   
   public function set layer(param1:int) : void
   {
      _layer = param1;
   }
   
   public function refreshData(param1:int, param2:int) : void
   {
      param2 = int(param2 == 0 ? teamNum : param2);
      _lbl_detail.setFrame(2);
      if(param1 == param2)
      {
         _lbl_detail.setFrame(1);
      }
      _lbl_detail.text = StringUtil.substitute(target,param1,param2);
   }
   
   override public function dispose() : void
   {
      if(_lbl_detail)
      {
         ObjectUtils.disposeObject(_lbl_detail);
      }
      _lbl_detail = null;
      if(_lbl_layer)
      {
         ObjectUtils.disposeObject(_lbl_layer);
      }
      _lbl_layer = null;
   }
   
   private function refreshUI() : void
   {
      var _loc1_:String = items[Math.ceil(layer / 3) - 1];
      var _loc2_:String = LanguageMgr.GetTranslation("rapid.createCopy.throughPassCondition");
      _lbl_layer.text = StringUtil.substitute(_loc2_,layer,_loc1_);
      _lbl_detail.text = StringUtil.substitute(target,_takenum,_teamNum);
   }
   
   private function initView() : void
   {
      _lbl_detail = ComponentFactory.Instance.creatComponentByStylename("rapid.rapidItem.layerdetial") as FilterFrameText;
      addChild(_lbl_detail);
      _lbl_detail.height = 20;
      _lbl_layer = ComponentFactory.Instance.creatComponentByStylename("rapid.rapidItem.layertxt") as FilterFrameText;
      addChild(_lbl_layer);
   }
}
