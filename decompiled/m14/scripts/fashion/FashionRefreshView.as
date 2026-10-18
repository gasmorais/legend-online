package fashion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import mvc.module.fashion.FashionModel;
   import mvc.module.fashion.FashionPolishInfo;
   import mvc.module.fashion.FashionRefreshData;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.FashionPolishTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class FashionRefreshView extends Sprite implements Disposeable
   {
      
      private var _back:MutipleImage;
      
      private var _needBack:MutipleImage;
      
      private var _nextImage:Bitmap;
      
      private var _choseImage:ScaleFrameImage;
      
      private var _progressGreen:MovieClip;
      
      private var _progressTxt:FilterFrameText;
      
      private var _fashion1:FashionRefreshItem;
      
      private var _fashion2:FashionRefreshItem;
      
      private var _fashion3:FashionRefreshItem;
      
      private var _fashion4:FashionRefreshItem;
      
      private var _fashionDic:SimpleDictionary;
      
      private var _refreshBtn:IconButton;
      
      private var _currentItem:FashionRefreshItem;
      
      private var _needNumTxt:FilterFrameText;
      
      private var _hasNumTxt:FilterFrameText;
      
      private var _fashionNumTxt:FilterFrameText;
      
      private var _fashionTipsTxt:FilterFrameText;
      
      private var _currentAttributeItem:FashionRefreshAttributeView;
      
      private var _nextAttributeItem:FashionRefreshAttributeView;
      
      private var _maxAttributeItem:FashionRefreshAttributeView;
      
      private var _refreshData:FashionRefreshData;
      
      public var clickCell:Function;
      
      public function FashionRefreshView(param1:Function = null)
      {
         clickCell = param1;
         super();
         _refreshData = new FashionRefreshData();
         initView();
         addEvent();
         updataView();
         FashionManager.instance.getFashionPolish(1,0,1);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("xmlui.fas.refreshBack");
         _nextImage = ComponentFactory.Instance.creatBitmap("asset.fashion.refreshBack03");
         _progressGreen = ComponentFactory.Instance.creatCustomObject("fashion.ProgressGreenBar");
         _progressTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.ProgressBarTxt");
         _choseImage = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshChoseBack");
         _fashion1 = new FashionRefreshItem(0,__onClickItem);
         _fashion2 = new FashionRefreshItem(1,__onClickItem);
         _fashion3 = new FashionRefreshItem(2,__onClickItem);
         _fashion4 = new FashionRefreshItem(3,__onClickItem);
         _refreshBtn = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshBtn");
         _needBack = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshNeedGoodBack");
         _needNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshNeedNumTxt");
         _hasNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.refreshHasNumTxt");
         _fashionNumTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.fashionNumTxt");
         _fashionTipsTxt = ComponentFactory.Instance.creatComponentByStylename("fashion.fashionTipsTxt");
         _currentAttributeItem = new FashionRefreshAttributeView(1);
         _nextAttributeItem = new FashionRefreshAttributeView(2);
         _maxAttributeItem = new FashionRefreshAttributeView(3);
         addChild(_back);
         addChild(_choseImage);
         addChild(_nextImage);
         addChild(_progressGreen);
         addChild(_progressTxt);
         addChild(_fashion1);
         addChild(_fashion2);
         addChild(_fashion3);
         addChild(_fashion4);
         addChild(_refreshBtn);
         addChild(_needBack);
         addChild(_needNumTxt);
         addChild(_hasNumTxt);
         addChild(_fashionNumTxt);
         addChild(_fashionTipsTxt);
         addChild(_currentAttributeItem);
         addChild(_nextAttributeItem);
         addChild(_maxAttributeItem);
         _progressGreen.x = 62;
         _progressGreen.y = 296;
         _progressTxt.x = 140;
         _progressTxt.y = 301;
         _fashion1.x = 151;
         _fashion1.y = 15;
         _fashion2.x = 28;
         _fashion2.y = 127;
         _fashion3.x = 268;
         _fashion3.y = 127;
         _fashion4.x = 151;
         _fashion4.y = 236;
         _currentAttributeItem.x = 10;
         _currentAttributeItem.y = 355;
         _nextAttributeItem.x = 200;
         _nextAttributeItem.y = 355;
         _maxAttributeItem.x = 135;
         _maxAttributeItem.y = 355;
         _progressGreen.gotoAndStop(100);
         _progressTxt.text = "max";
         _needNumTxt.text = "1";
         _fashionDic = new SimpleDictionary();
         _fashionDic.add("8_" + thane.id + "_" + 4,_fashion1);
         _fashionDic.add("9_" + thane.id + "_" + 4,_fashion2);
         _fashionDic.add("10_" + thane.id + "_" + 4,_fashion3);
         _fashionDic.add("11_" + thane.id + "_" + 4,_fashion4);
         initFashionData();
      }
      
      private function initFashionData() : void
      {
         var _loc1_:FashionRefreshItem = null;
         var _loc2_:SimpleDictionary = null;
         for each(_loc1_ in _fashionDic)
         {
            _loc1_.data = null;
         }
         if(fashionModel.lookDragonTalkerFashion)
         {
            _loc2_ = ArmyManager.instance.dragonFashionList;
         }
         else
         {
            _loc2_ = ArmyManager.instance.fashionList;
         }
         for each(var _loc3_:GoodsInfo in _loc2_)
         {
            _loc1_ = _fashionDic[_loc3_.pos + "_" + thane.id + "_" + _loc3_.bagType];
            if(_loc1_)
            {
               _loc1_.data = _loc3_;
            }
         }
      }
      
      private function addEvent() : void
      {
         _refreshBtn.addEventListener("click",__refreshOnClick);
         _needNumTxt.addEventListener("change",__numChange);
         FashionManager.instance.addEventListener("FASHION_REFRESH_RECEIVE",__receivedRefreshHandler);
      }
      
      private function __refreshOnClick(param1:MouseEvent) : void
      {
         if(!_currentItem)
         {
            return;
         }
         var _loc3_:int = _currentItem.pos;
         var _loc6_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_loc3_);
         var _loc4_:int = Math.floor(_loc6_.level / 10) * 10;
         var _loc2_:int = int(_loc6_.sonType);
         var _loc5_:int = int(_needNumTxt.text);
         if(!_currentItem.data)
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("fashion.refreshView.tips23"));
            return;
         }
         FashionManager.instance.getFashionPolish(_loc2_,_loc5_);
      }
      
      private function __numChange(param1:Event) : void
      {
         var _loc2_:int = int(_needNumTxt.text);
         var _loc3_:int = getBagCount();
         if(_loc2_ >= 9999)
         {
            if(getBagCount() >= 9999)
            {
               _needNumTxt.text = "9999";
            }
            else
            {
               _needNumTxt.text = String(_loc3_);
            }
         }
         else if(_loc2_ <= 0 || _loc3_ <= 0)
         {
            _needNumTxt.text = "1";
         }
         else if(_loc2_ <= _loc3_)
         {
            _needNumTxt.text = "" + _loc2_;
         }
         else
         {
            _needNumTxt.text = String(_loc3_);
         }
      }
      
      private function __receivedRefreshHandler(param1:FashionEvent) : void
      {
         updataView();
         __numChange(null);
      }
      
      private function updataView() : void
      {
         var _loc1_:* = null;
         for each(_loc1_ in _fashionDic)
         {
            _loc1_.refreshView();
         }
         _hasNumTxt.text = getBagCount().toString();
         if(!_currentItem)
         {
            if(_fashion2.data)
            {
               _currentItem = _fashion2;
            }
            else if(_fashion3.data)
            {
               _currentItem = _fashion3;
            }
            else if(_fashion4.data)
            {
               _currentItem = _fashion4;
            }
            else
            {
               _currentItem = _fashion1;
            }
         }
         __onClickItem(_currentItem);
      }
      
      private function __onClickItem(param1:FashionRefreshItem) : void
      {
         var _loc2_:FashionPolishTemplateInfo = null;
         var _loc8_:int = 0;
         _currentItem = param1;
         var _loc10_:int = param1.pos;
         _choseImage.setFrame(_loc10_ + 1);
         _fashionNumTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips" + (14 + _loc10_));
         _fashionTipsTxt.text = LanguageMgr.GetTranslation("fashion.refreshView.tips" + (18 + _loc10_));
         var _loc13_:Array = getCurrentFashionList(_loc10_);
         var _loc5_:int = int(fashionModel.getBookNum(_loc10_));
         var _loc12_:int = _loc5_ / _loc13_.length * 100;
         if(_loc12_ >= 100)
         {
            _progressGreen.gotoAndStop(100);
            _progressTxt.text = "max";
         }
         else
         {
            _progressGreen.gotoAndStop(_loc12_);
            _progressTxt.text = _loc5_ + "/" + _loc13_.length;
         }
         var _loc14_:FashionPolishInfo = fashionModel.getPolishInfoBySontype(_loc10_);
         var _loc9_:int = Math.floor(_loc14_.level / 10);
         var _loc6_:int = 0;
         var _loc3_:int = int(FashionManager.instance.getSonTypeByindex(_loc10_));
         var _loc7_:int = int(fashionModel.getBookNum(_loc10_));
         var _loc4_:Array = FashionManager.instance.fashionModel.getIdentityedProperties();
         _loc8_ = _loc9_;
         while(_loc8_ >= 0)
         {
            _loc6_ = _loc8_ * 10;
            _loc6_ = int(_loc6_ == 0 ? 1 : _loc6_);
            _loc2_ = getTemplatesByLevelAndPos(_loc6_,_loc3_);
            if(_loc7_ >= _loc2_.NeedCount)
            {
               break;
            }
            _loc8_ -= 1;
         }
         _loc2_ = getTemplatesByLevelAndPos(_loc6_ + 1,_loc3_);
         if(_loc2_)
         {
            _currentAttributeItem.visible = _nextAttributeItem.visible = _nextImage.visible = true;
            _maxAttributeItem.visible = false;
            _currentAttributeItem.setRefeshLevel(_loc10_);
            _nextAttributeItem.setRefeshLevel(_loc10_);
         }
         else
         {
            _currentAttributeItem.visible = _nextAttributeItem.visible = _nextImage.visible = false;
            _maxAttributeItem.visible = true;
            _maxAttributeItem.setRefeshLevel(_loc10_);
         }
         var _loc15_:Array = fashionModel.getAllLevelAdd();
         var _loc11_:Array = fashionModel.getNextLevelAddBypos(_loc10_);
         if(clickCell != null)
         {
            clickCell(_loc15_,_loc11_);
         }
      }
      
      private function removeEvent() : void
      {
         _refreshBtn.removeEventListener("click",__refreshOnClick);
         _needNumTxt.removeEventListener("change",__numChange);
         FashionManager.instance.removeEventListener("FASHION_REFRESH_RECEIVE",__receivedRefreshHandler);
      }
      
      private function getCurrentFashionList(param1:int) : Array
      {
         var _loc2_:Array = null;
         switch(param1)
         {
            case 0:
               _loc2_ = fashionModel.wingTems;
               break;
            case 1:
               _loc2_ = fashionModel.hatTems;
               break;
            case 2:
               _loc2_ = fashionModel.clothesTems;
               break;
            case 3:
               _loc2_ = fashionModel.weaponTems;
               break;
            default:
               _loc2_ = [];
         }
         return _loc2_;
      }
      
      private function get fashionModel() : FashionModel
      {
         return FrameControllerManager.instance.fashionCodeController.model;
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function getBagCount() : int
      {
         return GoodsManager.instance.getGoodsNumByTempId(_refreshData.refreshTemplateId);
      }
      
      private function getTemplatesByLevelAndPos(param1:int, param2:int) : FashionPolishTemplateInfo
      {
         return TempleteManager.instance.fashionPolishTemplateCate.getTemplatesByLevelAndPos(param1,param2);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeViolentMc(_progressGreen);
         _progressGreen = null;
         ObjectUtils.disposeObject(_nextImage);
         _nextImage = null;
         ObjectUtils.disposeObject(_choseImage);
         _choseImage = null;
         ObjectUtils.disposeObject(_fashion1);
         _fashion1 = null;
         ObjectUtils.disposeObject(_fashion2);
         _fashion2 = null;
         ObjectUtils.disposeObject(_fashion3);
         _fashion3 = null;
         ObjectUtils.disposeObject(_fashion4);
         _fashion4 = null;
         for(var _loc1_:String in _fashionDic)
         {
            ObjectUtils.disposeObject(_fashionDic[_loc1_]);
            delete _fashionDic[_loc1_];
         }
         ObjectUtils.disposeObject(_progressTxt);
         _progressTxt = null;
         ObjectUtils.disposeObject(_needNumTxt);
         _needNumTxt = null;
         ObjectUtils.disposeObject(_refreshBtn);
         _refreshBtn = null;
         ObjectUtils.disposeObject(_needBack);
         _needBack = null;
         ObjectUtils.disposeObject(_hasNumTxt);
         _hasNumTxt = null;
         ObjectUtils.disposeObject(_currentAttributeItem);
         _currentAttributeItem = null;
         ObjectUtils.disposeObject(_nextAttributeItem);
         _nextAttributeItem = null;
         ObjectUtils.disposeObject(_maxAttributeItem);
         _maxAttributeItem = null;
         ObjectUtils.disposeObject(_fashionNumTxt);
         _fashionNumTxt = null;
         ObjectUtils.disposeObject(_fashionTipsTxt);
         _fashionTipsTxt = null;
         clickCell = null;
         _currentItem = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

