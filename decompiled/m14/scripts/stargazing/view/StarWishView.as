package stargazing.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import manager.LanguageMgr;
   import mvc.module.stargazing.StarGazingModel;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.StarGazingDropTemplateInfo;
   import yishi.events.PlayerEvent;
   import yishi.manager.GoodsManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.StarGazingManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressCommon;
   import yishi.view.community.BaseItemView;
   import yishi.view.component.TileContainer;
   import yishi.view.tips.MessageTipManager;
   
   public class StarWishView extends Component
   {
      
      private static const BALL_COUNT:int = 7;
      
      private var _starPieceText:FilterFrameText;
      
      private var _advanceWishText:FilterFrameText;
      
      private var _normalWishText:FilterFrameText;
      
      private var _starPieceImage:Image;
      
      private var _normalWishBtn:BaseButton;
      
      private var _prayBtn:BaseButton;
      
      private var _advanceWishBtn:BaseButton;
      
      private var _back:MutipleImage;
      
      private var _ballContiner:Component;
      
      private var ballList:Vector.<StarWishBallItem>;
      
      private var _processBar:ProgressCommon;
      
      private var _normalCouponBtn:SelectedTextButton;
      
      private var _advanceCouponBtn:SelectedTextButton;
      
      private var _normalRewardContiner:TileContainer;
      
      private var _advanceRewardContiner:TileContainer;
      
      private var normalRewardList:Vector.<BaseItemView>;
      
      private var advanceRewardList:Vector.<BaseItemView>;
      
      private var preDay:int;
      
      private var normalCouponCount:int;
      
      private var advanceCouponCount:int;
      
      private var prePowerNum:int;
      
      private var isFirst:Boolean = true;
      
      private var couponTemp1:GoodsTemplateInfo;
      
      private var couponTemp2:GoodsTemplateInfo;
      
      public var BALL_POINT_ARRAT:Array = [[30,85],[130,15],[210,85],[325,15],[415,85],[520,15],[620,85]];
      
      private var refreshTimeId:int;
      
      public function StarWishView()
      {
         super();
         initView();
         initBallView();
         initRewardView();
         addEvent();
      }
      
      private function initView() : void
      {
         _ballContiner = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.ballContiner");
         _starPieceText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.starPieceText");
         _advanceWishText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.advanceWishText");
         _normalWishText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.normalWishText");
         _starPieceImage = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.starPieceImage");
         _normalWishBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.normalWishBtn");
         _prayBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.prayBtn");
         _advanceWishBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.advanceWishBtn");
         _back = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarWishView.back");
         _processBar = ComponentFactory.Instance.creatComponentByStylename("StarWishView.processBar");
         _normalCouponBtn = ComponentFactory.Instance.creatComponentByStylename("StarWishView.normalCouponBtn");
         _advanceCouponBtn = ComponentFactory.Instance.creatComponentByStylename("StarWishView.advanceCouponBtn");
         _normalRewardContiner = ComponentFactory.Instance.creatCustomObject("StarWishView.normalRewardContiner");
         _advanceRewardContiner = ComponentFactory.Instance.creatCustomObject("StarWishView.advanceRewardContiner");
         addChild(_back);
         addChild(_ballContiner);
         addChild(_processBar);
         addChild(_starPieceImage);
         addChild(_starPieceText);
         addChild(_normalWishText);
         addChild(_advanceWishText);
         addChild(_prayBtn);
         addChild(_normalRewardContiner);
         addChild(_advanceRewardContiner);
         addChild(_normalCouponBtn);
         addChild(_advanceCouponBtn);
         addChild(_normalWishBtn);
         addChild(_advanceWishBtn);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001000);
         _starPieceImage.tipData = _loc1_.Description;
      }
      
      private function initBallView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:StarWishBallItem = null;
         ballList = new Vector.<StarWishBallItem>();
         _loc2_ = 0;
         while(_loc2_ < 7)
         {
            _loc1_ = new StarWishBallItem();
            _ballContiner.addChild(_loc1_);
            _loc1_.x = BALL_POINT_ARRAT[_loc2_][0];
            _loc1_.y = BALL_POINT_ARRAT[_loc2_][1];
            ballList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initRewardView() : void
      {
         var _loc5_:StarGazingDropTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc9_:GoodsInfo = null;
         var _loc8_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         normalRewardList = new Vector.<BaseItemView>();
         advanceRewardList = new Vector.<BaseItemView>();
         var _loc6_:int = getToday();
         var _loc10_:Array = TempleteManager.instance.starGazingDropTempCate.getTemplatesByTypeAndDay(2,_loc6_);
         var _loc3_:Array = TempleteManager.instance.starGazingDropTempCate.getTemplatesByTypeAndDay(3,_loc6_);
         preDay = _loc6_;
         _loc7_ = 0;
         while(_loc7_ < 10)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("StarWishView.rewadItem");
            _loc5_ = _loc10_[_loc7_];
            _loc9_ = new GoodsInfo();
            _loc9_.templateId = _loc5_.itemId;
            _loc9_.count = _loc5_.count;
            _loc1_.data = _loc9_;
            _normalRewardContiner.appendItem(_loc1_);
            normalRewardList.push(_loc1_);
            _loc7_++;
         }
         _loc8_ = 0;
         while(_loc8_ < 6)
         {
            _loc2_ = ComponentFactory.Instance.creatCustomObject("StarWishView.rewadItem");
            _loc5_ = _loc3_[_loc8_];
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc5_.itemId;
            _loc4_.count = _loc5_.count;
            _loc2_.data = _loc4_;
            _advanceRewardContiner.appendItem(_loc2_);
            advanceRewardList.push(_loc2_);
            _loc8_++;
         }
      }
      
      private function addEvent() : void
      {
         _advanceWishBtn.addEventListener("click",_advanceWishBtnClickHandler);
         _prayBtn.addEventListener("click",_prayBtnClickHandler);
         _normalWishBtn.addEventListener("click",_normalWishBtnClickHandler);
         _normalCouponBtn.addEventListener("click",_normalCouponBtnClickHandler);
         _advanceCouponBtn.addEventListener("click",_advanceCouponBtnClickHandler);
         MsgMan.addObserver("STAR_POWER_CHANGE",this,starPowerChangeHandler);
         MsgMan.addObserver("STAR_VIEW_DATA_CHANGE",this,starWishViewChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         playerModel.addEventListener("SYSTIME_UPGRADE_SECOND",__sysTimeUpdateHandler);
      }
      
      private function removeEvent() : void
      {
         if(_advanceWishBtn)
         {
            _advanceWishBtn.removeEventListener("click",_advanceWishBtnClickHandler);
         }
         if(_prayBtn)
         {
            _prayBtn.removeEventListener("click",_prayBtnClickHandler);
         }
         if(_normalWishBtn)
         {
            _normalWishBtn.removeEventListener("click",_normalWishBtnClickHandler);
         }
         if(_normalCouponBtn)
         {
            _normalCouponBtn.removeEventListener("click",_normalCouponBtnClickHandler);
         }
         if(_advanceCouponBtn)
         {
            _advanceCouponBtn.removeEventListener("click",_advanceCouponBtnClickHandler);
         }
         MsgMan.removeObserver("STAR_POWER_CHANGE",this,starPowerChangeHandler);
         MsgMan.removeObserver("STAR_VIEW_DATA_CHANGE",this,starWishViewChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         playerModel.removeEventListener("SYSTIME_UPGRADE_SECOND",__sysTimeUpdateHandler);
      }
      
      private function __sysTimeUpdateHandler(param1:PlayerEvent) : void
      {
         var _loc4_:StarGazingDropTemplateInfo = null;
         var _loc6_:int = 0;
         var _loc8_:GoodsInfo = null;
         var _loc7_:int = 0;
         var _loc3_:GoodsInfo = null;
         var _loc5_:int = getToday();
         if(preDay == _loc5_)
         {
            return;
         }
         preDay = _loc5_;
         var _loc9_:Array = TempleteManager.instance.starGazingDropTempCate.getTemplatesByTypeAndDay(2,_loc5_);
         var _loc2_:Array = TempleteManager.instance.starGazingDropTempCate.getTemplatesByTypeAndDay(3,_loc5_);
         _loc6_ = 0;
         while(_loc6_ < normalRewardList.length)
         {
            _loc4_ = _loc9_[_loc6_];
            _loc8_ = new GoodsInfo();
            _loc8_.templateId = _loc4_.itemId;
            _loc8_.count = _loc4_.count;
            normalRewardList[_loc6_].data = _loc8_;
            _loc6_++;
         }
         _loc7_ = 0;
         while(_loc7_ < advanceRewardList.length)
         {
            _loc4_ = _loc2_[_loc7_];
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc4_.itemId;
            _loc3_.count = _loc4_.count;
            advanceRewardList[_loc7_].data = _loc3_;
            _loc7_++;
         }
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         refreshBagCount();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         refreshBagCount();
      }
      
      private function _prayBtnClickHandler(param1:MouseEvent) : void
      {
         if(model.starPieceCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.prayBtn.noPieceCount"));
            return;
         }
         StarGazingManager.instance.sendStarGazingRequest(2);
      }
      
      private function _normalWishBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(model.normalWishCount <= 0 && !_normalCouponBtn.selected)
         {
            _loc2_ = couponTemp1 ? couponTemp1.TemplateName : "";
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.normalWishBtn.nomalWishCountOrCpupon",_loc2_));
            return;
         }
         StarGazingManager.instance.sendStarGazingWish(3,_normalCouponBtn.selected);
      }
      
      private function _advanceWishBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = couponTemp2 ? couponTemp2.TemplateName : "";
         if(model.advanceWishCount <= 0 && !_advanceCouponBtn.selected)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.advanceWishBtn.advanceWishCountOrCpupon",_loc2_));
            return;
         }
         StarGazingManager.instance.sendStarGazingWish(4,_advanceCouponBtn.selected);
      }
      
      private function _normalCouponBtnClickHandler(param1:MouseEvent) : void
      {
         if(normalCouponCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.wishBtn.noCpupon"));
            _normalCouponBtn.selected = false;
            return;
         }
      }
      
      private function _advanceCouponBtnClickHandler(param1:MouseEvent) : void
      {
         if(advanceCouponCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.wishBtn.noCpupon"));
            _advanceCouponBtn.selected = false;
            return;
         }
      }
      
      private function starWishViewChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function starPowerChangeHandler(param1:String, param2:Object) : void
      {
         var _loc6_:StarWishBallItem = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         if(isFirst)
         {
            return;
         }
         var _loc3_:int = int(model.starDesire / 100) % 7;
         if(model.isTurnChange)
         {
            _loc4_ = prePowerNum;
            while(_loc4_ < 7)
            {
               _loc6_ = ballList[_loc4_];
               _loc6_.playBallMc();
               _loc4_++;
            }
            if(prePowerNum < 7)
            {
               refreshTimeId = setTimeout(playOtherMc,1300);
            }
            else
            {
               playOtherMc();
            }
         }
         else
         {
            _loc5_ = prePowerNum;
            while(_loc5_ < _loc3_)
            {
               _loc6_ = ballList[_loc5_];
               _loc6_.playBallMc();
               _loc5_++;
            }
            if(prePowerNum < _loc3_)
            {
               refreshTimeId = setTimeout(refreshView,1300);
            }
            else
            {
               refreshView();
            }
         }
      }
      
      private function playOtherMc() : void
      {
         var _loc2_:int = 0;
         var _loc3_:StarWishBallItem = null;
         clearInterval(refreshTimeId);
         refreshTimeId = 0;
         var _loc1_:int = int(model.starDesire / 100) % 7;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc3_ = ballList[_loc2_];
            _loc3_.playBallMc();
            _loc2_++;
         }
         if(_loc1_ > 0)
         {
            refreshTimeId = setTimeout(refreshView,1300);
         }
         else
         {
            refreshView();
         }
      }
      
      public function refreshView() : void
      {
         _starPieceText.text = model.starPieceCount + "";
         _normalWishText.text = model.normalWishCount + "";
         _advanceWishText.text = model.advanceWishCount + "";
         _processBar.value = model.starDesire % 100 / 100;
         _processBar.text = model.starDesire % 100 + "/" + 100;
         refreshBagCount();
         refreshBallView();
         isFirst = false;
      }
      
      private function refreshBagCount() : void
      {
         couponTemp1 = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001001);
         couponTemp2 = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001002);
         normalCouponCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(8001001);
         advanceCouponCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(8001002);
         _normalCouponBtn.text = couponTemp1.TemplateName + ":" + normalCouponCount;
         _advanceCouponBtn.text = couponTemp2.TemplateName + ":" + advanceCouponCount;
         _normalCouponBtn.tipData = couponTemp1.Description;
         _advanceCouponBtn.tipData = couponTemp2.Description;
         if(normalCouponCount <= 0)
         {
            _normalCouponBtn.selected = false;
         }
         if(advanceCouponCount <= 0)
         {
            _advanceCouponBtn.selected = false;
         }
      }
      
      private function refreshBallView() : void
      {
         var _loc1_:int = 0;
         var _loc3_:StarWishBallItem = null;
         clearInterval(refreshTimeId);
         refreshTimeId = 0;
         var _loc2_:int = int(model.starDesire / 100) % 7;
         prePowerNum = _loc2_;
         _loc1_ = 0;
         while(_loc1_ < 7)
         {
            _loc3_ = ballList[_loc1_];
            _loc2_ >= _loc1_ + 1 ? _loc3_.setState(2) : _loc3_.setState(1);
            _loc1_++;
         }
      }
      
      private function get model() : StarGazingModel
      {
         return StarGazingManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      public function getToday() : int
      {
         return playerModel.sysCurtime.day;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         clearInterval(refreshTimeId);
         ObjectUtils.disposeObject(_starPieceText);
         _starPieceText = null;
         ObjectUtils.disposeObject(_advanceWishText);
         _advanceWishText = null;
         ObjectUtils.disposeObject(_normalWishText);
         _normalWishText = null;
         ObjectUtils.disposeObject(_starPieceImage);
         _starPieceImage = null;
         ObjectUtils.disposeObject(_normalWishBtn);
         _normalWishBtn = null;
         ObjectUtils.disposeObject(_prayBtn);
         _prayBtn = null;
         ObjectUtils.disposeObject(_advanceWishBtn);
         _advanceWishBtn = null;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_normalRewardContiner);
         _normalRewardContiner = null;
         ObjectUtils.disposeObject(_advanceRewardContiner);
         _advanceRewardContiner = null;
         ObjectUtils.disposeObject(_ballContiner);
         _ballContiner = null;
         ObjectUtils.disposeObject(_processBar);
         _processBar = null;
         ObjectUtils.disposeObject(_normalCouponBtn);
         _normalCouponBtn = null;
         ObjectUtils.disposeObject(_advanceCouponBtn);
         _advanceCouponBtn = null;
         LogicUtils.disposeDisplayCollection(ballList);
         ballList = null;
         LogicUtils.disposeDisplayCollection(normalRewardList);
         normalRewardList = null;
         LogicUtils.disposeDisplayCollection(advanceRewardList);
         advanceRewardList = null;
         super.dispose();
      }
   }
}

