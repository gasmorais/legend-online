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
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.stargazing.StarGazingModel;
   import mvc.module.stargazing.StarPalaceInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.StarGazingManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.StarGroupView;
   import yishi.view.tips.MessageTipManager;
   
   public class StarForceView extends Component
   {
      
      private static const POINT_NUM:int = 9;
      
      private static const STAR_MAX_NUM:int = 5;
      
      private var _mcContiner:Component;
      
      private var _starMc:MovieClip;
      
      private var _starName:FilterFrameText;
      
      private var _successRateText:FilterFrameText;
      
      private var _precentText:FilterFrameText;
      
      private var _timesCountText:FilterFrameText;
      
      private var _liveText:FilterFrameText;
      
      private var _magicDefenceText:FilterFrameText;
      
      private var _magicAttackText:FilterFrameText;
      
      private var _defenceText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _starFireText:FilterFrameText;
      
      private var _starFireImage:Image;
      
      private var _forceBack:MutipleImage;
      
      private var _littleStarBtn:BaseButton;
      
      private var _leftView:StarPalaceView;
      
      private var _ballMc:MovieClip;
      
      private var ballList:Vector.<Bitmap>;
      
      private var _starGroup:StarGroupView;
      
      private var _firePushBtn:SelectedTextButton;
      
      private var firePushCount:int;
      
      private var fireCount:int;
      
      private var _index:int = -1;
      
      private var _data:StarPalaceInfo;
      
      private var firePushTemp:GoodsTemplateInfo;
      
      public function StarForceView()
      {
         super();
         initView();
         initBallView();
         addEvent();
      }
      
      private function initView() : void
      {
         _starName = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.starName");
         _successRateText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.successRateText");
         _precentText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.precentText");
         _timesCountText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.timesCountText");
         _liveText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.liveText");
         _magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.magicDefenceText");
         _magicAttackText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.magicAttackText");
         _defenceText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.defenceText");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.attackText");
         _starFireText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.starFireText");
         _starFireImage = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.starFireImage");
         _forceBack = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.forceBack");
         _littleStarBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarForceView.littleStarBtn");
         _leftView = ComponentFactory.Instance.creatCustomObject("StarGazing.StarForceView.leftView");
         _firePushBtn = ComponentFactory.Instance.creatComponentByStylename("StarForceView.firePushBtn");
         _mcContiner = ComponentFactory.Instance.creatComponentByStylename("StarForceView.mcContiner");
         _ballMc = ComponentFactory.Instance.creatCustomObject("StarForceView.ballMc");
         _starGroup = new StarGroupView();
         _starGroup.initParams("asset.stargazing.grayStar",26,"asset.stargazing.lightStar",26,5);
         _starGroup.x = 330;
         _starGroup.y = 332;
         addChild(_leftView);
         addChild(_forceBack);
         addChild(_starName);
         addChild(_mcContiner);
         addChild(_starFireImage);
         addChild(_starFireText);
         addChild(_littleStarBtn);
         addChild(_starGroup);
         addChild(_firePushBtn);
         addChild(_attackText);
         addChild(_defenceText);
         addChild(_magicAttackText);
         addChild(_magicDefenceText);
         addChild(_liveText);
         addChild(_timesCountText);
         addChild(_precentText);
         addChild(_successRateText);
         _mcContiner.addChild(_ballMc);
         _ballMc.visible = false;
         _ballMc.gotoAndStop(1);
         var _loc1_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001016);
         _starFireImage.tipData = _loc1_.Description;
      }
      
      private function initBallView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         ballList = new Vector.<Bitmap>();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = ComponentFactory.Instance.creatBitmap("asset.starForceView.ballImage");
            _mcContiner.addChild(_loc1_);
            _loc1_.visible = false;
            ballList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function addEvent() : void
      {
         _littleStarBtn.addEventListener("click",_littleStarBtnClickHandler);
         _firePushBtn.addEventListener("click",_firePushBtnClickHandler);
         MsgMan.addObserver("SELECT_STAR_INDEX_CHANGE",this,__updateSelectStarHandler);
         MsgMan.addObserver("STAR_FORCE_POINT_CHANGE",this,__updateBallViewHandler);
         MsgMan.addObserver("STAR_VIEW_DATA_CHANGE",this,__starViewChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_littleStarBtn)
         {
            _littleStarBtn.removeEventListener("click",_littleStarBtnClickHandler);
         }
         if(_firePushBtn)
         {
            _firePushBtn.removeEventListener("click",_firePushBtnClickHandler);
         }
         MsgMan.removeObserver("SELECT_STAR_INDEX_CHANGE",this,__updateSelectStarHandler);
         MsgMan.removeObserver("STAR_FORCE_POINT_CHANGE",this,__updateBallViewHandler);
         MsgMan.removeObserver("STAR_VIEW_DATA_CHANGE",this,__starViewChangeHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         refreshBagCount();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         refreshBagCount();
      }
      
      private function _firePushBtnClickHandler(param1:MouseEvent) : void
      {
         if(firePushCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.wishBtn.noCpupon"));
            _firePushBtn.selected = false;
            return;
         }
         var _loc2_:int = int(_data ? _data.successRate : 0);
         if(_firePushBtn.selected)
         {
            _loc2_ = 100;
         }
         _successRateText.htmlText = LanguageMgr.GetTranslation("StarForceView.successRateText.text",_loc2_);
      }
      
      private function _littleStarBtnClickHandler(param1:MouseEvent) : void
      {
         if(fireCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.wishBtn.noCpupon"));
            return;
         }
         if(_data && _data.totalLightStar >= 9 * 5)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.forceView.fullAlert"));
            return;
         }
         StarGazingManager.instance.sendStarGazingForceLittle(index,_firePushBtn.selected);
      }
      
      private function __updateBallViewHandler(param1:String, param2:Object) : void
      {
         var _loc3_:int = 0;
         if(!_starMc)
         {
            return;
         }
         _data = model.getPalaceInfoByIndex(index);
         if(_data && _data.totalLightStar % 9 == 0)
         {
            _loc3_ = 8;
         }
         else
         {
            _loc3_ = _data ? _data.totalLightStar % 9 - 1 : 0;
         }
         if(_starMc && _starMc["p" + _loc3_])
         {
            _ballMc.x = _starMc["p" + _loc3_].x;
            _ballMc.y = _starMc["p" + _loc3_].y;
            _ballMc.visible = true;
            _ballMc.addFrameScript(_ballMc.totalFrames - 1,ballMcEnd);
            _ballMc.gotoAndPlay(1);
            _littleStarBtn.enable = false;
         }
         else
         {
            refreshView();
         }
      }
      
      public function ballMcEnd() : void
      {
         _ballMc.gotoAndStop(1);
         _ballMc.visible = false;
         _littleStarBtn.enable = true;
         refreshView();
      }
      
      private function __starViewChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updateSelectStarHandler(param1:String, param2:Object) : void
      {
         index = model.selectStarIndex;
      }
      
      public function get index() : int
      {
         return _index;
      }
      
      public function set index(param1:int) : void
      {
         if(_index == param1)
         {
            return;
         }
         _index = param1;
         ObjectUtils.disposeViolentMc(_starMc);
         _starMc = null;
         _starMc = ComponentFactory.Instance.creatCustomObject("StarForceView.starMc" + _index);
         _mcContiner.addChildAt(_starMc,0);
         refreshView();
      }
      
      private function refreshView() : void
      {
         _data = model.getPalaceInfoByIndex(index);
         _starName.text = LanguageMgr.GetTranslation("stargazing.starName.text" + index);
         _attackText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text5") + " " + model.starChartTotalProperty.attack;
         _defenceText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text6") + " " + model.starChartTotalProperty.defence;
         _magicAttackText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text7") + " " + model.starChartTotalProperty.magicAttack;
         _magicDefenceText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text8") + " " + model.starChartTotalProperty.magicDefence;
         _liveText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text9") + " " + model.starChartTotalProperty.live;
         var _loc1_:int = int(_data ? _data.timeCount : 0);
         var _loc3_:int = int(_data ? _data.addPrecent : 0);
         var _loc2_:int = int(_data ? _data.successRate : 0);
         _timesCountText.htmlText = LanguageMgr.GetTranslation("StarForceView.timesCountText.text",_loc1_);
         _precentText.htmlText = LanguageMgr.GetTranslation("StarForceView.precentText.text",_loc3_);
         _data ? _starGroup.setStars(_data.timeCount) : _starGroup.setStars(0);
         if(_firePushBtn.selected)
         {
            _loc2_ = 100;
         }
         _successRateText.htmlText = LanguageMgr.GetTranslation("StarForceView.successRateText.text",_loc2_);
         refreshBagCount();
         refreshBallView();
      }
      
      private function refreshBagCount() : void
      {
         firePushTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001017);
         firePushCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(8001017);
         fireCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(8001016);
         _starFireText.text = fireCount + "";
         _firePushBtn.text = firePushTemp.TemplateName + ":" + firePushCount;
         _firePushBtn.tipData = firePushTemp.Description;
         if(firePushCount <= 0)
         {
            _firePushBtn.selected = false;
         }
      }
      
      private function refreshBallView() : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         var _loc1_:Bitmap = null;
         if(_data && _data.totalLightStar == 9 * 5)
         {
            _loc3_ = 9;
         }
         else
         {
            _loc3_ = _data ? _data.totalLightStar % 9 : 0;
         }
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            _loc1_ = ballList[_loc2_];
            if(_starMc && _starMc["p" + _loc2_])
            {
               _loc1_.x = _starMc["p" + _loc2_].x;
               _loc1_.y = _starMc["p" + _loc2_].y;
            }
            _loc3_ >= _loc2_ + 1 ? (_loc1_.visible = true) : (_loc1_.visible = false);
            _loc2_++;
         }
      }
      
      private function get model() : StarGazingModel
      {
         return StarGazingManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_starName);
         _starName = null;
         ObjectUtils.disposeObject(_successRateText);
         _successRateText = null;
         ObjectUtils.disposeObject(_precentText);
         _precentText = null;
         ObjectUtils.disposeObject(_timesCountText);
         _timesCountText = null;
         ObjectUtils.disposeObject(_liveText);
         _liveText = null;
         ObjectUtils.disposeObject(_magicDefenceText);
         _magicDefenceText = null;
         ObjectUtils.disposeObject(_magicAttackText);
         _magicAttackText = null;
         ObjectUtils.disposeObject(_defenceText);
         _defenceText = null;
         ObjectUtils.disposeObject(_attackText);
         _attackText = null;
         ObjectUtils.disposeObject(_starFireText);
         _starFireText = null;
         ObjectUtils.disposeObject(_starFireImage);
         _starFireImage = null;
         ObjectUtils.disposeObject(_forceBack);
         _forceBack = null;
         ObjectUtils.disposeObject(_littleStarBtn);
         _littleStarBtn = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_starGroup);
         _starGroup = null;
         ObjectUtils.disposeObject(_firePushBtn);
         _firePushBtn = null;
         ObjectUtils.disposeViolentMc(_starMc);
         _starMc = null;
         ObjectUtils.disposeObject(_mcContiner);
         _mcContiner = null;
         ObjectUtils.disposeViolentMc(_ballMc);
         _ballMc = null;
         LogicUtils.disposeDisplayCollection(ballList);
         ballList = null;
         super.dispose();
      }
   }
}

