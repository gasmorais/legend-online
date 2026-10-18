package theseusCollention.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.utils.getTimer;
   import manager.LanguageMgr;
   import managers.PlayerCurrencyManager;
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseusCollenTionModel;
   import theseusCollention.item.TheseusBoxItem;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.CommonDropTempInfo;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.MsgMan;
   import yishi.view.base.ProgressPanel;
   import yishi.view.community.BaseItemView;
   
   public class TheseusBoxView extends Sprite
   {
      
      private static const MAX_SUCCESS_COUNT:int = 10;
      
      private var _clickTime:int = 0;
      
      private var _itemList:Array;
      
      private var _btnVbox:VBox;
      
      private var itemList:Vector.<TheseusBoxItem>;
      
      private var curPageData:Array;
      
      private var _openBtn1:IconButton;
      
      private var _openBtn2:IconButton;
      
      private var _bossNameBgImage2:Image;
      
      private var _bossNameTxt:GradientText;
      
      private var _bossNameBgImage:Image;
      
      private var _curPlayMc:MovieClip;
      
      private var _bossHp:ProgressPanel;
      
      private var _openNum:int;
      
      private var _box:ScaleFrameImage;
      
      private var _gotobox:ScaleFrameImage;
      
      private var _boxTxt:FilterFrameText;
      
      private var _bg:Bitmap;
      
      private var _probg:Bitmap;
      
      protected var _preTxt:FilterFrameText;
      
      protected var _numTxt:FilterFrameText;
      
      protected var _previewTxt:FilterFrameText;
      
      protected var _probabilityTxt:FilterFrameText;
      
      private var _scrollPanel:ScrollPanel;
      
      private var _goodsListView:Sprite;
      
      private var _bottleFrameBg3:ScaleBitmapImage;
      
      private var _TitleBack1:MutipleImage;
      
      private var _TitleBack2:MutipleImage;
      
      protected var _leftbg:Bitmap;
      
      protected var _mc:MovieClip;
      
      protected var _probabilityDescTxt:FilterFrameText;
      
      public function TheseusBoxView()
      {
         super();
         initView();
         initListView();
         addEvent();
      }
      
      private function initView() : void
      {
         _leftbg = ComponentFactory.Instance.creatBitmap("theseusCollection_leftBg2");
         addChild(_leftbg);
         _bg = ComponentFactory.Instance.creatBitmap("theseusCollection_WoodenBottom");
         _bottleFrameBg3 = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.BottleFrameBack3");
         _btnVbox = ComponentFactory.Instance.creatComponentByStylename("theseusCollention.box.itemVbox");
         _box = ComponentFactory.Instance.creatComponentByStylename("theseuscollection.buyResultMcbox");
         _bossNameTxt = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameTxt1");
         _bossNameBgImage = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameBgImage1");
         _bossNameBgImage2 = ComponentFactory.Instance.creatComponentByStylename("newboss.ConsortiaNewBossFrame.bossNameBgImage21");
         _probg = ComponentFactory.Instance.creatBitmap("asset.theseuscollection.mobilebg2");
         _preTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.proTxt");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.numTxt");
         _previewTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.previewTxt");
         _probabilityTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.probabilityTxt");
         _probabilityDescTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.probabilityDescTxt");
         _boxTxt = ComponentFactory.Instance.creatComponentByStylename("ui.TheseusCollentionBox.boxTxt");
         _openBtn1 = ComponentFactory.Instance.creatComponentByStylename("platinum.openBtn11");
         _openBtn2 = ComponentFactory.Instance.creatComponentByStylename("platinum.openBtn21");
         _gotobox = ComponentFactory.Instance.creatComponentByStylename("theseusbox.icon1");
         _bossHp = ComponentFactory.Instance.creatCustomObject("ui.TheseusBoxView.bossHp");
         _bossHp.initView("asset.theseusCollection.percentBg","asset.theseusCollection.percent","TheseusBoxView.percent");
         _scrollPanel = ComponentFactory.Instance.creatComponentByStylename("theseuscollection.BottleDropScrollPanel");
         _TitleBack1 = ComponentFactory.Instance.creatComponentByStylename("theseusboxview.TitleBack1");
         _TitleBack2 = ComponentFactory.Instance.creatComponentByStylename("theseusboxview.TitleBack2");
         _mc = ComponentFactory.Instance.creatCustomObject("theseuscollection.HasOperEffect1");
         _mc.visible = false;
         _mc.box.gotoAndStop(1);
         _gotobox.x = 675;
         _gotobox.y = -5;
         _gotobox.filters = [UIFilter.getGrayFilter()];
         addChild(_bg);
         addChild(_bottleFrameBg3);
         addChild(_TitleBack1);
         addChild(_TitleBack2);
         addChild(_probg);
         addChild(_bossHp);
         addChild(_gotobox);
         addChild(_preTxt);
         addChild(_numTxt);
         addChild(_scrollPanel);
         addChild(_mc);
         addChild(_previewTxt);
         addChild(_probabilityTxt);
         addChild(_probabilityDescTxt);
         _previewTxt.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.boxtext3");
         _probabilityTxt.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.boxtext4");
         addChild(_bossNameBgImage2);
         addChild(_bossNameTxt);
         addChild(_openBtn1);
         addChild(_openBtn2);
         addChild(_box);
         _gotobox.setFrame(1);
         _box.setFrame(1);
         _boxTxt.text = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.boxtext5");
         addChild(_boxTxt);
      }
      
      private function addEvent() : void
      {
         TheseussoulManager.Instance.addEventListener("THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK",__updatBuyResultHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_COLLECTION_UPDATE",refreshprogressView);
         NotificationManager.instance.addEventListener("CURRENCYREFRESH",refreshprogressView);
         MsgMan.addObserver("SELECT_TheseusBOX_CHANGE",this,__selectFormulaItemHandler);
         _openBtn1.addEventListener("click",__openBottleHandler);
         _openBtn2.addEventListener("click",__openBottleHandler);
         _mc.addEventListener("click",__gotoBoxHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 212,refreshView);
      }
      
      private function initListView() : void
      {
         var _loc4_:GoodsInfo = null;
         var _loc2_:int = 0;
         var _loc1_:TheseusBoxItem = null;
         var _loc3_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         _loc3_.sortOn("TemplateId",2);
         itemList = new Vector.<TheseusBoxItem>();
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            _loc1_ = new TheseusBoxItem(_loc2_);
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = _loc3_[_loc2_].TemplateId;
            _loc4_.count = model.boxBagDic[_loc3_[_loc2_].TemplateId] ? model.boxBagDic[_loc3_[_loc2_].TemplateId].count : 0;
            if(_loc2_ == 0)
            {
               model.selectBox = _loc4_;
            }
            _loc1_.data = _loc4_;
            _btnVbox.addChild(_loc1_);
            itemList.push(_loc1_);
            _loc2_++;
         }
         _btnVbox.commitChanges();
         addChild(_btnVbox);
         __selectFormulaItemHandler();
         refreshGoodsListView();
         refreshprogressView();
      }
      
      private function refreshprogressView(param1:Object = null) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = int(PlayerCurrencyManager.instance.currencyInfo.theseuscollectionBox.amount);
         var _loc2_:int = model.boxProcess - _loc4_ >= 0 ? model.boxProcess - _loc4_ : 0;
         var _loc3_:CommonDropTempInfo = TempleteManager.instance.collectionGetDrop.getDropGood(model.boxDropId);
         var _loc6_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         _boxTxt.visible = _loc2_ == 0;
         _preTxt.visible = _loc2_ != 0;
         _mc.visible = false;
         if(!_loc3_)
         {
            return;
         }
         if(_loc2_ != 0)
         {
            _gotobox.filters = [UIFilter.getGrayFilter()];
            _gotobox.visible = true;
         }
         else
         {
            _gotobox.visible = false;
         }
         _loc5_ = 0;
         while(_loc5_ < _loc6_.length)
         {
            if(_loc6_[_loc5_].Property1 == _loc3_.itemId)
            {
               _gotobox.setFrame(_loc5_ + 1);
               if(_loc2_ == 0)
               {
                  _mc.visible = true;
                  _mc.box.gotoAndStop(_loc3_.itemId - 3500);
               }
               _preTxt.htmlText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.boxtext1",_loc2_,_loc6_[_loc5_].TemplateName);
            }
            _loc5_++;
         }
         _bossHp.progressValue(_loc4_,model.boxProcess);
      }
      
      private function refreshGoodsListView() : void
      {
         var _loc1_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(_goodsListView)
         {
            ObjectUtils.disposeObject(_goodsListView);
         }
         _goodsListView = null;
         for each(_loc1_ in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         _itemList = [];
         _goodsListView = new Sprite();
         var _loc4_:Array = [];
         var _loc3_:Array = TempleteManager.instance.collectionOpenDrop.getDropitemGoods(model.selectBox.templateInfo.Property1);
         for each(var _loc2_:CommonDropTempInfo in _loc3_)
         {
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc2_.itemId;
            _loc7_.count = _loc2_.count;
            if(_loc7_.templateInfo)
            {
               _loc4_.push(_loc7_);
            }
         }
         _loc6_ = Math.ceil(_loc4_.length / 4);
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("theseuscollection.getItem1");
            _loc1_.x = 16 + _loc5_ % 4 * (_loc1_.displayWidth + 5);
            _loc1_.y = int(_loc5_ / 4) * (_loc1_.displayHeight + 5);
            _loc1_.data = _loc4_[_loc5_];
            _goodsListView.addChild(_loc1_);
            _itemList.push(_loc1_);
            _loc5_++;
         }
         if(_loc6_ > 0)
         {
            _goodsListView.scrollRect = new Rectangle(0,0,300,_loc6_ * (_loc1_.displayHeight + 5));
         }
         _scrollPanel.setView(_goodsListView);
      }
      
      private function get model() : TheseusCollenTionModel
      {
         return TheseussoulManager.Instance.modelCollenTion;
      }
      
      private function refreshView(param1:Object = null) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc2_:TheseusBoxItem = null;
         var _loc3_:int = 0;
         var _loc4_:Array = TempleteManager.instance.goodsTemplateCate.getGoodsTemplatesBySonType(350);
         _loc4_.sortOn("TemplateId",2);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            _loc2_ = itemList[_loc3_];
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _loc4_[_loc3_].TemplateId;
            _loc5_.count = model.boxBagDic[_loc4_[_loc3_].TemplateId] ? model.boxBagDic[_loc4_[_loc3_].TemplateId].count : 0;
            if(_loc5_.templateId == model.selectBox.templateId)
            {
               model.selectBox.count = _loc5_.count;
            }
            _loc2_.data = _loc5_;
            _loc3_++;
         }
         __selectFormulaItemHandler();
         refreshGoodsListView();
         refreshprogressView();
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("SELECT_TheseusBOX_CHANGE",this,__selectFormulaItemHandler);
         _openBtn1.removeEventListener("click",__openBottleHandler);
         _openBtn2.removeEventListener("click",__openBottleHandler);
         _mc.removeEventListener("click",__gotoBoxHandler);
         TheseussoulManager.Instance.removeEventListener("THESEUSCOLLECTIONBOXEXCHANGE_BUY_BACK",__updatBuyResultHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 212,refreshView);
         TheseussoulManager.Instance.removeEventListener("EVENT_COLLECTION_UPDATE",refreshprogressView);
         NotificationManager.instance.removeEventListener("CURRENCYREFRESH",refreshprogressView);
      }
      
      private function __gotoBoxHandler(param1:MouseEvent) : void
      {
         if(getTimer() - _clickTime < 500)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         TheseussoulManager.Instance.doCollectionthing(3);
      }
      
      private function __openBottleHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(getTimer() - _clickTime < 1000)
         {
            return;
         }
         _clickTime = getTimer();
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _openBtn1:
               _openNum = 1;
               break;
            case _openBtn2:
               _openNum = 10;
         }
         TheseussoulManager.Instance.doCollectionthing(4,model.selectBox.templateId,_openNum);
      }
      
      private function __updatBuyResultHandler(param1:NotificationEvent) : void
      {
         var id:int;
         var count:int;
         var item:BaseItemView;
         var gInfo:GoodsInfo;
         var speedMultiplier:Number;
         var e:NotificationEvent = param1;
         var fastPlayHandler:* = function(param1:Event):void
         {
            var _loc2_:MovieClip = param1.currentTarget as MovieClip;
            var _loc3_:uint = _loc2_.currentFrame + speedMultiplier;
            if(_loc3_ == 36 || _loc3_ == 37 || _loc3_ == 38)
            {
               if(showList.length > 1)
               {
                  showItemFrame(showList);
               }
            }
            if(_loc3_ >= _loc2_.totalFrames)
            {
               _loc2_.gotoAndStop(_loc2_.totalFrames);
               _loc2_.removeEventListener("enterFrame",fastPlayHandler);
               setViewState(true);
               ObjectUtils.disposeViolentMc(_curPlayMc);
               _curPlayMc = null;
               return;
            }
            _loc2_.gotoAndStop(_loc3_);
         };
         var body:Object = e.data;
         var showList:Array = body.list;
         if(_curPlayMc)
         {
            ObjectUtils.disposeViolentMc(_curPlayMc);
         }
         _curPlayMc = null;
         setViewState(false);
         id = int(model.selectBoxindex);
         count = showList.length == 1 ? 0 : 1;
         _curPlayMc = ComponentFactory.Instance.creatCustomObject("theseuscollection.buyResultMc" + id + "_" + count);
         addChild(_curPlayMc);
         if(showList.length == 1)
         {
            item = ComponentFactory.Instance.creatCustomObject("theseuscollection.getItem1");
            gInfo = new GoodsInfo();
            gInfo.templateId = showList[0].itemId;
            gInfo.count = showList[0].num;
            item.data = gInfo;
            _curPlayMc.gotoAndStop(1);
            _curPlayMc["showGoods0"]["goodItem"].removeChildAt(0);
            _curPlayMc["showGoods0"]["goodItem"].addChild(item);
            _curPlayMc["showGoods0"]["effect"].visible = false;
         }
         speedMultiplier = 3;
         _curPlayMc.stop();
         _curPlayMc.addEventListener("enterFrame",fastPlayHandler);
      }
      
      public function showItemFrame(param1:Array) : void
      {
         var _loc2_:TheseusCollectShowBoxFrame = ComponentFactory.Instance.creatComponentByStylename("theseusCollention.view.TheseusCollectShowBoxFrame",[param1]);
         _loc2_.show();
      }
      
      private function setViewState(param1:Boolean) : void
      {
         if(_box)
         {
            _box.visible = param1;
            _openBtn1.enable = param1;
            _openBtn2.enable = param1;
            if(param1)
            {
               _openBtn1.enable = model.selectBox.count >= 1;
               _openBtn2.enable = model.selectBox.count >= 10;
            }
         }
      }
      
      private function refreshItem() : void
      {
      }
      
      private function __selectFormulaItemHandler(param1:String = "", param2:Object = null) : void
      {
         var _loc4_:int = 0;
         var _loc3_:TheseusBoxItem = null;
         _loc4_ = 0;
         while(_loc4_ < 5)
         {
            _loc3_ = itemList[_loc4_];
            if(_loc3_.data && model.selectBox && _loc3_.data.templateId == model.selectBox.templateId)
            {
               _loc3_.select = true;
               _box.setFrame(_loc4_ + 1);
               switch(_loc4_)
               {
                  case 0:
                     _box.x = 200;
                     _box.y = 190;
                     break;
                  case 1:
                     _box.x = 225;
                     _box.y = 190;
                     break;
                  case 2:
                     _box.x = 235;
                     _box.y = 195;
                     break;
                  case 3:
                     _box.x = 235;
                     _box.y = 195;
                     break;
                  case 4:
                     _box.x = 235;
                     _box.y = 195;
               }
               model.selectBoxindex = 1 + _loc4_;
            }
            else
            {
               _loc3_.select = false;
            }
            _loc4_++;
         }
         refreshGoodsListView();
         _openBtn1.enable = model.selectBox.count >= 1;
         _openBtn2.enable = model.selectBox.count >= 10;
         _bossNameTxt.text = model.selectBox.templateInfo.TemplateName;
         _numTxt.htmlText = LanguageMgr.GetTranslation("TheseusCollenedBigItemUI.boxtext2",model.selectBox.count);
         _probabilityDescTxt.htmlText = model.selectBox.templateInfo.Description;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_leftbg);
         _leftbg = null;
         if(_mc)
         {
            ObjectUtils.disposeObject(_mc);
         }
         _mc = null;
         ObjectUtils.disposeObject(_probabilityDescTxt);
         _probabilityDescTxt = null;
         ObjectUtils.disposeObject(_bossNameTxt);
         _bossNameTxt = null;
         ObjectUtils.disposeObject(_openBtn1);
         _openBtn1 = null;
         ObjectUtils.disposeObject(_openBtn2);
         _openBtn2 = null;
         ObjectUtils.disposeObject(_bossNameBgImage2);
         _bossNameBgImage2 = null;
         ObjectUtils.disposeObject(_bossNameBgImage);
         _bossNameBgImage = null;
         ObjectUtils.disposeObject(_bossHp);
         _bossHp = null;
         ObjectUtils.disposeObject(_box);
         _box = null;
         ObjectUtils.disposeObject(_gotobox);
         _gotobox = null;
         ObjectUtils.disposeObject(_boxTxt);
         _boxTxt = null;
         ObjectUtils.disposeObject(_preTxt);
         _preTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_previewTxt);
         _previewTxt = null;
         ObjectUtils.disposeObject(_probabilityTxt);
         _probabilityTxt = null;
         ObjectUtils.removeChildAllChildren(_goodsListView);
         _goodsListView = null;
         ObjectUtils.disposeObject(_bottleFrameBg3);
         _bottleFrameBg3 = null;
         ObjectUtils.disposeObject(_TitleBack1);
         _TitleBack1 = null;
         ObjectUtils.disposeObject(_TitleBack2);
         _TitleBack2 = null;
         ObjectUtils.disposeObject(_scrollPanel);
         _scrollPanel = null;
         if(_curPlayMc)
         {
            _curPlayMc.stop();
            _curPlayMc.addFrameScript(_curPlayMc.totalFrames - 1,null);
            ObjectUtils.disposeViolentMc(_curPlayMc);
            _curPlayMc = null;
         }
         for each(var _loc1_:BaseItemView in _itemList)
         {
            ObjectUtils.disposeObject(_loc1_);
            _loc1_ = null;
         }
         curPageData = null;
         ObjectUtils.disposeObject(_btnVbox);
         _btnVbox = null;
         LogicUtils.disposeDisplayCollection(itemList);
         itemList = null;
      }
   }
}

