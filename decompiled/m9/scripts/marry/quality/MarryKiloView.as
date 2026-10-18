package marry.quality
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.container.SimpleTileList;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import manager.LanguageMgr;
   import managers.MarryManager;
   import marry.view.MarryRingView;
   import mvc.module.marry.MarryModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerModel;
   import yishi.datas.templates.MarryQualityData;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.NumberViewUtils;
   import yishi.view.community.BaseItemView;
   
   public class MarryKiloView extends SelectedButton
   {
      
      private var _reWardText:FilterFrameText;
      
      private var _nowPrice:Sprite;
      
      private var _priceBid:BitmapData;
      
      private var _priceLabel:Bitmap;
      
      private var _diamondIcon:Bitmap;
      
      private var _priceback:Bitmap;
      
      private var _selectedBg:Scale9CornerImage;
      
      private var _blackGound:Sprite;
      
      private var _textVbox:VBox;
      
      private var _ringView:MarryRingView;
      
      private var _qualityImg:ScaleFrameImage;
      
      private var _qualityIcon:ScaleFrameImage;
      
      private var _qualityImgBack:ScaleFrameImage;
      
      private var _quality:int;
      
      private var _rewardContainer:SimpleTileList;
      
      private var _carriageView:MarryCarriageView;
      
      private var _disCountView:MarryQualityDiscountView;
      
      public function MarryKiloView(param1:int = 1)
      {
         super();
         _quality = param1;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _selectedBg = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.selectedBg" + _quality);
         _rewardContainer = ComponentFactory.Instance.creatCustomObject("marry.rewardContainer",[4]);
         _textVbox = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.textVbox");
         _qualityImg = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.qualityImg");
         _qualityIcon = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.qualityIcon");
         _qualityImgBack = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.qualityImgBack");
         _reWardText = ComponentFactory.Instance.creatComponentByStylename("MarryKiloView.rewardText");
         _priceback = ComponentFactory.Instance.creatBitmap("asset.marry.qualityBack");
         _priceBid = ComponentFactory.Instance.creatBitmapData("asset.marry.priceNum");
         _priceLabel = ComponentFactory.Instance.creatBitmap("asset.marry.kiloBg4");
         _diamondIcon = ComponentFactory.Instance.creatBitmap("asset.marry.kiloBg6");
         _nowPrice = new Sprite();
         _nowPrice.x = 92;
         _nowPrice.y = 185;
         _selectedBg.alpha = 0;
         _reWardText.text = LanguageMgr.GetTranslation("marry.view.rewardTxt");
         addChildren();
         setCountDown();
         initReward();
         setHitArea();
         setImgFrame(_quality);
         mouseChildren = true;
      }
      
      private function setImgFrame(param1:int) : void
      {
         _qualityImg.setFrame(param1);
         if(param1 == 2)
         {
            _qualityImg.x = 48;
         }
         else if(param1 == 3)
         {
            _qualityImg.x = 43;
         }
         _qualityIcon.setFrame(param1);
         _qualityImgBack.setFrame(param1);
         if(param1 == 3)
         {
            _qualityImgBack.visible = false;
         }
         if(param1 == 1)
         {
            _reWardText.x = 33;
            _carriageView = new MarryCarriageView();
            _carriageView.x = 30;
            _carriageView.y = 230;
            addChild(_carriageView);
         }
         _diamondIcon.x = _nowPrice.x + _nowPrice.width + 10;
      }
      
      private function initEvent() : void
      {
         MsgMan.addObserver("MarryEventType.SELF_MARRY_INFO",this,setCountDown);
      }
      
      private function delEvent() : void
      {
         MsgMan.removeObserver("MarryEventType.SELF_MARRY_INFO",this,setCountDown);
      }
      
      private function get temp() : MarryQualityData
      {
         return TempleteManager.instance.getMarryQualityTemplateCate.getTempById(_quality);
      }
      
      private function setCountDown(param1:String = "", param2:Object = null) : void
      {
         var _loc4_:int = int(model.getMarryQualityCosts(_quality));
         NumberViewUtils.refreshValue(_loc4_,_nowPrice,_priceBid,17,27,14,17,"0123456789");
         var _loc3_:int = int(model.selfMarryInfo.marriageTime) + 259200 - playerModel.sysCurTimeBySecond;
         if(_loc3_ <= 0)
         {
            return;
         }
         if(!_disCountView)
         {
            _disCountView = new MarryQualityDiscountView();
            addChild(_disCountView);
         }
         _disCountView.setCount(_loc3_);
         _disCountView.setQuality(_quality);
      }
      
      private function initReward() : void
      {
         var _loc2_:Array = null;
         var _loc3_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc4_:GoodsInfo = null;
         if(temp)
         {
            _loc2_ = temp.Rewards.split("|");
            _loc3_ = 0;
            while(_loc3_ < _loc2_.length)
            {
               if(_loc2_[_loc3_] != "")
               {
                  _loc1_ = ComponentFactory.Instance.creatCustomObject("MarryKiloView.rewardItem");
                  _loc4_ = new GoodsInfo();
                  _loc4_.templateId = _loc2_[_loc3_].split(",")[0];
                  _loc4_.count = _loc2_[_loc3_].split(",")[1];
                  _loc1_.data = _loc4_;
                  _rewardContainer.addChild(_loc1_);
               }
               _loc3_++;
            }
         }
         if(_quality != 1)
         {
            _rewardContainer.x = 19;
         }
         _rewardContainer.refreshChildPos();
      }
      
      private function setHitArea() : void
      {
         hitArea = _selectedBg;
      }
      
      private function addBlackMask() : void
      {
         if(_blackGound == null)
         {
            _blackGound = new Sprite();
            _blackGound.graphics.beginFill(0,0.5);
            _blackGound.graphics.drawRect(_qualityIcon.x,_qualityIcon.y,_qualityIcon.getFrameImage(_quality - 1).width,_qualityIcon.getFrameImage(_quality - 1).height);
            _blackGound.graphics.endFill();
            _blackGound.mouseChildren = false;
            _blackGound.mouseEnabled = false;
            addChild(_blackGound);
         }
      }
      
      private function get model() : MarryModel
      {
         return MarryManager.instance.model;
      }
      
      private function get playerModel() : PlayerModel
      {
         return PlayerManager.instance.currentPlayerModel;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_qualityIcon)
         {
            addChild(_qualityIcon);
         }
         if(_priceback)
         {
            addChild(_priceback);
         }
         if(_nowPrice)
         {
            addChild(_nowPrice);
         }
         if(_priceLabel)
         {
            addChild(_priceLabel);
         }
         if(_diamondIcon)
         {
            addChild(_diamondIcon);
         }
         if(_selectedBg)
         {
            addChild(_selectedBg);
         }
         if(_qualityImgBack)
         {
            addChild(_qualityImgBack);
         }
         if(_qualityImg)
         {
            addChild(_qualityImg);
         }
         if(_rewardContainer)
         {
            addChild(_rewardContainer);
         }
         if(_reWardText)
         {
            addChild(_reWardText);
         }
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(_selectedBg)
         {
            _selectedBg.alpha = param1 ? 1 : 0;
         }
      }
      
      override public function dispose() : void
      {
         delEvent();
         if(_priceback)
         {
            _priceback.bitmapData.dispose();
         }
         _priceback = null;
         if(_disCountView)
         {
            _disCountView.dispose();
         }
         _disCountView = null;
         if(_selectedBg)
         {
            _selectedBg.dispose();
         }
         _selectedBg = null;
         if(_qualityImgBack)
         {
            _qualityImgBack.dispose();
         }
         _qualityImgBack = null;
         if(_qualityIcon)
         {
            _qualityIcon.dispose();
         }
         _qualityIcon = null;
         if(_priceLabel)
         {
            _priceLabel.bitmapData.dispose();
         }
         _priceLabel = null;
         if(_diamondIcon)
         {
            _diamondIcon.bitmapData.dispose();
         }
         _diamondIcon = null;
         if(_rewardContainer)
         {
            _rewardContainer.dispose();
         }
         _rewardContainer = null;
         if(_reWardText)
         {
            _reWardText.dispose();
         }
         _reWardText = null;
         if(_carriageView)
         {
            _carriageView.dispose();
         }
         _carriageView = null;
         if(_blackGound)
         {
            _blackGound.graphics.clear();
         }
         _blackGound = null;
         super.dispose();
      }
   }
}

