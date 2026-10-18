package singlepass.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.SinglePassEvent;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.SinglePassManager;
   import managers.SinglePassSocketOutManager;
   import mvc.module.singlepass.SinglePassCardInfo;
   import mvc.module.singlepass.SinglePassModel;
   import mvc.module.singlepass.SinglePassTipData;
   import singlepass.SinglePassFrame;
   import singlepass.order.SinglePassOrderFrame;
   import yishi.filter.SimpleBuildingFilter;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.NumberViewUtils;
   import yishi.view.tips.MessageTipManager;
   
   public class SinglePassView extends Sprite
   {
      
      private var _container:SinglePassFrame;
      
      private var _model:SinglePassModel;
      
      private var _bg:Bitmap;
      
      private var _chapterRewardBtn1:BaseButton;
      
      private var _chapterRewardBtn2:IconButton;
      
      private var _prevFloorBtn:IconButton;
      
      private var _nextFloorBtn:IconButton;
      
      private var _orderLinkTxt:FilterFrameText;
      
      private var _singlePassCardView:SinglePassCardView;
      
      private var _leftCountTxt:GradientText;
      
      private var _leftNumberBitmapData:BitmapData;
      
      private var _leftCountPanel:Sprite;
      
      private var _tollgateTitleBg:Image;
      
      private var _tollgateTitleTxt:GradientText;
      
      private var _getHornBtn:IconButton;
      
      private var _hornHasNumTxt:FilterFrameText;
      
      private var _tollgateBtns:Vector.<SinglePassBtnView>;
      
      private var _canUpdateArea:Boolean = false;
      
      private var _selectAreaTollgateCount:int = 0;
      
      private var _leftCount:int;
      
      private var _filter:SimpleBuildingFilter = new SimpleBuildingFilter();
      
      private var _bugleLeftCount:int;
      
      public function SinglePassView(param1:SinglePassFrame)
      {
         super();
         _container = param1;
         _model = SinglePassManager.instance.model;
         _tollgateBtns = new Vector.<SinglePassBtnView>();
         initView();
         initEvent();
         refreshView();
         SinglePassSocketOutManager.sendRequestSinglePassInfo();
      }
      
      private function initView() : void
      {
         var _loc2_:SinglePassBtnView = null;
         var _loc1_:int = 0;
         _bg = ComponentFactory.Instance.creatBitmap("asset.singlepass.BgAsset");
         _singlePassCardView = new SinglePassCardView();
         _chapterRewardBtn1 = ComponentFactory.Instance.creatComponentByStylename("singlepass.ChapterRewardBtn1");
         _chapterRewardBtn2 = ComponentFactory.Instance.creatComponentByStylename("singlepass.ChapterRewardBtn2");
         _prevFloorBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.PrevFloorBtn");
         _nextFloorBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.NextFloorBtn");
         _orderLinkTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.OrderLinkTxt");
         _leftCountTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.LeftCountTxt");
         _leftNumberBitmapData = ComponentFactory.Instance.creatBitmapData("asset.singlepass.CountNumberAsset");
         _leftCountPanel = ComponentFactory.Instance.creatCustomObject("singlepass.LeftCountSprite");
         _tollgateTitleBg = ComponentFactory.Instance.creatComponentByStylename("singlepass.TollgateTitleBg");
         _tollgateTitleTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.TollgateTitleTxt");
         _getHornBtn = ComponentFactory.Instance.creatComponentByStylename("singlepass.getHornBtn");
         _hornHasNumTxt = ComponentFactory.Instance.creatComponentByStylename("singlepass.hornHasNumTxt");
         addChild(_bg);
         addChild(_singlePassCardView);
         addChild(_chapterRewardBtn1);
         addChild(_chapterRewardBtn2);
         addChild(_prevFloorBtn);
         addChild(_nextFloorBtn);
         addChild(_orderLinkTxt);
         addChild(_leftCountTxt);
         addChild(_leftCountPanel);
         addChild(_tollgateTitleBg);
         addChild(_tollgateTitleTxt);
         addChild(_getHornBtn);
         addChild(_hornHasNumTxt);
         _loc1_ = 0;
         while(_loc1_ < 10)
         {
            _loc2_ = new SinglePassBtnView(_loc1_ + 1);
            _loc2_.y = 330;
            _loc2_.x = 40 + _loc1_ * 60;
            addChild(_loc2_);
            _loc2_.clickFunction = clickFunction;
            _tollgateBtns.push(_loc2_);
            _loc1_++;
         }
         _prevFloorBtn.text = LanguageMgr.GetTranslation("singlepass.order.SinglePassView.PrevFloorBtnTxt");
         _nextFloorBtn.text = LanguageMgr.GetTranslation("singlepass.order.SinglePassView.NextFloorBtnTxt");
         _orderLinkTxt.htmlText = "<a href =\'event: \'><u>" + LanguageMgr.GetTranslation("mainBar.SmallMapBar.rankingBtnTipData") + "</u></a>";
         _orderLinkTxt.mouseEnabled = true;
         _leftCountTxt.text = LanguageMgr.GetTranslation("PetChallengeCDView.remainTimesLabel");
         _tollgateTitleTxt.text = LanguageMgr.GetTranslation("singlepass.order.SinglePassView.TollgateTitleTxt");
         _singlePassCardView.turnFunction = cardTurnFunction;
      }
      
      private function uninitView() : void
      {
         var _loc1_:SinglePassBtnView = null;
         for each(_loc1_ in _tollgateBtns)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_singlePassCardView);
         _singlePassCardView = null;
         ObjectUtils.disposeObject(_chapterRewardBtn1);
         _chapterRewardBtn1 = null;
         ObjectUtils.disposeObject(_chapterRewardBtn2);
         _chapterRewardBtn2 = null;
         ObjectUtils.disposeObject(_prevFloorBtn);
         _prevFloorBtn = null;
         ObjectUtils.disposeObject(_nextFloorBtn);
         _nextFloorBtn = null;
         ObjectUtils.disposeObject(_orderLinkTxt);
         _orderLinkTxt = null;
         ObjectUtils.disposeObject(_leftCountTxt);
         _leftCountTxt = null;
         ObjectUtils.disposeObject(_leftNumberBitmapData);
         _leftNumberBitmapData = null;
         ObjectUtils.disposeObject(_leftCountPanel);
         _leftCountPanel = null;
         ObjectUtils.disposeObject(_tollgateTitleBg);
         _tollgateTitleBg = null;
         ObjectUtils.disposeObject(_tollgateTitleTxt);
         _tollgateTitleTxt = null;
         ObjectUtils.disposeObject(_getHornBtn);
         _getHornBtn = null;
         ObjectUtils.disposeObject(_hornHasNumTxt);
         _hornHasNumTxt = null;
         ObjectUtils.disposeAllChildren(this);
         _model = null;
         _tollgateBtns = null;
      }
      
      private function initEvent() : void
      {
         _model.addEventListener("SINGLEPASS_INFO_UPDATE",__singlePassInfoUpdateHandler);
         _chapterRewardBtn1.addEventListener("click",__onRewardBtnClick);
         _prevFloorBtn.addEventListener("click",__prevFloorBtnClickHandler);
         _nextFloorBtn.addEventListener("click",__nextFloorBtnClickHandler);
         _getHornBtn.addEventListener("click",__getHornBtnClickHandler);
         _orderLinkTxt.addEventListener("click",__orderLinkTxtClickHandler);
      }
      
      private function removeEvent() : void
      {
         _model.removeEventListener("SINGLEPASS_INFO_UPDATE",__singlePassInfoUpdateHandler);
         _chapterRewardBtn1.removeEventListener("click",__onRewardBtnClick);
         _prevFloorBtn.removeEventListener("click",__prevFloorBtnClickHandler);
         _nextFloorBtn.removeEventListener("click",__nextFloorBtnClickHandler);
         _getHornBtn.removeEventListener("click",__getHornBtnClickHandler);
         _orderLinkTxt.removeEventListener("click",__orderLinkTxtClickHandler);
         _model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
      }
      
      private function __orderLinkTxtClickHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         _model.addEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         FrameControllerManager.instance.singlePassFrameController.loadSinglePassOrderData();
      }
      
      private function __orderDataLoadCompleteHandler(param1:SinglePassEvent) : void
      {
         _model.removeEventListener("ORDERDATA_LOAD_COMPLETE",__orderDataLoadCompleteHandler);
         var _loc2_:SinglePassOrderFrame = ComponentFactory.Instance.creatComponentByStylename("singlepass.order.SinglePassOrderFrame");
         _loc2_.show();
      }
      
      private function __getHornBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:String = null;
         var _loc3_:int = _model.maxIndex / 5;
         var _loc2_:int = (_loc3_ + 1) * 5;
         _loc4_ = (_loc2_ - 1) / 10 + 1;
         _loc6_ = _loc2_ % 10;
         if(_loc6_ == 0)
         {
            _loc6_ = 10;
         }
         if(_model.maxIndex < 10 * 10)
         {
            _loc5_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.GetHornBtnTips02",SinglePassModel.FLOOR_STR[_loc4_],_loc6_,_model.bugleCount);
         }
         else
         {
            _loc5_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.GetHornBtnTips03");
         }
         if(_bugleLeftCount > 0)
         {
            _model.itemCount += _bugleLeftCount;
            _bugleLeftCount = 0;
            _hornHasNumTxt.text = _bugleLeftCount.toString();
            SinglePassSocketOutManager.sendRequestGetBugle();
            _getHornBtn.tipData = _loc5_;
         }
         else
         {
            MessageTipManager.instance().show(_loc5_);
         }
      }
      
      private function __nextFloorBtnClickHandler(param1:MouseEvent) : void
      {
         if(_model.selectArea == 10)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("singlepass.order.SinglePassView.TipTxt"));
            return;
         }
         if(_canUpdateArea)
         {
            SinglePassSocketOutManager.sendRequestUpdateArea();
            _canUpdateArea = false;
            return;
         }
         _model.selectArea = nextFloor;
         _model.selectIndex = SinglePassManager.instance.getCardIndex();
         refreshView();
      }
      
      private function __prevFloorBtnClickHandler(param1:MouseEvent) : void
      {
         _model.selectArea = prevFloor;
         _model.selectIndex = SinglePassManager.instance.getCardIndex();
         refreshView();
      }
      
      private function __onRewardBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("022");
         SinglePassManager.instance.sendRequestGetAreaReward();
      }
      
      private function __singlePassInfoUpdateHandler(param1:SinglePassEvent) : void
      {
         var _loc2_:int = 0;
         _model.selectArea = _model.area;
         _model.selectIndex = _model.maxIndex;
         if(_model.lastIndex > 0 && _model.lastIndex != _model.maxIndex)
         {
            _loc2_ = (_model.lastIndex - 1) / 10 + 1;
            if(_model.floors.indexOf(_loc2_) != -1)
            {
               _model.selectArea = _loc2_;
            }
         }
         refreshView();
      }
      
      private function cardTurnFunction() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _tollgateBtns)
         {
            _filter.setNormalFilter(_loc1_);
         }
         _filter.setGlowFilter(_tollgateBtns[_singlePassCardView.index]);
      }
      
      private function clickFunction(param1:int) : void
      {
         var _loc2_:int = 0;
         if(!_model.isMaxJudge(param1))
         {
            _loc2_ = param1 % 10 - 1;
            if(_loc2_ < 0)
            {
               _loc2_ = 9;
            }
            if(_loc2_ == _singlePassCardView.index)
            {
               SinglePassManager.instance.sendRequestSinglePassAttack(param1);
            }
            _singlePassCardView.turnTollgate(_loc2_);
         }
         else
         {
            SinglePassManager.instance.sendRequestSinglePassAttack(param1);
         }
      }
      
      private function get minFloor() : int
      {
         return _model.floors[0];
      }
      
      private function get maxFloor() : int
      {
         return _model.floors[_model.floors.length - 1];
      }
      
      private function get prevFloor() : int
      {
         var _loc1_:int = int(_model.floors.indexOf(_model.selectArea));
         if(--_loc1_ < 0)
         {
            _loc1_ = 1;
         }
         return _model.floors[_loc1_];
      }
      
      private function get nextFloor() : int
      {
         var _loc1_:int = int(_model.floors.indexOf(_model.selectArea));
         if(++_loc1_ > _model.floors.length - 1)
         {
            _loc1_ = _model.floors.length - 1;
         }
         return _model.floors[_loc1_];
      }
      
      private function refreshView() : void
      {
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc7_:int = 0;
         var _loc9_:int = 0;
         var _loc8_:String = null;
         _chapterRewardBtn1.visible = false;
         _chapterRewardBtn2.visible = false;
         _prevFloorBtn.enable = false;
         _nextFloorBtn.enable = false;
         for each(_loc5_ in _tollgateBtns)
         {
            _loc5_.enable = false;
         }
         if(_model.selectArea < minFloor)
         {
            _model.selectArea = minFloor;
         }
         else if(_model.selectArea > maxFloor)
         {
            _model.selectArea = maxFloor;
         }
         _container.titleText = LanguageMgr.GetTranslation("singlepass.order.SinglePassView.TitleTxt",SinglePassModel.FLOOR_STR[_model.selectArea]);
         if(_model.selectArea < _model.area)
         {
            _selectAreaTollgateCount = 10;
         }
         else
         {
            _selectAreaTollgateCount = _model.maxIndex - (_model.area - 1) * 10;
         }
         var _loc3_:Vector.<SinglePassCardInfo> = _model.getCardInfoByFloor(_model.selectArea);
         _singlePassCardView.index = SinglePassManager.instance.getCardIndex();
         _singlePassCardView.cardInfos = _loc3_;
         if(SinglePassManager.instance.needTurnNext())
         {
            _model.selectIndex = _model.maxIndex - 1;
            _singlePassCardView.index = SinglePassManager.instance.getCardIndex();
            _singlePassCardView.nextTollgate();
         }
         _loc4_ = 0;
         while(_loc4_ < 10)
         {
            _tollgateBtns[_loc4_].data = _loc3_[_loc4_];
            if(_loc4_ <= _selectAreaTollgateCount)
            {
               _tollgateBtns[_loc4_].enable = true;
            }
            _loc4_++;
         }
         if(_model.selectArea > minFloor)
         {
            _prevFloorBtn.enable = true;
         }
         if(_model.selectArea < _model.area)
         {
            _nextFloorBtn.enable = true;
         }
         if(_model.selectArea == _model.area)
         {
            if(_model.maxIndex == _model.area * 10)
            {
               _nextFloorBtn.enable = true;
               _canUpdateArea = true;
            }
         }
         else
         {
            _canUpdateArea = false;
         }
         if(_model.areaRewardArray && _model.areaRewardArray.indexOf(_model.selectArea.toString()) != -1)
         {
            _chapterRewardBtn1.visible = false;
            _chapterRewardBtn2.visible = true;
         }
         else
         {
            _chapterRewardBtn1.visible = true;
            _chapterRewardBtn2.visible = false;
         }
         _leftCount = _model.maxCount - _model.count;
         _leftCountTxt.text = LanguageMgr.GetTranslation("PetChallengeCDView.remainTimesLabel");
         if(_leftCount <= 0)
         {
            _leftCount = GoodsManager.instance.getGoodsNumByTempId(3140001);
            if(_leftCount > 0)
            {
               _leftCountTxt.text = LanguageMgr.GetTranslation("singlepass.order.SinglePassView.LeftCountTxt");
               _leftCountTxt.x = 465;
            }
         }
         NumberViewUtils.refreshValue(_leftCount,_leftCountPanel,_leftNumberBitmapData,16,19,12,16);
         var _loc2_:int = _model.maxIndex / 5;
         var _loc1_:int = (_loc2_ + 1) * 5;
         _bugleLeftCount = _loc2_ * _model.bugleCount - _model.itemCount;
         _hornHasNumTxt.text = _bugleLeftCount.toString();
         if(_bugleLeftCount > 0)
         {
            _loc7_ = (_model.maxIndex - 1) / 10 + 1;
            _loc9_ = _model.maxIndex % 10;
            if(_loc9_ == 0)
            {
               _loc9_ = 10;
            }
            _loc8_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.GetHornBtnTips01",SinglePassModel.FLOOR_STR[_loc7_],_loc9_,_bugleLeftCount);
         }
         else if(_model.maxIndex < 10 * 10)
         {
            _loc7_ = (_loc1_ - 1) / 10 + 1;
            _loc9_ = _loc1_ % 10;
            if(_loc9_ == 0)
            {
               _loc9_ = 10;
            }
            _loc8_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.GetHornBtnTips02",SinglePassModel.FLOOR_STR[_loc7_],_loc9_,_model.bugleCount);
         }
         else
         {
            _loc8_ = LanguageMgr.GetTranslation("singlepass.SinglePassView.GetHornBtnTips03");
         }
         _getHornBtn.tipData = _loc8_;
         var _loc6_:SinglePassTipData = new SinglePassTipData();
         _loc6_.type = 0;
         _loc6_.drops1 = TempleteManager.instance.singlePassAreaRewardTemplateCate.getAreaRewardByAreaId(_model.selectArea);
         _chapterRewardBtn1.tipData = _loc6_;
         _chapterRewardBtn2.tipData = _loc6_;
         cardTurnFunction();
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

