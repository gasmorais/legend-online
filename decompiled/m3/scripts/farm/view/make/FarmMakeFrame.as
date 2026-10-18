package farm.view.make
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.CustomBitmap;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import yishi.datas.ComponentGroupType;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.events.NotificationEvent;
   import yishi.filter.UIFilter;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.SimpleHelpFrame;
   
   public class FarmMakeFrame extends Frame
   {
      
      private var _bg:ScaleBitmapImage;
      
      private var _bg2:Bitmap;
      
      private var _cheek:Bitmap;
      
      private var _hBox:HBox;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _allBtn:SelectedButton;
      
      private var _mileTeaBtn:SelectedButton;
      
      private var _magicBoxBtn:SelectedButton;
      
      private var _makeButton:IconButton;
      
      private var _plusImg0:CustomBitmap;
      
      private var _plusImg1:CustomBitmap;
      
      private var _itemBg0:CustomBitmap;
      
      private var _itemBg1:CustomBitmap;
      
      private var _itemBg2:CustomBitmap;
      
      private var _lockImg:CustomBitmap;
      
      private var _prePageBtn:BaseButton;
      
      private var _nextPageBtn:BaseButton;
      
      private var _numBgImg:Image;
      
      private var _inputTxt:FilterFrameText;
      
      private var _needGoldImg:Bitmap;
      
      private var _needGoldTxt:FilterFrameText;
      
      private var _needGoods0:BaseItemView;
      
      private var _numTxt0:FilterFrameText;
      
      private var _needGoods1:BaseItemView;
      
      private var _numTxt1:FilterFrameText;
      
      private var _needGoods2:BaseItemView;
      
      private var _numTxt2:FilterFrameText;
      
      private var _farmMakeBagView:FarmMakeBagView;
      
      private var _goodsData:Array;
      
      private var _composeArr:Array;
      
      private var _helpBtn:BaseButton;
      
      private var _composeCount:int;
      
      private var _composeInfo:ComposeGoodsTemplete;
      
      private var _canMake:Boolean;
      
      public function FarmMakeFrame()
      {
         super();
         initView();
         addEvent();
      }
      
      public function get composeCount() : int
      {
         return _composeCount;
      }
      
      public function set composeCount(param1:int) : void
      {
         _composeCount = param1;
         _prePageBtn.enable = _nextPageBtn.enable = true;
         if(composeCount == 0)
         {
            _prePageBtn.enable = _nextPageBtn.enable = false;
         }
         if(composeCount == 1)
         {
            _prePageBtn.enable = false;
         }
         if(composeCount == getCanMakeCount())
         {
            _nextPageBtn.enable = false;
         }
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("farm.FarmMakeFrame.title");
         _btnGroup = new SelectedButtonGroup();
         _composeArr = [];
         _bg = ComponentFactory.Instance.creatComponentByStylename("farm.FarmMakeFrame.BG");
         _bg2 = ComponentFactory.Instance.creatBitmap("asset.farm.make.makeFrameBg");
         _cheek = ComponentFactory.Instance.creatBitmap("asset.farm.make.makeFrameBgCheek");
         _hBox = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.btnHbox");
         _allBtn = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.AllBtn");
         _mileTeaBtn = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.MilkTeaBtn");
         _magicBoxBtn = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.MagicBoxBtn");
         _makeButton = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.MakeBtn");
         _plusImg0 = ComponentFactory.Instance.creatCustomObject("farm.make.plusImg0");
         _plusImg1 = ComponentFactory.Instance.creatCustomObject("farm.make.plusImg1");
         _itemBg0 = ComponentFactory.Instance.creatCustomObject("farm.make.ItemBg0");
         _itemBg1 = ComponentFactory.Instance.creatCustomObject("farm.make.ItemBg1");
         _itemBg2 = ComponentFactory.Instance.creatCustomObject("farm.make.ItemBg2");
         _lockImg = ComponentFactory.Instance.creatCustomObject("farm.make.LockImg");
         _prePageBtn = ComponentFactory.Instance.creatComponentByStylename("farm.make.ComposePrePageBtn");
         _prePageBtn.enable = false;
         _nextPageBtn = ComponentFactory.Instance.creatComponentByStylename("farm.make.ComposeNextPageBtn");
         _nextPageBtn.enable = false;
         _numBgImg = ComponentFactory.Instance.creatComponentByStylename("farm.make.ComposeMatetialView.NumBg");
         _inputTxt = ComponentFactory.Instance.creatComponentByStylename("farm.make.ComposeGoodsNumTxt");
         _inputTxt.text = "0";
         _needGoldImg = ComponentFactory.Instance.creatBitmap("asset.farm.make.NeedGlodImg");
         _needGoldTxt = ComponentFactory.Instance.creatComponentByStylename("farm.make.NeedGoldNumTxt");
         _farmMakeBagView = new FarmMakeBagView();
         _farmMakeBagView.x = 10;
         _farmMakeBagView.y = 45;
         _needGoods0 = ComponentFactory.Instance.creatCustomObject("farm.make.FarmMakeComposeNeedGoodItemIcon0");
         _needGoods1 = ComponentFactory.Instance.creatCustomObject("farm.make.FarmMakeComposeNeedGoodItemIcon1");
         _needGoods2 = ComponentFactory.Instance.creatCustomObject("farm.make.FarmMakeComposeNeedGoodItemIcon2");
         _numTxt0 = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.countNeedGoodsTxt0");
         _numTxt0.text = "3";
         _numTxt1 = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.countNeedGoodsTxt1");
         _numTxt1.text = "3";
         _numTxt2 = ComponentFactory.Instance.creatComponentByStylename("farm.makeFrame.countNeedGoodsTxt2");
         _numTxt2.text = "3";
         _helpBtn = ComponentFactory.Instance.creatComponentByStylename("farm.farmMakeFarme.HelpBtn");
         _helpBtn.tipData = [LanguageMgr.GetTranslation("farm.view.make.FarmMakeFrame.helpBtnTip")];
         addToContent(_helpBtn);
         _btnGroup.addSelectItem(_allBtn);
         _btnGroup.addSelectItem(_mileTeaBtn);
         _btnGroup.addSelectItem(_magicBoxBtn);
         addToContent(_bg);
         addToContent(_bg2);
         addToContent(_cheek);
         addToContent(_hBox);
         _hBox.addChild(_allBtn);
         _hBox.addChild(_mileTeaBtn);
         _hBox.addChild(_magicBoxBtn);
         addToContent(_makeButton);
         addToContent(_plusImg0);
         addToContent(_plusImg1);
         addToContent(_itemBg0);
         addToContent(_itemBg1);
         addToContent(_itemBg2);
         addToContent(_lockImg);
         addToContent(_prePageBtn);
         addToContent(_nextPageBtn);
         addToContent(_numBgImg);
         addToContent(_inputTxt);
         addToContent(_needGoldImg);
         addToContent(_needGoldTxt);
         addToContent(_farmMakeBagView);
         addToContent(_needGoods0);
         addToContent(_needGoods1);
         addToContent(_needGoods2);
         addToContent(_numTxt0);
         addToContent(_numTxt1);
         addToContent(_numTxt2);
      }
      
      private function getComposeByType(param1:Array) : Array
      {
         var _loc4_:GoodsInfo = null;
         var _loc3_:Array = [];
         _composeArr = [];
         var _loc2_:Dictionary = TempleteManager.instance.getComposeTempleteList();
         for each(var _loc5_:ComposeGoodsTemplete in _loc2_)
         {
            if(param1.indexOf(_loc5_.Types) != -1)
            {
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _loc5_.NewMaterial;
               _loc3_.push(_loc4_);
               _composeArr.push(_loc5_);
            }
         }
         return _loc3_;
      }
      
      private function addEvent() : void
      {
         addEventListener("response",_frameResponse);
         _btnGroup.addEventListener("change",__tabChangeHandler);
         NotificationManager.instance.addEventListener("FARM_MAKE_SELECTED_CHANGE",onSelectedChange);
         _makeButton.addEventListener("click",onMakeBtnClick);
         GoodsManager.instance.addEventListener("UPDATE_BAG",goodsChangeHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",goodsChangeHandler);
         _prePageBtn.addEventListener("click",onDelBtnClick);
         _nextPageBtn.addEventListener("click",onAddBtnClick);
         _inputTxt.addEventListener("change",onInputChange);
         _helpBtn.addEventListener("click",__makeHelpHandler);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",_frameResponse);
         _btnGroup.removeEventListener("change",__tabChangeHandler);
         NotificationManager.instance.removeEventListener("FARM_MAKE_SELECTED_CHANGE",onSelectedChange);
         _makeButton.removeEventListener("click",onMakeBtnClick);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",goodsChangeHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",goodsChangeHandler);
         _prePageBtn.removeEventListener("click",onDelBtnClick);
         _nextPageBtn.removeEventListener("click",onAddBtnClick);
         _inputTxt.removeEventListener("change",onInputChange);
         _helpBtn.removeEventListener("click",__makeHelpHandler);
      }
      
      private function __makeHelpHandler(param1:MouseEvent) : void
      {
         var _loc2_:SimpleHelpFrame = ComponentFactory.Instance.creatComponentByStylename("farm.farmmakefarme.helpFrame");
         _loc2_.show();
      }
      
      private function goodsChangeHandler(param1:Event) : void
      {
         __tabChangeHandler();
      }
      
      private function onMakeBtnClick(param1:MouseEvent) : void
      {
         StoreSocketOutManager.sendCompose(_composeInfo.Id,int(_inputTxt.text),false,false);
      }
      
      private function __tabChangeHandler(param1:Event = null) : void
      {
         var _loc2_:Array = [101,103,102];
         switch(int(_btnGroup.selectIndex) - 1)
         {
            case 0:
               _loc2_ = [103];
               break;
            case 1:
               _loc2_ = [102];
         }
         _goodsData = getComposeByType(_loc2_);
         _farmMakeBagView.updateData(_goodsData,param1 != null);
      }
      
      private function _frameResponse(param1:FrameEvent) : void
      {
         switch(int(param1.responseCode))
         {
            case 0:
               dispose();
               break;
            case 1:
               dispose();
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         _btnGroup.selectIndex = 0;
      }
      
      private function onSelectedChange(param1:NotificationEvent) : void
      {
         updateComposeView(param1.data);
         inputArea();
      }
      
      private function updateComposeView(param1:int) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc4_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         _composeInfo = _composeArr[param1];
         _canMake = true;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            this["_numTxt" + _loc4_].text = "";
            this["_needGoods" + _loc4_].data = null;
            this["_needGoods" + _loc4_].filters = [];
            if(_composeInfo["Material" + (_loc4_ + 1)] != 0)
            {
               _loc5_ = new GoodsInfo();
               _loc5_.templateId = _composeInfo["Material" + (_loc4_ + 1)];
               _loc3_ = int(_composeInfo["Count" + (_loc4_ + 1)]);
               this["_numTxt" + _loc4_].text = GoodsManager.instance.getGoodsNumByTempId(_loc5_.templateId) + "/" + _loc3_;
               this["_needGoods" + _loc4_].data = _loc5_;
               if(_loc3_ > GoodsManager.instance.getGoodsNumByTempId(_composeInfo["Material" + (_loc4_ + 1)]))
               {
                  this["_needGoods" + _loc4_].filters = [UIFilter.getBlackFilter()];
                  _canMake = false;
               }
            }
            _loc4_++;
         }
         composeCount = getCanMakeCount();
         _loc2_ = _composeInfo.NeedGold * composeCount;
         if(ResourceManager.instance.gold.count < _loc2_)
         {
            _canMake = false;
         }
         _makeButton.enable = _canMake;
         _needGoldTxt.text = String(_loc2_);
      }
      
      private function inputArea() : void
      {
         _inputTxt.text = "0";
         if(_canMake)
         {
            _inputTxt.text = composeCount.toString();
         }
      }
      
      private function getCanMakeCount() : int
      {
         var _loc4_:int = 0;
         var _loc1_:int = 0;
         var _loc5_:int = 0;
         _composeInfo;
         var _loc3_:int = 1000000;
         _loc4_ = 1;
         while(_loc4_ < 4)
         {
            if(_composeInfo["Count" + _loc4_] > 0)
            {
               _loc1_ = int(GoodsManager.instance.getGoodsNumByTempId(_composeInfo["Material" + _loc4_]));
               _loc5_ = _loc1_ / _composeInfo["Count" + _loc4_];
               if(_loc5_ < _loc3_)
               {
                  _loc3_ = _loc5_;
               }
            }
            _loc4_++;
         }
         var _loc2_:int = _composeInfo.NeedGold * _loc3_;
         if(ResourceManager.instance.gold.count < _loc2_)
         {
            _loc3_ = ResourceManager.instance.gold.count / _composeInfo.NeedGold;
         }
         return _loc3_;
      }
      
      private function onDelBtnClick(param1:MouseEvent) : void
      {
         if(composeCount <= 1)
         {
            return;
         }
         composeCount -= 1;
         _inputTxt.text = composeCount.toString();
         var _loc2_:int = _composeInfo.NeedGold * composeCount;
         _needGoldTxt.text = String(_loc2_);
      }
      
      private function onAddBtnClick(param1:MouseEvent) : void
      {
         if(composeCount >= getCanMakeCount())
         {
            return;
         }
         composeCount += 1;
         _inputTxt.text = composeCount.toString();
         var _loc2_:int = _composeInfo.NeedGold * composeCount;
         _needGoldTxt.text = String(_loc2_);
      }
      
      private function onInputChange(param1:Event) : void
      {
         var _loc3_:int = int(_inputTxt.text);
         _inputTxt.text = _loc3_.toString();
         _loc3_ = int(_inputTxt.text);
         if(_inputTxt.text == "")
         {
            _inputTxt.text = "1";
         }
         if(_inputTxt.text == "0")
         {
            _inputTxt.text = "1";
         }
         if(_loc3_ > getCanMakeCount())
         {
            _inputTxt.text = getCanMakeCount().toString();
         }
         composeCount = int(_inputTxt.text);
         var _loc2_:int = _composeInfo.NeedGold * composeCount;
         _needGoldTxt.text = String(_loc2_);
      }
      
      override public function get groups() : Array
      {
         return [ComponentGroupType.NONE];
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_bg2);
         _bg2 = null;
         ObjectUtils.disposeObject(_hBox);
         _hBox = null;
         ObjectUtils.disposeObject(_allBtn);
         _allBtn = null;
         ObjectUtils.disposeObject(_mileTeaBtn);
         _mileTeaBtn = null;
         ObjectUtils.disposeObject(_magicBoxBtn);
         _magicBoxBtn = null;
         ObjectUtils.disposeObject(_makeButton);
         _makeButton = null;
         ObjectUtils.disposeObject(_plusImg0);
         _plusImg0 = null;
         ObjectUtils.disposeObject(_plusImg1);
         _plusImg1 = null;
         ObjectUtils.disposeObject(_itemBg0);
         _itemBg0 = null;
         ObjectUtils.disposeObject(_itemBg1);
         _itemBg1 = null;
         ObjectUtils.disposeObject(_itemBg2);
         _itemBg2 = null;
         ObjectUtils.disposeObject(_lockImg);
         _lockImg = null;
         ObjectUtils.disposeObject(_prePageBtn);
         _prePageBtn = null;
         ObjectUtils.disposeObject(_nextPageBtn);
         _nextPageBtn = null;
         ObjectUtils.disposeObject(_numBgImg);
         _numBgImg = null;
         ObjectUtils.disposeObject(_inputTxt);
         _inputTxt = null;
         ObjectUtils.disposeObject(_needGoldImg);
         _needGoldImg = null;
         ObjectUtils.disposeObject(_needGoldTxt);
         _needGoldTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
   }
}

