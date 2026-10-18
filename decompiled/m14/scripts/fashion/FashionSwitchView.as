package fashion
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.fashion.FashionInfoMsg;
   import events.FashionEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.Dictionary;
   import manager.LanguageMgr;
   import managers.FashionManager;
   import mvc.module.fashion.FashionModel;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.SharedManager;
   
   public class FashionSwitchView extends Sprite implements Disposeable
   {
      
      private var _bg:MutipleImage;
      
      private var _preBtn:BaseButton;
      
      private var _nextBtn:BaseButton;
      
      private var _pageBack:Bitmap;
      
      private var _pageText:FilterFrameText;
      
      private var _total:int;
      
      private var _current:int = 1;
      
      private var _btnGroup:SelectedButtonGroup;
      
      private var _weaponBtn:SelectedButton;
      
      private var _clothesBtn:SelectedButton;
      
      private var _hatBtn:SelectedButton;
      
      private var _wingBtn:SelectedButton;
      
      private var _saveBtn:IconButton;
      
      private var _tipsBtn:MutipleImage;
      
      private var _selectedBg:Bitmap;
      
      private var _itemList:Vector.<FashionSwitchItem>;
      
      private var _weaponTip:TextButton;
      
      private var _clothesTip:TextButton;
      
      private var _hatTip:TextButton;
      
      private var _wingTip:TextButton;
      
      private const pageSize:int = 6;
      
      public function FashionSwitchView()
      {
         super();
         initView();
         initEvent();
         FashionManager.instance.getFashionBook();
         updateView();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.bg");
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.fashion.SelectedBtnBg");
         _weaponBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.weaponBtn");
         _clothesBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.clothBtn");
         _hatBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.hatBtn");
         _wingBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.wingBtn");
         _preBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.preBtn");
         _nextBtn = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.nextBtn");
         _pageBack = ComponentFactory.Instance.creatBitmap("asset.core.PageNumBack");
         _pageText = ComponentFactory.Instance.creatComponentByStylename("fashionStoreFrame.pageText");
         _saveBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.SaveBtn");
         _tipsBtn = ComponentFactory.Instance.creatComponentByStylename("FashionSwitchView.TipsImage");
         addChild(_bg);
         addChild(_selectedBg);
         addChild(_weaponBtn);
         addChild(_clothesBtn);
         addChild(_hatBtn);
         addChild(_wingBtn);
         addChild(_preBtn);
         _preBtn.y = 416;
         _preBtn.enable = false;
         addChild(_nextBtn);
         _nextBtn.y = 416;
         _nextBtn.enable = false;
         addChild(_pageBack);
         _pageBack.x = 127;
         _pageBack.y = 415;
         addChild(_pageText);
         _pageText.text = "1/1";
         _pageText.y = 420;
         addChild(_saveBtn);
         _saveBtn.enable = false;
         addChild(_tipsBtn);
         _tipsBtn.buttonMode = false;
         _tipsBtn.tipData = LanguageMgr.GetTranslation("fashion.FashionSwitchView.saveBtn.tipData03");
         _btnGroup = new SelectedButtonGroup();
         _btnGroup.addSelectItem(_weaponBtn);
         _btnGroup.addSelectItem(_clothesBtn);
         _btnGroup.addSelectItem(_hatBtn);
         _btnGroup.addSelectItem(_wingBtn);
         _selectedBg.width = 92;
         _selectedBg.x = -9;
         _selectedBg.y = -3;
         if(fashionModel.tapNum >= 0 && fashionModel.tapNum <= 3)
         {
            _btnGroup.selectIndex = fashionModel.tapNum;
            _selectedBg.x = _btnGroup.getSelectedItem().x - 6;
         }
         else
         {
            _btnGroup.selectIndex = 0;
            _selectedBg.x = _btnGroup.getSelectedItem().x - 6;
         }
         _weaponTip = ComponentFactory.Instance.creatComponentByStylename("army.weaponTip");
         _clothesTip = ComponentFactory.Instance.creatComponentByStylename("army.clothesTip");
         _hatTip = ComponentFactory.Instance.creatComponentByStylename("army.hatTip");
         _wingTip = ComponentFactory.Instance.creatComponentByStylename("army.wingTip");
         _weaponTip.mouseEnabled = false;
         _clothesTip.mouseEnabled = false;
         _hatTip.mouseEnabled = false;
         _wingTip.mouseEnabled = false;
         addChild(_weaponTip);
         addChild(_clothesTip);
         addChild(_hatTip);
         addChild(_wingTip);
         initSwitchItem();
         refreshTips();
      }
      
      private function refreshTips() : void
      {
         var _loc1_:Dictionary = null;
         if(fashionModel.lookDragonTalkerFashion)
         {
            _loc1_ = fashionModel.dragontalkerNewFashionDic;
         }
         else
         {
            _loc1_ = fashionModel.newFashionDic;
         }
         if(_loc1_["weapon"] > 0)
         {
            _weaponTip.text = _loc1_["weapon"] + "";
            _weaponTip.visible = true;
         }
         else
         {
            _weaponTip.visible = false;
         }
         if(_loc1_["clothes"] > 0)
         {
            _clothesTip.text = _loc1_["clothes"] + "";
            _clothesTip.visible = true;
         }
         else
         {
            _clothesTip.visible = false;
         }
         if(_loc1_["hat"] > 0)
         {
            _hatTip.text = _loc1_["hat"] + "";
            _hatTip.visible = true;
         }
         else
         {
            _hatTip.visible = false;
         }
         if(_loc1_["wing"] > 0)
         {
            _wingTip.text = _loc1_["wing"] + "";
            _wingTip.visible = true;
         }
         else
         {
            _wingTip.visible = false;
         }
      }
      
      private function initSwitchItem() : void
      {
         var _loc4_:int = 0;
         var _loc1_:FashionSwitchItem = null;
         _itemList = new Vector.<FashionSwitchItem>();
         var _loc2_:int = 10;
         var _loc3_:int = 8;
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc1_ = new FashionSwitchItem();
            _itemList.push(_loc1_);
            addChild(_loc1_);
            _loc1_.x = _loc4_ % 3 * (_loc1_.width + _loc3_) - 5;
            _loc1_.y = int(_loc4_ / 3) * (_loc1_.height + _loc2_) + 48;
            _loc4_++;
         }
      }
      
      private function __receivedBookHandler(param1:FashionEvent) : void
      {
         var _loc3_:Array = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc2_:int = -1;
         if(FashionManager.instance.fashionIdentityProgress <= 3)
         {
            SharedManager.instance.fashionIdentityProgress = 4;
            _loc4_ = 0;
            while(_loc4_ < 4)
            {
               if(fashionModel.lookDragonTalkerFashion)
               {
                  _loc3_ = getCurrentDragonTalkeFashionList(_loc4_);
               }
               else
               {
                  _loc3_ = getCurrentFashionList(_loc4_);
               }
               _loc5_ = 0;
               while(_loc5_ < _loc3_.length)
               {
                  if((_loc3_[_loc5_] as GoodsTemplateInfo).TemplateId in fashionModel.bookList)
                  {
                     _btnGroup.selectIndex = _loc4_;
                     _current = int(_loc5_ / 6) + 1;
                     _loc2_ = _loc5_ % 6;
                     break;
                  }
                  _loc5_++;
               }
               if(_loc2_ >= 0)
               {
                  break;
               }
               _loc4_++;
            }
         }
         updateView();
         refreshTips();
         if(_loc2_ >= 0)
         {
            _itemList[_loc2_].flash();
         }
      }
      
      private function initEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.addEventListener("change",__btnChangeHandler);
         }
         if(_saveBtn)
         {
            _saveBtn.addEventListener("click",__saveHandler);
         }
         if(_preBtn)
         {
            _preBtn.addEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.addEventListener("click",__pageHandler);
         }
         addEventListener("FASHION_BOOK_WEAR",__wearHandler);
         FashionManager.instance.addEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
      }
      
      private function removeEvent() : void
      {
         if(_btnGroup)
         {
            _btnGroup.removeEventListener("change",__btnChangeHandler);
         }
         if(_saveBtn)
         {
            _saveBtn.removeEventListener("click",__saveHandler);
         }
         if(_preBtn)
         {
            _preBtn.removeEventListener("click",__pageHandler);
         }
         if(_nextBtn)
         {
            _nextBtn.removeEventListener("click",__pageHandler);
         }
         removeEventListener("FASHION_BOOK_WEAR",__wearHandler);
         FashionManager.instance.removeEventListener("FASHION_BOOK_RECEIVE",__receivedBookHandler);
      }
      
      private function __wearHandler(param1:FashionEvent) : void
      {
         var _loc6_:int = 0;
         var _loc3_:Boolean = Boolean(param1.data.book);
         var _loc4_:GoodsTemplateInfo = GoodsTemplateInfo(param1.data.data);
         _tipsBtn.tipData = _loc3_ ? LanguageMgr.GetTranslation("fashion.FashionSwitchView.saveBtn.tipData03") : "";
         _tipsBtn.visible = _loc3_;
         _saveBtn.enable = !_loc3_;
         if(_loc4_ == null)
         {
            return;
         }
         var _loc2_:int = int((_loc4_ as GoodsTemplateInfo).SonType);
         var _loc5_:int = int((_loc4_ as GoodsTemplateInfo).TemplateId);
         if(fashionModel.lookDragonTalkerFashion)
         {
            if(!_loc3_)
            {
               fashionModel.dragonTalkerSaveList[_loc2_] = _loc5_;
            }
            else
            {
               fashionModel.dragonTalkerSaveList[_loc2_] = 0;
            }
         }
         else if(!_loc3_)
         {
            fashionModel.saveList[_loc2_] = _loc5_;
         }
         else
         {
            fashionModel.saveList[_loc2_] = 0;
         }
         _loc6_ = 0;
         while(_loc6_ < 6)
         {
            if(_itemList[_loc6_].data && _itemList[_loc6_].data.TemplateId == _loc5_)
            {
               _itemList[_loc6_].setFrame(2);
            }
            else
            {
               _itemList[_loc6_].setFrame(1);
            }
            _loc6_++;
         }
      }
      
      private function __pageHandler(param1:MouseEvent) : void
      {
         switch(param1.currentTarget)
         {
            case _preBtn:
               if(_current >= 2)
               {
                  _current -= 1;
               }
               break;
            case _nextBtn:
               if(_current < _total)
               {
                  _current += 1;
               }
         }
         updateView();
      }
      
      private function __saveHandler(param1:MouseEvent) : void
      {
         var _loc4_:String = null;
         var _loc3_:int = 0;
         var _loc2_:FashionInfoMsg = ArmyManager.instance.fashionInfoMsg;
         if(fashionModel.lookDragonTalkerFashion)
         {
            if(fashionModel.dragonTalkerSaveList[111])
            {
               _loc2_.dragonArmAvata = fashionModel.dragonTalkerSaveList[111];
            }
            if(fashionModel.dragonTalkerSaveList[112])
            {
               _loc2_.dragonClothAvata = fashionModel.dragonTalkerSaveList[112];
            }
            if(fashionModel.dragonTalkerSaveList[110])
            {
               _loc2_.dragonHatAvata = fashionModel.dragonTalkerSaveList[110];
            }
            if(fashionModel.dragonTalkerSaveList[109])
            {
               _loc2_.dragonWingAvata = fashionModel.dragonTalkerSaveList[109];
            }
            ArmyManager.instance.sendFashionChange(_loc2_);
            for(_loc4_ in fashionModel.dragonTalkerSaveList)
            {
               fashionModel.dragonTalkerSaveList[_loc4_] = null;
               delete fashionModel.dragonTalkerSaveList[_loc4_];
            }
         }
         else
         {
            if(fashionModel.saveList[111])
            {
               _loc2_.armAvata = fashionModel.saveList[111];
            }
            if(fashionModel.saveList[112])
            {
               _loc2_.clothAvata = fashionModel.saveList[112];
            }
            if(fashionModel.saveList[110])
            {
               _loc2_.hatAvata = fashionModel.saveList[110];
            }
            if(fashionModel.saveList[109])
            {
               _loc2_.wingAvata = fashionModel.saveList[109];
            }
            ArmyManager.instance.sendFashionChange(_loc2_);
            for(_loc4_ in fashionModel.saveList)
            {
               fashionModel.saveList[_loc4_] = null;
               delete fashionModel.saveList[_loc4_];
            }
         }
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _itemList[_loc3_].setFrame(1);
            _loc3_++;
         }
         _saveBtn.enable = false;
         _tipsBtn.tipData = LanguageMgr.GetTranslation("fashion.FashionSwitchView.saveBtn.tipData03");
         _tipsBtn.visible = true;
      }
      
      private function __btnChangeHandler(param1:Event) : void
      {
         var _loc2_:SelectedButton = _btnGroup.getSelectedItem() as SelectedButton;
         _selectedBg.x = _loc2_.x - 6;
         fashionModel.tapNum = _btnGroup.selectIndex;
         _current = 1;
         updateView();
      }
      
      private function updateView() : void
      {
         var _loc1_:Array = null;
         var _loc2_:int = 0;
         if(fashionModel.lookDragonTalkerFashion)
         {
            _loc1_ = getCurrentDragonTalkeFashionList(_btnGroup.selectIndex);
         }
         else
         {
            _loc1_ = getCurrentFashionList(_btnGroup.selectIndex);
         }
         _total = int((_loc1_.length - 1) / 6) + 1;
         _preBtn.enable = _current > 1;
         _nextBtn.enable = _current < _total;
         _pageText.text = _current + "/" + _total;
         _loc2_ = 0;
         while(_loc2_ < 6)
         {
            _itemList[_loc2_].data = _loc1_[6 * (int(_current - 1)) + _loc2_];
            if(_itemList[_loc2_].data && fashionModel.isInSaveList(_itemList[_loc2_].data.TemplateId))
            {
               _itemList[_loc2_].setFrame(2);
            }
            else
            {
               _itemList[_loc2_].setFrame(1);
            }
            _loc2_++;
         }
      }
      
      private function getFashionIdentityFlashItem() : FashionSwitchItem
      {
         var _loc2_:int = 0;
         var _loc1_:FashionSwitchItem = null;
         _loc2_ = 0;
         while(_loc2_ < _itemList.length)
         {
            _loc1_ = _itemList[_loc2_];
            if(_loc1_.data)
            {
               if(_loc1_.data.TemplateId in fashionModel.bookList)
               {
                  return _loc1_;
               }
            }
            _loc2_++;
         }
         return null;
      }
      
      private function getCurrentFashionList(param1:int) : Array
      {
         var _loc2_:Array = null;
         switch(param1)
         {
            case 0:
               _loc2_ = fashionModel.playerWeaponTems;
               break;
            case 1:
               _loc2_ = fashionModel.playerClothesTems;
               break;
            case 2:
               _loc2_ = fashionModel.playerHatTems;
               break;
            case 3:
               _loc2_ = fashionModel.playerWingTems;
               break;
            default:
               _loc2_ = [];
         }
         return _loc2_;
      }
      
      private function getCurrentDragonTalkeFashionList(param1:int) : Array
      {
         var _loc2_:Array = null;
         switch(param1)
         {
            case 0:
               _loc2_ = fashionModel.dragonTalkerWeaponTems;
               break;
            case 1:
               _loc2_ = fashionModel.dragonTalkerClothesTems;
               break;
            case 2:
               _loc2_ = fashionModel.dragonTalkerHatTems;
               break;
            case 3:
               _loc2_ = fashionModel.dragonTalkerWingTems;
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
      
      public function dispose() : void
      {
         var _loc1_:String = null;
         removeEvent();
         for(_loc1_ in fashionModel.saveList)
         {
            fashionModel.saveList[_loc1_] = null;
            delete fashionModel.saveList[_loc1_];
         }
         for(_loc1_ in fashionModel.dragonTalkerSaveList)
         {
            fashionModel.dragonTalkerSaveList[_loc1_] = null;
            delete fashionModel.dragonTalkerSaveList[_loc1_];
         }
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_nextBtn);
         _nextBtn = null;
         ObjectUtils.disposeObject(_pageBack);
         _pageBack = null;
         ObjectUtils.disposeObject(_pageText);
         _pageText = null;
         ObjectUtils.disposeObject(_btnGroup);
         _btnGroup = null;
         ObjectUtils.disposeObject(_weaponBtn);
         _weaponBtn = null;
         ObjectUtils.disposeObject(_clothesBtn);
         _clothesBtn = null;
         ObjectUtils.disposeObject(_hatBtn);
         _hatBtn = null;
         ObjectUtils.disposeObject(_wingBtn);
         _wingBtn = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_preBtn);
         _preBtn = null;
         ObjectUtils.disposeObject(_saveBtn);
         _saveBtn = null;
         ObjectUtils.disposeObject(_tipsBtn);
         _tipsBtn = null;
         ObjectUtils.disposeObject(_weaponTip);
         _weaponTip = null;
         ObjectUtils.disposeObject(_clothesTip);
         _clothesTip = null;
         ObjectUtils.disposeObject(_hatTip);
         _hatTip = null;
         ObjectUtils.disposeObject(_wingTip);
         _wingTip = null;
         if(_itemList)
         {
            cleanList();
         }
         _itemList = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function cleanList() : void
      {
         while(_itemList.length > 0)
         {
            _itemList.pop().dispose();
         }
      }
   }
}

