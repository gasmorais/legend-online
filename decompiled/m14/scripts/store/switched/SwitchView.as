package store.switched
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreSwitchCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import managers.VIPManager;
   import mvc.controler.StoreControler;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.SwitchGoodsTemplete;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.SharedManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   import yishi.view.frame.NewVipOpenView;
   import yishi.view.tips.MessageTipManager;
   
   public class SwitchView extends Sprite implements Disposeable
   {
      
      private var _bgLeft:Bitmap;
      
      private var _bgRight:Bitmap;
      
      private var _goodBgLeft:Bitmap;
      
      private var _goodBgRight:Bitmap;
      
      private var _selectTxtBg:Bitmap;
      
      private var _switchBtn:IconButton;
      
      private var _switchBack:ScaleBitmapImage;
      
      private var _switchEquipBg:MovieClip;
      
      private var _neededGold:Image;
      
      private var _neededGoldTxt:FilterFrameText;
      
      private var _neededGoldTxt2:FilterFrameText;
      
      private var _discountImg:ScaleBitmapImage;
      
      private var _discountTxt:FilterFrameText;
      
      private var _itemDic:SimpleDictionary;
      
      private var _equip:StoreSwitchCell;
      
      private var _itemList:Vector.<SwitchItem>;
      
      private var _currentItem:SwitchItem;
      
      private var _addBtn:BaseButton;
      
      private var _reduceBtn:BaseButton;
      
      private var _minBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _numBg:Image;
      
      private var _composeNumTxt:FilterFrameText;
      
      private var _discountLine:Bitmap;
      
      private var _selectIndex:int = 0;
      
      private var _vipOpenView:NewVipOpenView;
      
      private var _currentGoodsInfo:GoodsInfo;
      
      private var _maxCount:int;
      
      public function SwitchView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:SwitchItem = null;
         _bgLeft = ComponentFactory.Instance.creatBitmap("asset.store.switchBg");
         _bgRight = ComponentFactory.Instance.creatBitmap("asset.store.switchBg");
         _goodBgLeft = ComponentFactory.Instance.creatBitmap("asset.store.switchGoodBg");
         _goodBgRight = ComponentFactory.Instance.creatBitmap("asset.store.switchGoodBg");
         _selectTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.selectGoodBg");
         _switchBtn = ComponentFactory.Instance.creatComponentByStylename("store.switchAttribute");
         _switchBack = ComponentFactory.Instance.creatComponentByStylename("store.switchBack");
         _switchEquipBg = ComponentFactory.Instance.creatCustomObject("store.StoreFrameEquipBg");
         _neededGold = ComponentFactory.Instance.creatComponentByStylename("store.SwitchNeededGoldTxtImg");
         _neededGoldTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNeededGoldTxt");
         _neededGoldTxt2 = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNeededGoldTxt2");
         _discountImg = ComponentFactory.Instance.creatComponentByStylename("store.discountNumBack");
         _discountTxt = ComponentFactory.Instance.creatComponentByStylename("store.discountNumTxt");
         _discountLine = ComponentFactory.Instance.creatBitmap("asset.store.discountLine");
         _equip = ComponentFactory.Instance.creatCustomObject("store.switchEquiItem");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("ComposeMatetialView.NumBg");
         _numBg.x = 97;
         _numBg.y = 299;
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposePrePageBtn");
         _reduceBtn.x = 66;
         _reduceBtn.y = 297;
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNextPageBtn");
         _addBtn.x = 148;
         _addBtn.y = 297;
         _composeNumTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeGoodsNumTxt");
         _composeNumTxt.x = 103;
         _composeNumTxt.y = 301;
         _minBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMinPageBtn");
         _minBtn.x = 35;
         _minBtn.y = 297;
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMaxPageBtn");
         _maxBtn.x = 177;
         _maxBtn.y = 297;
         _reduceBtn.enable = _addBtn.enable = _composeNumTxt.mouseEnabled = _minBtn.enable = _maxBtn.enable = false;
         _vipOpenView = new NewVipOpenView(202,refreshSwitchView);
         addChild(_bgLeft);
         addChild(_bgRight);
         _bgRight.x = _bgLeft.x + 2 * _bgLeft.width;
         _bgRight.scaleX = -1;
         addChild(_goodBgLeft);
         addChild(_goodBgRight);
         _goodBgRight.x = _goodBgLeft.x + 2 * _goodBgLeft.width;
         _goodBgRight.scaleX = -1;
         addChild(_selectTxtBg);
         addChild(_switchBtn);
         _switchBtn.enable = false;
         _switchBtn.x = 218;
         addChild(_switchBack);
         addChild(_equip);
         addChild(_switchEquipBg);
         _switchEquipBg.mouseEnabled = false;
         _switchEquipBg.mouseChildren = true;
         _switchEquipBg.x = 167;
         _switchEquipBg.y = 20;
         _equip.sonType = -1;
         addChild(_neededGold);
         _neededGold.x = 47;
         _neededGold.y = 260;
         addChild(_neededGoldTxt);
         _neededGoldTxt.text = "0";
         _neededGoldTxt.x = 134;
         _neededGoldTxt.y = 258;
         addChild(_neededGoldTxt2);
         addChild(_discountImg);
         addChild(_discountTxt);
         addChild(_discountLine);
         addChild(_vipOpenView);
         _vipOpenView.x = 195;
         _vipOpenView.y = 242;
         _neededGoldTxt2.visible = false;
         _discountImg.visible = discount != 1;
         _discountTxt.visible = discount != 1;
         _vipOpenView.visible = discount == 1;
         _discountTxt.text = LanguageMgr.GetTranslation("store.switched.SwitchView.discount.txt",getDiscount(discount));
         _discountLine.visible = false;
         addChild(_numBg);
         addChild(_reduceBtn);
         addChild(_addBtn);
         addChild(_composeNumTxt);
         addChild(_minBtn);
         addChild(_maxBtn);
         _itemDic = new SimpleDictionary(true);
         _itemDic.add("0_0_0",_equip);
         _itemList = new Vector.<SwitchItem>();
         _loc2_ = 0;
         while(_loc2_ < 8)
         {
            _loc1_ = new SwitchItem();
            addChild(_loc1_);
            _loc1_.x = int(_loc2_ % 4) * (_loc1_.width + 10) + 77;
            _loc1_.y = int(_loc2_ / 4) * (_loc1_.height - 5) + 137;
            _itemList.push(_loc1_);
            _loc2_++;
         }
         if(VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            _discountImg.tipData = {};
         }
      }
      
      private function getDiscount(param1:Number) : String
      {
         var _loc3_:* = null;
         var _loc2_:Number = NaN;
         if(param1 < 1)
         {
            _loc2_ = param1 * 100;
            return 100 - _loc2_ + "";
         }
         return "";
      }
      
      private function addEvent() : void
      {
         _switchBtn.addEventListener("click",__switchClick);
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _reduceBtn.addEventListener("click",onReduceClick);
         _addBtn.addEventListener("click",onAddBtnClick);
         _composeNumTxt.addEventListener("change",onComposeNumChange);
         _minBtn.addEventListener("click",onMinClick);
         _maxBtn.addEventListener("click",onMaxClick);
      }
      
      private function removeEvent() : void
      {
         _switchBtn.removeEventListener("click",__switchClick);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         _reduceBtn.removeEventListener("click",onReduceClick);
         _addBtn.removeEventListener("click",onAddBtnClick);
         _composeNumTxt.removeEventListener("change",onComposeNumChange);
         _minBtn.removeEventListener("click",onMinClick);
         _maxBtn.removeEventListener("click",onMaxClick);
      }
      
      private function onReduceClick(param1:MouseEvent) : void
      {
         if(_currentGoodsInfo == null)
         {
            return;
         }
         if(_currentGoodsInfo.count <= 1)
         {
            return;
         }
         _currentGoodsInfo.count -= 1;
         refreshSwitchView(_currentGoodsInfo);
         _itemList[_selectIndex].dispatchEvent(new MouseEvent("click"));
      }
      
      private function onAddBtnClick(param1:MouseEvent) : void
      {
         if(_currentGoodsInfo == null)
         {
            return;
         }
         if(_currentGoodsInfo.count >= _maxCount)
         {
            return;
         }
         _currentGoodsInfo.count += 1;
         refreshSwitchView(_currentGoodsInfo);
         _itemList[_selectIndex].dispatchEvent(new MouseEvent("click"));
      }
      
      private function onMinClick(param1:MouseEvent) : void
      {
         if(_currentGoodsInfo == null)
         {
            return;
         }
         if(_currentGoodsInfo.count <= 1)
         {
            return;
         }
         _currentGoodsInfo.count = 1;
         refreshSwitchView(_currentGoodsInfo);
         _itemList[_selectIndex].dispatchEvent(new MouseEvent("click"));
      }
      
      private function onMaxClick(param1:MouseEvent) : void
      {
         if(_currentGoodsInfo == null)
         {
            return;
         }
         if(_currentGoodsInfo.count >= _maxCount)
         {
            return;
         }
         _currentGoodsInfo.count = _maxCount;
         refreshSwitchView(_currentGoodsInfo);
         _itemList[_selectIndex].dispatchEvent(new MouseEvent("click"));
      }
      
      private function onComposeNumChange(param1:Event) : void
      {
         var _loc2_:int = int(_composeNumTxt.text);
         if(_loc2_ == 0)
         {
            _loc2_ = 1;
         }
         if(_loc2_ >= _maxCount)
         {
            _loc2_ = _maxCount;
         }
         _currentGoodsInfo.count = _loc2_;
         refreshSwitchView(_currentGoodsInfo);
         _itemList[_selectIndex].dispatchEvent(new MouseEvent("click"));
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      private function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            setMaxCount(_loc3_,_loc3_.count);
            _loc3_.count = 1;
            _loc2_.data = _loc3_;
            _currentGoodsInfo = _loc2_.data;
            refreshSwitchView(_loc2_.data);
            _selectIndex = 0;
         }
      }
      
      private function setMaxCount(param1:GoodsInfo, param2:int) : void
      {
         var _loc3_:SwitchGoodsTemplete = TempleteManager.instance.transformBackTemplateCate.getTemplateByID(param1.templateInfo.TransformId);
         var _loc4_:int = _loc3_.CostGold * param2 * discount;
         _maxCount = param2;
         if(_loc4_ > ResourceManager.instance.gold.count)
         {
            _maxCount = ResourceManager.instance.gold.count / (_loc3_.CostGold * discount);
         }
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            _currentGoodsInfo = _loc2_.data;
            refreshSwitchView(_loc2_.data);
         }
      }
      
      private function refreshSwitchView(param1:GoodsInfo = null) : void
      {
         var _loc2_:SwitchGoodsTemplete = null;
         var _loc4_:BaseItemView = null;
         var _loc7_:int = 0;
         var _loc3_:SwitchItem = null;
         _currentItem = null;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         if(param1 && param1.templateInfo.TransformId > 0)
         {
            _loc5_ = int(param1.count);
            _loc2_ = TempleteManager.instance.transformBackTemplateCate.getTemplateByID(param1.templateInfo.TransformId);
            _neededGoldTxt.text = _loc2_.CostGold * _loc5_ + "";
            _neededGoldTxt2.text = int(_loc2_.CostGold * _loc5_ * discount) + "";
            _discountTxt.text = LanguageMgr.GetTranslation("store.switched.SwitchView.discount.txt",getDiscount(discount));
            _neededGoldTxt2.visible = discount != 1;
            _discountLine.visible = discount != 1;
            _discountLine.width = _neededGoldTxt.textWidth + 5;
            _loc4_ = _itemDic[param1.pos + "_" + param1.objectId + "_" + param1.bagType];
            _loc4_.data = param1;
         }
         else
         {
            _neededGoldTxt.text = "0";
            _neededGoldTxt2.visible = false;
            _discountLine.visible = false;
            _switchBtn.enable = false;
            _reduceBtn.enable = _addBtn.enable = _composeNumTxt.mouseEnabled = _maxBtn.enable = _minBtn.enable = false;
            _composeNumTxt.text = "";
         }
         _discountImg.visible = discount != 1;
         _discountTxt.visible = discount != 1;
         _vipOpenView.visible = discount == 1;
         _loc7_ = 1;
         while(_loc7_ < 9)
         {
            _loc3_ = _itemList[_loc6_];
            _loc3_.stop();
            if(_loc3_.templeteId > 0)
            {
               _loc3_.removeEventListener("click",__itemClick);
            }
            if(_loc2_ && _loc2_["Material" + _loc7_] != param1.templateId)
            {
               _loc3_.data = _loc2_["Material" + _loc7_];
               _loc3_.count = _loc5_;
               _loc3_.parentTemId = param1.templateId;
               _loc3_.addEventListener("click",__itemClick);
               if(!_currentItem)
               {
                  _currentItem = _loc3_;
                  _currentItem.play();
               }
            }
            else
            {
               _loc3_.data = 0;
               if(_loc2_ && _loc2_["Material" + _loc7_] == param1.templateId)
               {
                  _loc6_--;
               }
            }
            _loc6_++;
            _loc7_++;
         }
         if(_currentItem)
         {
            _switchBtn.enable = true;
            _reduceBtn.enable = _addBtn.enable = _composeNumTxt.mouseEnabled = _maxBtn.enable = _minBtn.enable = true;
            _composeNumTxt.text = param1.count.toString();
         }
      }
      
      private function __itemClick(param1:MouseEvent) : void
      {
         if(_currentItem.templeteId == (param1.currentTarget as SwitchItem).templeteId)
         {
            return;
         }
         _currentItem.stop();
         _currentItem = param1.currentTarget as SwitchItem;
         _currentItem.play();
         _selectIndex = _itemList.indexOf(_currentItem);
      }
      
      private function __switchClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(int(int(_neededGoldTxt.text) * discount) > ResourceManager.instance.gold.count)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         var _loc3_:GoodsInfo = GoodsManager.instance.getHideBagItemByPos(0);
         if(!_loc3_.isBinds)
         {
            sendSwitch();
         }
         else
         {
            StoreSocketOutManager.sendSwitch(_currentItem.parentTemId,_currentItem.templeteId,_currentGoodsInfo.count);
            _switchBtn.enable = false;
         }
      }
      
      private function get discount() : Number
      {
         var _loc1_:Number = NaN;
         var _loc3_:int = 0;
         if(!VIPManager.Instance.model.vipInfo.IsVipAndNoExpirt)
         {
            return 1;
         }
         var _loc2_:int = int(VIPManager.Instance.model.vipInfo.VipGrade);
         var _loc4_:Array = TempleteManager.instance.vipPrerogativeTemplateCate.getVipPrerogativeTypeTempList(202);
         _loc3_ = 0;
         while(_loc3_ < _loc4_.length)
         {
            if(_loc4_[_loc3_].grade == _loc2_)
            {
               _loc1_ = Number(_loc4_[_loc3_].para1);
            }
            _loc3_++;
         }
         return _loc1_ / 100;
      }
      
      public function sendSwitch() : void
      {
         if(showSwitchAlert(switchAlertBack))
         {
            return;
         }
         StoreSocketOutManager.sendSwitch(_currentItem.parentTemId,_currentItem.templeteId,_currentItem.count);
      }
      
      private function showSwitchAlert(param1:Function = null) : Boolean
      {
         var _loc3_:Date = SharedManager.instance.storeSwitchCheckDate;
         var _loc4_:Date = new Date();
         return false;
      }
      
      private function switchAlertBack(param1:Boolean) : void
      {
         SharedManager.instance.storeSwitch = param1;
         SharedManager.instance.storeSwitchCheckDate = new Date();
         SharedManager.instance.saveSwitchTipCheck();
         StoreSocketOutManager.sendSwitch(_currentItem.parentTemId,_currentItem.templeteId,_currentItem.count);
      }
      
      public function dispose() : void
      {
         refreshSwitchView(null);
         removeEvent();
         ObjectUtils.disposeAllChildren(this);
      }
   }
}

