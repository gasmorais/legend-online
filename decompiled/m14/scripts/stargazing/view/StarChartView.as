package stargazing.view
{
   import bag.events.BagEvent;
   import com.pickgliss.loader.LoaderManagerII;
   import com.pickgliss.loader.data.LoaderInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedTextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.stargazing.StarChartInfo;
   import mvc.module.stargazing.StarGazingModel;
   import mvc.module.stargazing.StarGazingPropertyInfo;
   import mvc.module.stargazing.StarPalaceInfo;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.PathManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.StarGazingManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.HRollItemPanel;
   import yishi.view.base.StarGroupView;
   import yishi.view.tips.MessageTipManager;
   
   public class StarChartView extends Component
   {
      
      private var _starName:FilterFrameText;
      
      private var _liveText2:FilterFrameText;
      
      private var _magicDefenceText2:FilterFrameText;
      
      private var _magicAttackText2:FilterFrameText;
      
      private var _defenceText2:FilterFrameText;
      
      private var _attackText2:FilterFrameText;
      
      private var _liveText:FilterFrameText;
      
      private var _magicDefenceText:FilterFrameText;
      
      private var _magicAttackText:FilterFrameText;
      
      private var _defenceText:FilterFrameText;
      
      private var _attackText:FilterFrameText;
      
      private var _forceAddText:FilterFrameText;
      
      private var _pieceTitleText:FilterFrameText;
      
      private var _useItemBtn:BaseButton;
      
      private var _chartBack:MutipleImage;
      
      private var _leftView:StarPalaceView;
      
      private var _chartBorder:ScaleFrameImage;
      
      private var _chartContiner:Component;
      
      private var _chartImage:Bitmap;
      
      private var maskList:Vector.<Bitmap>;
      
      private var _chartPieceBtn:SelectedTextButton;
      
      private var _chartBtn:SelectedTextButton;
      
      private var _itemBtnGroup:SelectedButtonGroup;
      
      private var _chartGirdMc:MovieClip;
      
      private var _pagePanel:HRollItemPanel;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var btnList:Array;
      
      private var _starGroup:StarGroupView;
      
      private var _preTotalCount:int;
      
      private var chartPieceCount:int;
      
      private var chartCount:int;
      
      private var chartTempId:int;
      
      private var _index:int = -1;
      
      private var _palaceInfo:StarPalaceInfo;
      
      private var chartPieceTemp:GoodsTemplateInfo;
      
      private var chartTempInfo:GoodsTemplateInfo;
      
      private var refreshTimeId:int;
      
      public function StarChartView()
      {
         super();
         initView();
         initMaskView();
         initPageList();
         addEvent();
      }
      
      private function initView() : void
      {
         _starName = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.starName");
         _liveText2 = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.liveText2");
         _magicDefenceText2 = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.magicDefenceText2");
         _magicAttackText2 = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.magicAttackText2");
         _defenceText2 = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.defenceText2");
         _attackText2 = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.attackText2");
         _liveText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.liveText");
         _magicDefenceText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.magicDefenceText");
         _magicAttackText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.magicAttackText");
         _defenceText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.defenceText");
         _attackText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.attackText");
         _forceAddText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.forceAddText");
         _pieceTitleText = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.pieceTitleText");
         _useItemBtn = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.useItemBtn");
         _chartBack = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.chartBack");
         _leftView = ComponentFactory.Instance.creatCustomObject("StarGazing.StarChartView.leftView");
         _chartGirdMc = ComponentFactory.Instance.creatCustomObject("StarChartView.chartGirdMc");
         _chartBorder = ComponentFactory.Instance.creatComponentByStylename("StarChartView.chartBorder");
         _chartContiner = ComponentFactory.Instance.creatComponentByStylename("StarChartView.chartContiner");
         _chartPieceBtn = ComponentFactory.Instance.creatComponentByStylename("StarChartView.chartPieceBtn");
         _chartBtn = ComponentFactory.Instance.creatComponentByStylename("StarChartView.chartBtn");
         _pagePanel = new HRollItemPanel();
         _pagePanel.x = 255;
         _pagePanel.y = 338;
         _pagePanel.initParams("StarChartView.pageHbox","StarChartView.lastBtn","StarChartView.nextBtn",7,38,39,2);
         addChild(_leftView);
         addChild(_chartBack);
         addChild(_chartBorder);
         _chartBorder.setFrame(1);
         addChild(_chartContiner);
         addChild(_chartGirdMc);
         addChild(_starName);
         addChild(_pagePanel);
         addChild(_chartPieceBtn);
         addChild(_chartBtn);
         addChild(_useItemBtn);
         addChild(_attackText);
         addChild(_defenceText);
         addChild(_magicAttackText);
         addChild(_magicDefenceText);
         addChild(_liveText);
         addChild(_pieceTitleText);
         addChild(_attackText2);
         addChild(_defenceText2);
         addChild(_magicAttackText2);
         addChild(_magicDefenceText2);
         addChild(_liveText2);
         _chartGirdMc.mouseChildren = _chartGirdMc.mouseEnabled = false;
         _chartGirdMc.gotoAndStop(1);
         _chartGirdMc.visible = false;
         _itemBtnGroup = new SelectedButtonGroup();
         _itemBtnGroup.addSelectItem(_chartPieceBtn);
         _itemBtnGroup.addSelectItem(_chartBtn);
         _itemBtnGroup.selectIndex = 0;
         _pieceTitleText.htmlText = LanguageMgr.GetTranslation("StarGazing.StarChartView.pieceTitleText.text");
      }
      
      private function initMaskView() : void
      {
         var _loc3_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:Shape = null;
         maskList = new Vector.<Bitmap>();
         _loc3_ = 0;
         while(_loc3_ < 9)
         {
            _loc4_ = ComponentFactory.Instance.creatBitmap("asset.StarGazing.StarChartView.mask" + _loc3_);
            _loc1_ = 72 * (_loc3_ % 3);
            _loc2_ = 67 * (int(_loc3_ / 3));
            _loc5_ = new Shape();
            _loc5_.graphics.beginFill(16711680);
            _loc5_.graphics.drawRect(_loc1_,_loc2_,72,67);
            _loc5_.graphics.endFill();
            _loc4_.mask = _loc5_;
            maskList.push(_loc4_);
            _loc4_.x = _loc1_;
            _loc4_.y = _loc2_;
            _chartContiner.addChild(_loc4_);
            _chartContiner.addChild(_loc5_);
            _loc3_++;
         }
      }
      
      private function initPageList() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SelectedButton = null;
         _btnGroup = new SelectedButtonGroup();
         btnList = [];
         _loc2_ = 1;
         while(_loc2_ <= 12)
         {
            _loc1_ = ComponentFactory.Instance.creatComponentByStylename("StarGazing.StarChartView.pageBtn" + _loc2_);
            _btnGroup.addSelectItem(_loc1_);
            btnList.push(_loc1_);
            _loc2_++;
         }
         _pagePanel.updateList(btnList);
         _btnGroup.selectIndex = 0;
      }
      
      private function addEvent() : void
      {
         _useItemBtn.addEventListener("click",_useItemBtnClickHandler);
         _btnGroup.addEventListener("change",__pageTabChangeHandler);
         MsgMan.addObserver("SELECT_STAR_INDEX_CHANGE",this,__updateSelectStarHandler);
         MsgMan.addObserver("STAR_CHART_PIECE_CHANGE",this,__updatePieceViewHandler);
         MsgMan.addObserver("STAR_VIEW_DATA_CHANGE",this,__starViewChangeHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
      }
      
      private function removeEvent() : void
      {
         if(_useItemBtn)
         {
            _useItemBtn.removeEventListener("click",_useItemBtnClickHandler);
         }
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__pageTabChangeHandler);
         }
         MsgMan.removeObserver("SELECT_STAR_INDEX_CHANGE",this,__updateSelectStarHandler);
         MsgMan.removeObserver("STAR_CHART_PIECE_CHANGE",this,__updatePieceViewHandler);
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
      
      private function _useItemBtnClickHandler(param1:MouseEvent) : void
      {
         var isAllOpen:Boolean;
         var checkTxt:String;
         var content:String;
         var e:MouseEvent = param1;
         var selectCount:int = _itemBtnGroup.selectIndex == 0 ? chartPieceCount : chartCount;
         var tempId:int = _itemBtnGroup.selectIndex == 0 ? 8001015 : chartTempId;
         if(_itemBtnGroup.selectIndex == 0)
         {
            isAllOpen = Boolean(model.palaceAllOpen);
         }
         else
         {
            isAllOpen = Boolean(_palaceInfo ? _palaceInfo.chartAllOpen : false);
         }
         if(selectCount <= 0)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("StarWishView.wishBtn.noCpupon"));
            return;
         }
         if(isAllOpen)
         {
            checkTxt = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            content = LanguageMgr.GetTranslation("StarWishView.useItem.hasFull.toPieceAlert");
            SharedManagerHelper.ins.needAlert("StarWishView.useItem.alert",function():void
            {
               StarGazingManager.instance.sendStarGazingChartUseItem(tempId);
            },checkTxt,content);
         }
         else
         {
            StarGazingManager.instance.sendStarGazingChartUseItem(tempId);
         }
      }
      
      private function __pageTabChangeHandler(param1:Event) : void
      {
         loadNewChartImage();
         refreshView();
      }
      
      private function __updateSelectStarHandler(param1:String, param2:Object) : void
      {
         index = model.selectStarIndex;
      }
      
      private function __starViewChangeHandler(param1:String, param2:Object) : void
      {
         refreshView();
      }
      
      private function __updatePieceViewHandler(param1:String, param2:Object) : void
      {
         var _loc4_:Object = param2;
         if(!_loc4_ || _loc4_.index != index)
         {
            refreshView();
            return;
         }
         _btnGroup.selectIndex = _loc4_.mapIndex;
         _pagePanel.skip(_btnGroup.selectIndex);
         refreshView();
         var _loc3_:int = int(_loc4_.fragmentIndex);
         var _loc5_:Bitmap = maskList[_loc3_];
         _chartGirdMc.x = 432 + _loc5_.x;
         _chartGirdMc.y = -168 + _loc5_.y;
         _chartGirdMc.visible = true;
         _chartGirdMc.gotoAndPlay(1);
         _chartGirdMc.addFrameScript(_chartGirdMc.totalFrames - 1,_chartGirdMcPlayOver);
      }
      
      public function _chartGirdMcPlayOver() : void
      {
         _chartGirdMc.visible = false;
         _chartGirdMc.gotoAndStop(1);
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
         loadNewChartImage();
         refreshView();
      }
      
      private function loadNewChartImage() : void
      {
         ObjectUtils.disposeObject(_chartImage);
         _chartImage = null;
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onChartLoaded);
         var _loc1_:String = PathManager.getStarGazingChartUrl(index,_btnGroup.selectIndex);
         LoaderManagerII.instance.load(_loc1_,2,8,__onChartLoaded);
      }
      
      private function __onChartLoaded(param1:LoaderInfo, param2:Object) : void
      {
         if(isDie)
         {
            return;
         }
         if(param2)
         {
            _chartImage = param2 as Bitmap;
            _chartContiner.addChildAt(_chartImage,0);
         }
      }
      
      private function refreshView() : void
      {
         _palaceInfo = model.getPalaceInfoByIndex(index);
         _starName.text = LanguageMgr.GetTranslation("stargazing.starName.text" + index);
         _attackText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text5") + " " + model.starChartTotalProperty.attack;
         _defenceText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text6") + " " + model.starChartTotalProperty.defence;
         _magicAttackText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text7") + " " + model.starChartTotalProperty.magicAttack;
         _magicDefenceText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text8") + " " + model.starChartTotalProperty.magicDefence;
         _liveText.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text9") + " " + model.starChartTotalProperty.live;
         var _loc5_:int = int(_palaceInfo ? _palaceInfo.addPrecent : 0);
         var _loc1_:StarGazingPropertyInfo = _palaceInfo ? _palaceInfo.getChartAddByIndex(_btnGroup.selectIndex) : null;
         var _loc4_:int = int(_loc1_ ? _loc1_.attack : 0);
         var _loc3_:int = int(_loc1_ ? _loc1_.defence : 0);
         var _loc2_:int = int(_loc1_ ? _loc1_.magicAttack : 0);
         var _loc7_:int = int(_loc1_ ? _loc1_.magicDefence : 0);
         var _loc6_:int = int(_loc1_ ? _loc1_.live : 0);
         _attackText2.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text0",_loc4_,_loc5_);
         _defenceText2.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text1",_loc3_,_loc5_);
         _magicAttackText2.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text2",_loc2_,_loc5_);
         _magicDefenceText2.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text3",_loc7_,_loc5_);
         _liveText2.htmlText = LanguageMgr.GetTranslation("stargazing.starPropAdd.text4",_loc6_,_loc5_);
         refreshBagCount();
         refreshMaskView();
         refreshStarView();
      }
      
      private function refreshBagCount() : void
      {
         chartPieceTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(8001015);
         chartPieceCount = GoodsManager.instance.getBagCountInPlayerAndStoneByTempId(8001015);
         _chartPieceBtn.text = chartPieceTemp.TemplateName + ":" + chartPieceCount;
         chartTempInfo = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonTypeAndProperty1(801,index);
         chartTempId = chartTempInfo.TemplateId;
         chartCount = GoodsManager.instance.getGoodsNumInAllBySonTypeAndPorp1(801,index);
         _chartBtn.text = chartTempInfo.TemplateName + ":" + chartCount;
         _chartPieceBtn.tipData = chartPieceTemp.Description;
         _chartBtn.tipData = chartTempInfo.Description;
      }
      
      private function refreshStarView() : void
      {
         var _loc2_:int = int(_palaceInfo ? _palaceInfo.timeCount : 0);
         var _loc1_:StarChartInfo = _palaceInfo ? _palaceInfo.getChartInfoByIndex(_btnGroup.selectIndex) : null;
         var _loc3_:int = int(_loc1_ ? _loc1_.repeatTimes : 0);
         if(_preTotalCount == _loc2_)
         {
            if(_starGroup)
            {
               _starGroup.setStars(_loc3_);
            }
            _chartBorder.setFrame(_loc3_ + 1);
            return;
         }
         _preTotalCount = _loc2_;
         ObjectUtils.disposeObject(_starGroup);
         _starGroup = null;
         _starGroup = new StarGroupView();
         _starGroup.initParams("asset.stargazing.grayStar",26,"asset.stargazing.lightStar",26,_loc2_);
         _starGroup.x = 335 + (5 - _loc2_) * 10;
         _starGroup.y = 285;
         _starGroup.setStars(_loc3_);
         addChild(_starGroup);
         _chartBorder.setFrame(_loc3_ + 1);
      }
      
      private function refreshMaskView() : void
      {
         var _loc2_:int = 0;
         var _loc4_:Bitmap = null;
         var _loc1_:StarChartInfo = _palaceInfo ? _palaceInfo.getChartInfoByIndex(_btnGroup.selectIndex) : null;
         var _loc3_:Array = _loc1_ ? _loc1_.fragmentChar.split(",") : [];
         _loc2_ = 0;
         while(_loc2_ < maskList.length)
         {
            _loc4_ = maskList[_loc2_];
            _loc4_.x = 72 * (_loc2_ % 3);
            _loc4_.y = 67 * (int(_loc2_ / 3));
            if(_loc3_.indexOf(_loc2_ + "") != -1)
            {
               _loc4_.visible = false;
            }
            else
            {
               _loc4_.visible = true;
            }
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
         LoaderManagerII.instance.clearLoaderInfoByCompleteFunction(__onChartLoaded);
         ObjectUtils.disposeObject(_starName);
         _starName = null;
         ObjectUtils.disposeObject(_liveText2);
         _liveText2 = null;
         ObjectUtils.disposeObject(_magicDefenceText2);
         _magicDefenceText2 = null;
         ObjectUtils.disposeObject(_magicAttackText2);
         _magicAttackText2 = null;
         ObjectUtils.disposeObject(_defenceText2);
         _defenceText2 = null;
         ObjectUtils.disposeObject(_attackText2);
         _attackText2 = null;
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
         ObjectUtils.disposeObject(_forceAddText);
         _forceAddText = null;
         ObjectUtils.disposeObject(_pieceTitleText);
         _pieceTitleText = null;
         ObjectUtils.disposeObject(_useItemBtn);
         _useItemBtn = null;
         ObjectUtils.disposeObject(_chartBack);
         _chartBack = null;
         ObjectUtils.disposeObject(_leftView);
         _leftView = null;
         ObjectUtils.disposeObject(_chartPieceBtn);
         _chartPieceBtn = null;
         ObjectUtils.disposeObject(_chartBtn);
         _chartBtn = null;
         ObjectUtils.disposeObject(_pagePanel);
         _pagePanel = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_chartContiner);
         _chartContiner = null;
         ObjectUtils.disposeObject(_chartImage);
         _chartImage = null;
         ObjectUtils.disposeObject(_chartBorder);
         _chartBorder = null;
         ObjectUtils.disposeViolentMc(_chartGirdMc);
         _chartGirdMc = null;
         LogicUtils.disposeDisplayCollection(maskList);
         maskList = null;
         LogicUtils.disposeDisplayCollection(btnList);
         btnList = null;
         ObjectUtils.disposeObject(_starGroup);
         _starGroup = null;
         super.dispose();
      }
   }
}

