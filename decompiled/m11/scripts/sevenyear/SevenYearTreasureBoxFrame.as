package sevenyear
{
   import bag.datas.GoodsSonType;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.module.TreasureBoxMsg;
   import events.SevenYearEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.clearTimeout;
   import manager.LanguageMgr;
   import managers.SevenYearManager;
   import managers.ShopManager;
   import mvc.module.sevenyear.SevenYearModel;
   import mvc.module.shop.ShopGoodsInfo;
   import sevenyear.view.item.SevenYearTreasureBoxItem;
   import utils.LogicUtils;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.PlayerInfo;
   import yishi.datas.templates.SevenYearTreasureBoxDropTemplate;
   import yishi.manager.PlayerManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.CheckUIModuleUtil;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.giftdonatio.GiftDonatioFrame;
   
   public class SevenYearTreasureBoxFrame extends Frame
   {
      
      private var _border:ScaleBitmapImage;
      
      private var _bg:Bitmap;
      
      private var _boxBack:ScaleFrameImage;
      
      private var _sprite1:Sprite;
      
      private var _sprite2:Sprite;
      
      private var _itemView:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _descTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      private var _flagBmp:ScaleFrameImage;
      
      private var _needGradeText:FilterFrameText;
      
      private var _buyGradeBtn:TextButton;
      
      private var _buyImg:MutipleImage;
      
      private var _numTxt:FilterFrameText;
      
      private var _plusBtn:IconButton;
      
      private var _minusBtn:IconButton;
      
      private var _pointTxt:FilterFrameText;
      
      private var _buyBtn:TextButton;
      
      private var _giftBtn:TextButton;
      
      private var _ownBmp:Bitmap;
      
      private var _ownTxt:FilterFrameText;
      
      private var _openBtn:IconButton;
      
      private var _openTxt:FilterFrameText;
      
      private var _openDescTxt:FilterFrameText;
      
      private var _startBtn:IconButton;
      
      private var _againBtn:IconButton;
      
      private var _cannelBtn:IconButton;
      
      private var _itemList:Array = [];
      
      public var totalPrice:int;
      
      public var buyNum:int = 0;
      
      private var openList:Array = [];
      
      private var count:int = 0;
      
      private var _data:ShopGoodsInfo;
      
      private var _turnControl:SevenYearTreasureBoxTurnControl;
      
      private var _residueList:Array = [];
      
      private var _veryxiyouItem:SevenYearTreasureBoxItem;
      
      private var _veryxiyouTime:int = 0;
      
      private var _veryxiyouTemp:SevenYearTreasureBoxDropTemplate;
      
      private var _xiyouItem:SevenYearTreasureBoxItem;
      
      private var _xiyouTime:int = 0;
      
      private var _xiyouTemp:SevenYearTreasureBoxDropTemplate;
      
      private var _isPlaying:Boolean = false;
      
      private var _goodsName:String = "";
      
      private var _index:int = 0;
      
      public function SevenYearTreasureBoxFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _border = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.border");
         _bg = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFrame.bg");
         _boxBack = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.boxBack");
         _itemView = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxFrame.itemView");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.nameTxt");
         _descTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.descTxt");
         _txt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.txt");
         _flagBmp = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.flagBmp");
         _buyGradeBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.buyGradeBtn");
         _buyImg = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.buyImg");
         _numTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.numTxt");
         _plusBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.plusBtn");
         _minusBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.minusBtn");
         _pointTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.pointTxt");
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.buyBtn");
         _giftBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.giftBtn");
         _ownBmp = ComponentFactory.Instance.creatBitmap("asset.SevenYearTreasureBoxFrame.ownBmp");
         _ownTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.ownTxt");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.openBtn");
         _openTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.openTxt");
         _openDescTxt = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.openDescTxt");
         _startBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.startBtn");
         _againBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.againBtn");
         _cannelBtn = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.cannelBtn");
         _needGradeText = ComponentFactory.Instance.creatComponentByStylename("SevenYearTreasureBoxFrame.needGradeText");
         _sprite1 = new Sprite();
         _sprite2 = new Sprite();
         addToContent(_border);
         addToContent(_bg);
         addToContent(_boxBack);
         _boxBack.setFrame(1);
         addToContent(_sprite2);
         addToContent(_sprite1);
         _sprite1.addChild(_itemView);
         _sprite1.addChild(_nameTxt);
         _sprite1.addChild(_descTxt);
         _sprite1.addChild(_txt);
         _sprite1.addChild(_flagBmp);
         _sprite1.addChild(_needGradeText);
         _sprite1.addChild(_buyGradeBtn);
         _sprite1.addChild(_buyImg);
         _sprite1.addChild(_numTxt);
         _sprite1.addChild(_plusBtn);
         _sprite1.addChild(_minusBtn);
         _sprite1.addChild(_pointTxt);
         _sprite1.addChild(_buyBtn);
         _sprite1.addChild(_ownBmp);
         _sprite1.addChild(_ownTxt);
         _sprite1.addChild(_openBtn);
         _sprite2.addChild(_openTxt);
         _sprite2.addChild(_openDescTxt);
         _sprite2.addChild(_againBtn);
         _sprite2.addChild(_startBtn);
         _sprite2.addChild(_cannelBtn);
         _sprite2.visible = false;
         _txt.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.txt.text");
         _buyGradeBtn.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.buyGradeBtn.text");
         _buyBtn.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.buyBtn.text");
         _giftBtn.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.giftBtn.text");
         _openTxt.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openTxt.text");
         _openDescTxt.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openDescTxt.text");
      }
      
      private function initItem() : void
      {
         var _loc1_:SevenYearTreasureBoxDropTemplate = null;
         var _loc2_:SevenYearTreasureBoxItem = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc6_:Array = getTemplateById;
         var _loc7_:int = 4;
         _loc4_ = 0;
         while(_loc4_ < _loc6_.length)
         {
            _loc1_ = _loc6_[_loc4_];
            if(_loc1_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxFrame.item");
               _loc2_.data = _loc1_;
               _loc2_.x = 12 + 136 * (int(_loc4_ % _loc7_));
               _loc2_.y = 185 + 172 * (int(_loc4_ / _loc7_));
               addToContent(_loc2_);
               _itemList.push(_loc2_);
            }
            _loc4_++;
         }
         _xiyouItem = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxFrame.item");
         _xiyouItem.data = _xiyouTemp;
         _xiyouItem.x = 560;
         _xiyouItem.y = 281;
         addToContent(_xiyouItem);
         _veryxiyouItem = ComponentFactory.Instance.creatCustomObject("SevenYearTreasureBoxFrame.item");
         _veryxiyouItem.data = _veryxiyouTemp;
         _veryxiyouItem.x = 560;
         _veryxiyouItem.y = 10;
         addToContent(_veryxiyouItem);
         _residueList = _residueList.concat(_itemList);
         loop1:
         for each(var _loc5_:int in openList)
         {
            var _loc9_:int = 0;
            var _loc8_:Array = _itemList;
            do
            {
               for each(_loc2_ in _loc8_)
               {
               }
               continue loop1;
            }
            while(_loc2_.data.id != _loc5_);
            _loc2_.setGrayFilter();
            _residueList.splice(_residueList.indexOf(_loc2_),1);
         }
         if(_xiyouItem)
         {
            _loc3_ = _residueList.indexOf(_xiyouItem);
            if(_loc3_ != -1)
            {
               _residueList.splice(_loc3_,1);
            }
         }
         if(_veryxiyouItem)
         {
            _loc3_ = _residueList.indexOf(_veryxiyouItem);
            if(_loc3_ != -1)
            {
               _residueList.splice(_loc3_,1);
            }
         }
         _turnControl = new SevenYearTreasureBoxTurnControl();
         _turnControl.defaultTurn(_residueList);
      }
      
      private function setOpenDescTxt() : void
      {
         var _loc1_:String = null;
         if(_goodsName == "")
         {
            _openDescTxt.text = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openDescTxt.text");
         }
         else
         {
            _loc1_ = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openDescTxt.text2") + "\n";
            _loc1_ += _goodsName;
            _openDescTxt.htmlText = _loc1_;
         }
      }
      
      public function set data(param1:ShopGoodsInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         refresh();
         var _loc2_:GoodsInfo = new GoodsInfo();
         _loc2_.templateId = _data.ItemId;
         if(_loc2_ && _loc2_.templateInfo)
         {
            _itemView.data = _loc2_;
            _nameTxt.text = _loc2_.templateInfo.TemplateName;
            _descTxt.text = _loc2_.templateInfo.Description;
         }
         buyNumChangeHandler();
         updateOwnBox();
         initItem();
      }
      
      private function getGradeByData() : int
      {
         var _loc3_:int = 0;
         var _loc1_:int = 0;
         var _loc2_:Array = TempleteManager.instance.sevenYearRewardDropCate.getTemplatesByItemId(_data.ItemId);
         if(_loc2_ == null)
         {
            return 0;
         }
         _loc3_ = 0;
         while(_loc3_ < _loc2_.length)
         {
            _loc1_ = int(_loc2_[_loc3_]);
            if(model.flagGrade < _loc1_)
            {
               return _loc1_;
            }
            _loc3_++;
         }
         return 0;
      }
      
      private function refresh() : void
      {
         _flagBmp.visible = _data.template.SonType == 667;
         _buyGradeBtn.visible = _flagBmp.visible;
         _buyImg.visible = !_flagBmp.visible;
         _numTxt.visible = !_flagBmp.visible;
         _plusBtn.visible = !_flagBmp.visible;
         _minusBtn.visible = !_flagBmp.visible;
         _pointTxt.visible = !_flagBmp.visible;
         _buyBtn.visible = !_flagBmp.visible;
         _giftBtn.visible = !_flagBmp.visible;
         var _loc1_:int = getGradeByData();
         if(_loc1_ > 0)
         {
            _flagBmp.setFrame(1);
            _needGradeText.text = _loc1_ + "";
         }
         else
         {
            _flagBmp.setFrame(2);
            _buyGradeBtn.visible = false;
            _needGradeText.text = "";
         }
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         _buyGradeBtn.addEventListener("click",__buyGradeBtnClickHandler);
         _numTxt.addEventListener("change",__numTxtChangeHandler);
         _plusBtn.addEventListener("click",__plusBtnClickHandler);
         _minusBtn.addEventListener("click",__minusBtnClickHandler);
         _buyBtn.addEventListener("click",__buyBtnClickHandler);
         _giftBtn.addEventListener("click",__giftBtnClickHandler);
         _openBtn.addEventListener("click",__openBtnClickHandler);
         model.addEventListener("UPDATE_TREASUREBOX_INFO",__updateTreasureBoxInfo);
         _startBtn.addEventListener("click",__starBtnClickHandler);
         _againBtn.addEventListener("click",__starBtnClickHandler);
         _cannelBtn.addEventListener("click",__cannelBtnClickHandler);
         model.addEventListener("UPDATE_TREASUREBOX_LIST",__updateTreasureboxListHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         if(_buyGradeBtn)
         {
            _buyGradeBtn.removeEventListener("click",__buyGradeBtnClickHandler);
         }
         if(_numTxt)
         {
            _numTxt.removeEventListener("change",__numTxtChangeHandler);
         }
         if(_plusBtn)
         {
            _plusBtn.removeEventListener("click",__plusBtnClickHandler);
         }
         if(_minusBtn)
         {
            _minusBtn.removeEventListener("click",__minusBtnClickHandler);
         }
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__buyBtnClickHandler);
         }
         if(_giftBtn)
         {
            _giftBtn.removeEventListener("click",__giftBtnClickHandler);
         }
         if(_openBtn)
         {
            _openBtn.removeEventListener("click",__openBtnClickHandler);
         }
         model.removeEventListener("UPDATE_TREASUREBOX_INFO",__updateTreasureBoxInfo);
         if(_startBtn)
         {
            _startBtn.removeEventListener("click",__starBtnClickHandler);
         }
         if(_againBtn)
         {
            _againBtn.removeEventListener("click",__starBtnClickHandler);
         }
         if(_cannelBtn)
         {
            _cannelBtn.removeEventListener("click",__cannelBtnClickHandler);
         }
         model.removeEventListener("UPDATE_TREASUREBOX_LIST",__updateTreasureboxListHandler);
      }
      
      private function __updateTreasureboxListHandler(param1:SevenYearEvent = null) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         setOpenDescTxt();
         if(model.dropList.length == 2)
         {
            if(_index == 0)
            {
               _index = _index + 1;
               turnPlay(1);
               return;
            }
            _index = 0;
            _goodsName = "";
         }
         _isPlaying = false;
         closeButton.enable = true;
         _cannelBtn.enable = true;
         _startBtn.enable = _againBtn.enable = _openBtn.enable = count > 0 && !_isPlaying;
         _residueList = [];
         _residueList = _residueList.concat(_itemList);
         for each(_loc2_ in _itemList)
         {
            _loc2_.setNormalFilter();
         }
         loop1:
         for each(var _loc4_:int in openList)
         {
            var _loc9_:int = 0;
            var _loc8_:Array = _itemList;
            do
            {
               for each(_loc2_ in _loc8_)
               {
               }
               continue loop1;
            }
            while(_loc2_.data.id != _loc4_);
            _loc2_.setGrayFilter();
            _residueList.splice(_residueList.indexOf(_loc2_),1);
         }
         if(_xiyouItem)
         {
            _loc3_ = _residueList.indexOf(_xiyouItem);
            if(_loc3_ != -1)
            {
               _residueList.splice(_loc3_,1);
            }
         }
         if(_veryxiyouItem)
         {
            _loc3_ = _residueList.indexOf(_veryxiyouItem);
            if(_loc3_ != -1)
            {
               _residueList.splice(_loc3_,1);
            }
         }
         _turnControl.defaultTurn(_residueList);
      }
      
      private function __starBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         _startBtn.visible = false;
         _goodsName = "";
         _isPlaying = true;
         _openDescTxt.text = "";
         if(count > 0)
         {
            SevenYearManager.instance.openTreasureBox(_data.ItemId);
            closeButton.enable = false;
            _startBtn.enable = _againBtn.enable = _cannelBtn.enable = _openBtn.enable = false;
         }
      }
      
      private function __cannelBtnClickHandler(param1:MouseEvent) : void
      {
         _sprite1.visible = true;
         _sprite2.visible = false;
         _boxBack.setFrame(1);
         _startBtn.visible = true;
         _goodsName = "";
         setOpenDescTxt();
      }
      
      private function __updateTreasureBoxInfo(param1:SevenYearEvent) : void
      {
         updateOwnBox();
         turnPlay(2);
      }
      
      private function turnPlay(param1:int) : void
      {
         var _loc2_:int = 0;
         var _loc8_:Boolean = false;
         var _loc6_:int = 0;
         var _loc3_:SevenYearTreasureBoxItem = null;
         var _loc5_:String = null;
         var _loc11_:String = null;
         var _loc12_:SevenYearTreasureBoxItem = null;
         var _loc9_:int = 0;
         var _loc13_:* = 0;
         var _loc7_:int = 0;
         var _loc10_:String = null;
         var _loc4_:String = null;
         if(model.dropList[_index])
         {
            _loc2_ = int(model.dropList[_index]);
            _loc8_ = false;
            _loc6_ = 0;
            while(_loc6_ < _residueList.length)
            {
               _loc3_ = _residueList[_loc6_];
               if(_loc3_.data.id == _loc2_)
               {
                  if(_loc3_.goodsTemp)
                  {
                     _loc5_ = GoodsSonType.getColorByProfile(_loc3_.goodsTemp.Profile);
                     _loc11_ = _loc3_.goodsTemp.TemplateName;
                     _goodsName += LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openDescTxt.goodsTxt",_loc5_,_loc11_) + "\n";
                  }
                  _loc8_ = true;
                  _turnControl.turnPlate(_loc6_ + 1,param1,param1);
               }
               _loc6_++;
            }
            if(!_loc8_ && _xiyouItem && _veryxiyouItem)
            {
               _loc9_ = 185;
               _loc7_ = 0;
               while(_loc7_ < _residueList.length)
               {
                  if(_residueList[_loc7_].y != _loc9_)
                  {
                     _loc13_ = _loc7_;
                     break;
                  }
                  _loc7_++;
               }
               if(_xiyouItem.data.id == _loc2_)
               {
                  _loc12_ = _xiyouItem;
                  if(_loc13_ == 0)
                  {
                     _residueList.unshift(_xiyouItem);
                  }
                  else
                  {
                     _residueList.splice(_loc13_,0,_xiyouItem);
                  }
               }
               else if(_veryxiyouItem.data.id == _loc2_)
               {
                  _loc12_ = _veryxiyouItem;
                  _residueList.push(_veryxiyouItem);
                  _loc13_ = int(_residueList.length - 1);
               }
               if(_loc12_.goodsTemp)
               {
                  _loc10_ = GoodsSonType.getColorByProfile(_loc12_.goodsTemp.Profile);
                  _loc4_ = _loc12_.goodsTemp.TemplateName;
                  _goodsName += LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.openDescTxt.goodsTxt",_loc10_,_loc4_) + "\n";
               }
               _turnControl.turnPlate(_loc13_ + 1,param1,param1);
            }
         }
      }
      
      private function updateOwnBox() : void
      {
         var _loc1_:TreasureBoxMsg = null;
         if(model.boxList[_data.ItemId])
         {
            _loc1_ = model.boxList[_data.ItemId];
            openList = _loc1_.openList;
            count = _loc1_.count;
         }
         _ownTxt.text = count.toString();
         _startBtn.enable = _againBtn.enable = _openBtn.enable = count > 0 && !_isPlaying;
      }
      
      private function __openBtnClickHandler(param1:MouseEvent) : void
      {
         _sprite1.visible = false;
         _sprite2.visible = true;
         _boxBack.setFrame(2);
      }
      
      private function __buyBtnClickHandler(param1:MouseEvent) : void
      {
         if(!_data)
         {
            return;
         }
         if(buyNum <= 0)
         {
            return;
         }
         SimpleAlertHelper.instance.data = [buyCallBack];
         var _loc2_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc3_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc4_:String = LanguageMgr.GetTranslation("public.prompt");
         var _loc5_:String = LanguageMgr.GetTranslation("SevenYearTreasureBoxFrame.buyBtnClick.text",totalPrice,_nameTxt.text);
         SimpleAlertHelper.instance.popAlerFrame(_loc4_,_loc5_,_loc2_,_loc3_);
      }
      
      private function buyCallBack(param1:Boolean, param2:Boolean) : void
      {
         var _loc3_:int = 0;
         if(param1)
         {
            if(!LogicUtils.judgePointEnoughToShowPay(totalPrice,false))
            {
               return;
            }
            _loc3_ = int(_data.Id);
            ShopManager.Instance.buyOne(_loc3_,buyNum,playerInfo.userId,1,false);
            buyNum = 1;
            buyNumChangeHandler();
         }
      }
      
      private function __giftBtnClickHandler(param1:MouseEvent) : void
      {
         var event:MouseEvent = param1;
         if(!_data)
         {
            return;
         }
         CheckUIModuleUtil.instance.tryCall("quickbuy",function():void
         {
            var _loc1_:GiftDonatioFrame = ComponentFactory.Instance.creatComponentByStylename("shop.GiftDonatioFrame");
            _loc1_.ShopId = _data.Id;
            _loc1_.number = buyNum;
            _loc1_.show();
         });
      }
      
      private function __numTxtChangeHandler(param1:Event) : void
      {
         buyNum = parseInt(_numTxt.text);
         buyNumChangeHandler();
      }
      
      private function __plusBtnClickHandler(param1:MouseEvent) : void
      {
         buyNum = buyNum + 1;
         buyNumChangeHandler();
      }
      
      private function __minusBtnClickHandler(param1:MouseEvent) : void
      {
         buyNum = buyNum - 1;
         buyNumChangeHandler();
      }
      
      private function buyNumChangeHandler() : void
      {
         buyNum = buyNum <= 0 ? 1 : buyNum;
         buyNum = buyNum > 99 ? 99 : buyNum;
         _numTxt.text = buyNum.toString();
         totalPrice = _data.Point * buyNum;
         _pointTxt.text = totalPrice.toString();
      }
      
      private function __buyGradeBtnClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:SevenYearBuyFrame = ComponentFactory.Instance.creatComponentByStylename("sevenyear.SevenYearBuyFrame");
         _loc2_.show();
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         model.curOpenBoxFrame = true;
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
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
      
      private function get getTemplateById() : Array
      {
         var _loc2_:SevenYearTreasureBoxDropTemplate = null;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         if(!_data)
         {
            return [];
         }
         var _loc3_:Array = TempleteManager.instance.sevenYearTreasureBoxDropCate.getTemplatesByDropId(_data.ItemId);
         var _loc1_:Array = _loc3_.concat();
         _loc1_.sortOn("id",16);
         _loc5_ = 0;
         while(_loc5_ < _loc1_.length)
         {
            _loc2_ = _loc1_[_loc5_];
            if(_loc2_.appearType == 3)
            {
               if(_loc2_.isShow == 0)
               {
                  _xiyouTemp = _loc2_;
                  _loc1_.splice(_loc5_,1);
                  _loc5_--;
               }
               else if(_loc2_.isShow == 1)
               {
                  _veryxiyouTemp = _loc2_;
                  _loc1_.splice(_loc5_,1);
                  _loc5_--;
               }
            }
            _loc5_++;
         }
         return _loc1_;
      }
      
      protected function get playerInfo() : PlayerInfo
      {
         return PlayerManager.instance.currentPlayerModel.playerInfo;
      }
      
      public function get model() : SevenYearModel
      {
         return SevenYearManager.instance.model;
      }
      
      override public function dispose() : void
      {
         clearTimeout(_xiyouTime);
         clearTimeout(_veryxiyouTime);
         model.curOpenBoxFrame = false;
         removeEvent();
         ObjectUtils.disposeObject(_border);
         _border = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_boxBack);
         _boxBack = null;
         ObjectUtils.disposeObject(_sprite1);
         _sprite1 = null;
         ObjectUtils.disposeObject(_sprite2);
         _sprite2 = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_numTxt);
         _numTxt = null;
         ObjectUtils.disposeObject(_descTxt);
         _descTxt = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_flagBmp);
         _flagBmp = null;
         ObjectUtils.disposeObject(_buyGradeBtn);
         _buyGradeBtn = null;
         ObjectUtils.disposeObject(_buyImg);
         _buyImg = null;
         ObjectUtils.disposeObject(_plusBtn);
         _plusBtn = null;
         ObjectUtils.disposeObject(_minusBtn);
         _minusBtn = null;
         ObjectUtils.disposeObject(_pointTxt);
         _pointTxt = null;
         ObjectUtils.disposeObject(_giftBtn);
         _giftBtn = null;
         ObjectUtils.disposeObject(_ownBmp);
         _ownBmp = null;
         ObjectUtils.disposeObject(_ownTxt);
         _ownTxt = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         ObjectUtils.disposeObject(_openTxt);
         _openTxt = null;
         ObjectUtils.disposeObject(_openDescTxt);
         _openDescTxt = null;
         ObjectUtils.disposeObject(_startBtn);
         _startBtn = null;
         ObjectUtils.disposeObject(_againBtn);
         _againBtn = null;
         ObjectUtils.disposeObject(_cannelBtn);
         _cannelBtn = null;
         ObjectUtils.disposeObject(_needGradeText);
         _needGradeText = null;
         ObjectUtils.disposeObject(_veryxiyouItem);
         _veryxiyouItem = null;
         ObjectUtils.disposeObject(_xiyouItem);
         _xiyouItem = null;
         LogicUtils.disposeDisplayCollection(_itemList);
         _itemList = null;
         LogicUtils.disposeDisplayCollection(_residueList);
         _residueList = null;
         openList = null;
         if(_turnControl)
         {
            _turnControl.dispose();
         }
         _turnControl = null;
         super.dispose();
      }
   }
}

