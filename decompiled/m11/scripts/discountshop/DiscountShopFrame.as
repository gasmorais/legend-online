package discountshop
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.ShopEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import mvc.module.discountshop.DiscountShopModel;
   import utils.LogicUtils;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.DiscountShopManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.HeadIconCell;
   import yishi.view.tips.MessageTipManager;
   
   public class DiscountShopFrame extends Frame implements Disposeable, IManualSize
   {
      
      private var _bg1:MutipleImage;
      
      private var _bg2:ScaleBitmapImage;
      
      private var _myIntegral:FilterFrameText;
      
      private var _myintegralValue:FilterFrameText;
      
      private var _describeTxt:FilterFrameText;
      
      private var _lastTime:FilterFrameText;
      
      private var _back1:Bitmap;
      
      private var _leftbg:Bitmap;
      
      private var _rightbg:Bitmap;
      
      private var _cardMovie:MovieClip;
      
      private var _tryBtn:BaseButton;
      
      private var _discountGoodsView:DiscountGoodsView;
      
      private var _discountSprite:Sprite;
      
      private var _numAsset:BitmapData;
      
      private var _bigNumAsset:BitmapData;
      
      private var _qestionMark:Bitmap;
      
      private var _headCell:HeadIconCell;
      
      private var _rewardsArray:Array = [];
      
      private var _showGoods:Boolean = true;
      
      public function DiscountShopFrame()
      {
         super();
         initView();
         initEvent();
         _refreshView();
      }
      
      override public function get groups() : Array
      {
         return ["MAIN_TOOLS_GROUP","BAG_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,886,630);
      }
      
      private function initView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:IntegralRewardsItem = null;
         _bg2 = ComponentFactory.Instance.creatComponentByStylename("discountshop.Back");
         _bg1 = ComponentFactory.Instance.creatComponentByStylename("discountshop.backBorder");
         _back1 = ComponentFactory.Instance.creatBitmap("asset.discountshop.back1");
         _leftbg = ComponentFactory.Instance.creatBitmap("asset.discountshop.leftbg1");
         _rightbg = ComponentFactory.Instance.creatBitmap("asset.discountshop.bg");
         _myIntegral = ComponentFactory.Instance.creatComponentByStylename("discountshop.integral.myIntegral");
         _myintegralValue = ComponentFactory.Instance.creatComponentByStylename("discountshop.integral.myIntegralValue");
         _describeTxt = ComponentFactory.Instance.creatComponentByStylename("discountshop.frame.descTxt");
         _lastTime = ComponentFactory.Instance.creatComponentByStylename("discountshop.frame.timeText");
         _headCell = ComponentFactory.Instance.creatCustomObject("discountshop.InformationHeadIconCell");
         _numAsset = ComponentFactory.Instance.creatBitmap("asset.discountshop.discountnumber").bitmapData.clone();
         _bigNumAsset = ComponentFactory.Instance.creatBitmap("asset.discountshop.discountBigNumber").bitmapData.clone();
         _myIntegral.text = LanguageMgr.GetTranslation("discountshop.frame.myIntegral");
         addToContent(_bg2);
         addToContent(_bg1);
         addToContent(_back1);
         addToContent(_leftbg);
         addToContent(_rightbg);
         addToContent(_headCell);
         _headCell.x = 265;
         _headCell.y = 40;
         _headCell.scaleX = _headCell.scaleY = 0.9;
         addToContent(_myIntegral);
         addToContent(_myintegralValue);
         _myintegralValue.text = "7000";
         addToContent(_describeTxt);
         _describeTxt.text = LanguageMgr.GetTranslation("discountshop.frame.luckyTime");
         addToContent(_lastTime);
         _lastTime.text = LanguageMgr.GetTranslation("discountshop.frame.lastTime");
         _loc1_ = int(discountModel.discountShopScoreInfo.length);
         while(_loc1_ > 0)
         {
            _loc2_ = new IntegralRewardsItem();
            _loc2_.x = 15;
            _loc2_.y = _loc1_ * (_loc2_.height - 25) - 55;
            addToContent(_loc2_);
            _rewardsArray.push(_loc2_);
            _loc1_--;
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         discountModel.addEventListener("DISCOUNTSHOP_UPDATE",_refreshView);
      }
      
      private function _refreshView(param1:ShopEvent = null) : void
      {
         _headCell.type = "head";
         _headCell.headId = thane.snsInfo.headId;
         if(discountModel.myDiscount > 0)
         {
            if(!_discountSprite && _showGoods)
            {
               _discountSprite = new Sprite();
               _discountSprite.x = 655;
               _discountSprite.y = 40;
               addToContent(_discountSprite);
            }
            if(_discountSprite)
            {
               NumberViewUtils.refreshValue((10 - discountModel.myDiscount) * 10,_discountSprite,_numAsset,37,69,25,37,"0123456789");
            }
            if(!_discountGoodsView && _showGoods)
            {
               _discountGoodsView = new DiscountGoodsView();
               addToContent(_discountGoodsView);
               _discountGoodsView.x = 245;
               _discountGoodsView.y = 135;
            }
            if(_discountGoodsView)
            {
               _discountGoodsView.data = discountModel.discountShopItemInfo;
            }
            if(_cardMovie && _cardMovie["card"]["container"])
            {
               NumberViewUtils.refreshValue((10 - discountModel.myDiscount) * 10,_cardMovie["card"]["container"],_numAsset,37,69,25,37,"0123456789");
            }
         }
         else
         {
            _showGoods = false;
            if(_discountGoodsView)
            {
               _discountGoodsView.visible = false;
            }
            if(_discountSprite)
            {
               _discountSprite.visible = false;
            }
            _qestionMark = ComponentFactory.Instance.creatBitmap("asset.discountshop.questionmark");
            addToContent(_qestionMark);
            _cardMovie = ComponentFactory.Instance.creatCustomObject("discountshop.discountMovie");
            _cardMovie.gotoAndStop(1);
            addToContent(_cardMovie);
            _tryBtn = ComponentFactory.Instance.creatComponentByStylename("discountshop.tryBtn");
            addToContent(_tryBtn);
            _tryBtn.addEventListener("click",_startBtnClick);
         }
         refreshIntegralView();
         _myintegralValue.text = discountModel.myScore.toString();
         _lastTime.text = LanguageMgr.GetTranslation("discountshop.frame.lastTime",discountModel.beginTime,discountModel.endTime);
      }
      
      private function refreshIntegralView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:IntegralRewardsItem = null;
         _loc2_ = int(discountModel.discountShopScoreInfo.length);
         while(_loc2_ > 0)
         {
            _loc1_ = _rewardsArray[discountModel.discountShopScoreInfo.length - _loc2_] as IntegralRewardsItem;
            _loc1_.data = discountModel.discountShopScoreInfo[_loc2_ - 1];
            _loc2_--;
         }
      }
      
      private function _startBtnClick(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         SoundManager.instance.play("022");
         _tryBtn.removeEventListener("click",_startBtnClick);
         ObjectUtils.disposeObject(_tryBtn);
         DiscountShopManager.instance.operationDiscountShop(2);
         _cardMovie.play();
         _cardMovie.addFrameScript(_cardMovie.totalFrames - 1,function():void
         {
            _showGoods = true;
            _cardMovie.stop();
            ObjectUtils.disposeViolentMc(_cardMovie);
            _cardMovie = null;
            ObjectUtils.disposeObject(_qestionMark);
            _qestionMark = null;
            _discountGoodsView = new DiscountGoodsView();
            addToContent(_discountGoodsView);
            _discountGoodsView.x = 245;
            _discountGoodsView.y = 135;
            _discountGoodsView.data = discountModel.discountShopItemInfo;
            _discountSprite = new Sprite();
            _discountSprite.x = 655;
            _discountSprite.y = 45;
            addToContent(_discountSprite);
            NumberViewUtils.refreshValue((10 - discountModel.myDiscount) * 10,_discountSprite,_numAsset,37,69,25,37,"0123456789");
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("discountshop.discountShopFrame.mydiscount",(10 - discountModel.myDiscount) * 10));
         });
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_tryBtn)
         {
            _tryBtn.removeEventListener("click",_startBtnClick);
         }
         discountModel.removeEventListener("DISCOUNTSHOP_UPDATE",_refreshView);
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
      
      public function show() : void
      {
         titleText = LanguageMgr.GetTranslation("discountshop.discountShopFrame.title");
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      public function get discountModel() : DiscountShopModel
      {
         return DiscountShopManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_bg1)
         {
            ObjectUtils.disposeObject(_bg1);
         }
         _bg1 = null;
         if(_bg2)
         {
            ObjectUtils.disposeObject(_bg2);
         }
         _bg2 = null;
         if(_myIntegral)
         {
            ObjectUtils.disposeObject(_myIntegral);
         }
         _myIntegral = null;
         if(_myintegralValue)
         {
            ObjectUtils.disposeObject(_myintegralValue);
         }
         _myintegralValue = null;
         if(_describeTxt)
         {
            ObjectUtils.disposeObject(_describeTxt);
         }
         _describeTxt = null;
         if(_lastTime)
         {
            ObjectUtils.disposeObject(_lastTime);
         }
         _lastTime = null;
         if(_back1)
         {
            ObjectUtils.disposeObject(_back1);
         }
         _back1 = null;
         if(_leftbg)
         {
            ObjectUtils.disposeObject(_leftbg);
         }
         _leftbg = null;
         if(_rightbg)
         {
            ObjectUtils.disposeObject(_rightbg);
         }
         _rightbg = null;
         if(_discountSprite)
         {
            ObjectUtils.disposeObject(_discountSprite);
         }
         _discountSprite = null;
         if(_headCell)
         {
            ObjectUtils.disposeObject(_headCell);
         }
         _headCell = null;
         if(_numAsset)
         {
            _numAsset.dispose();
         }
         _numAsset = null;
         if(_bigNumAsset)
         {
            _bigNumAsset.dispose();
         }
         _bigNumAsset = null;
         ObjectUtils.disposeObject(_discountGoodsView);
         _discountGoodsView = null;
         if(_cardMovie)
         {
            ObjectUtils.disposeViolentMc(_cardMovie);
         }
         _cardMovie = null;
         if(_tryBtn)
         {
            ObjectUtils.disposeObject(_tryBtn);
         }
         _tryBtn = null;
         if(_qestionMark)
         {
            ObjectUtils.disposeObject(_qestionMark);
         }
         _qestionMark = null;
         LogicUtils.disposeDisplayCollection(_rewardsArray);
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

