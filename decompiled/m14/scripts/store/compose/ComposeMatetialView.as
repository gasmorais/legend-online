package store.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import events.StoreEvent;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import manager.LanguageMgr;
   import managers.MountsManager;
   import managers.ShopManager;
   import mvc.module.mounts.WildSoulInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.store.ComposeGoodsInfo;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.playerinfo.ThaneInfo;
   import yishi.datas.resource.ResourceData;
   import yishi.datas.templates.ComposeGoodsTemplete;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.WarSoulTempInfo;
   import yishi.manager.ArmyManager;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.PlayerManager;
   import yishi.manager.RechargeAlertMannager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.utils.IconFactory;
   import yishi.utils.SimpleAlertHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ComposeMatetialView extends Sprite implements Disposeable
   {
      
      private var _preview:Bitmap;
      
      private var _numBg:Image;
      
      private var _neededGoldImf:Image;
      
      private var _composeBtn:IconButton;
      
      private var _promptlyBtn:IconButton;
      
      private var _reduceBtn:BaseButton;
      
      private var _addBtn:BaseButton;
      
      private var _minBtn:BaseButton;
      
      private var _maxBtn:BaseButton;
      
      private var _icon:BaseItemView;
      
      private var _preGoodsName:FilterFrameText;
      
      private var _composeNumTxt:FilterFrameText;
      
      private var _neededGoldTxt:FilterFrameText;
      
      private var _materialList:Vector.<NeededMaterialItem>;
      
      private var _data:ComposeGoodsInfo;
      
      private var _upgradeTip:FilterFrameText;
      
      private var _extendsMould:SelectedButton;
      
      private var _extendsTip:FilterFrameText;
      
      private var _extendsCostValue:FilterFrameText;
      
      private var _extendsCostIcon:Image;
      
      private var _epicTipTxt:FilterFrameText;
      
      private var tempId:String;
      
      private var jewelGrade:int;
      
      private var _noteTxt:FilterFrameText;
      
      private var _cannotGrade:int;
      
      public function ComposeMatetialView()
      {
         super();
         initView();
         addEvent();
         refreshExtendsMould();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:NeededMaterialItem = null;
         _preview = ComponentFactory.Instance.creatBitmap("asset.store.ComposePreviewTxtImg");
         _numBg = ComponentFactory.Instance.creatComponentByStylename("ComposeMatetialView.NumBg");
         _composeBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMakeBtn");
         _promptlyBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposePromptlyMakeBtn");
         _preGoodsName = ComponentFactory.Instance.creatComponentByStylename("store.ComposePreGoodsNameTxt");
         _composeNumTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeGoodsNumTxt");
         _neededGoldTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNeededGoldTxt");
         _reduceBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposePrePageBtn");
         _addBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNextPageBtn");
         _neededGoldImf = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNeededGoldTxtImg");
         _icon = ComponentFactory.Instance.creatCustomObject("store.BaseItemView");
         _extendsMould = ComponentFactory.Instance.creatComponentByStylename("store.ExtendsMouldSelectButton");
         _extendsTip = ComponentFactory.Instance.creatComponentByStylename("store.ExtendsTipTxt");
         _extendsCostValue = ComponentFactory.Instance.creatComponentByStylename("store.ExtendsCostValueTxt");
         _extendsCostIcon = ComponentFactory.Instance.creatComponentByStylename("store.ExtendsCostIcon");
         _epicTipTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeEpicTipTxt");
         _noteTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeNoteTxt");
         _minBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMinPageBtn");
         _minBtn.x = 298;
         _maxBtn = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMaxPageBtn");
         _maxBtn.x = 460;
         _composeNumTxt.text = "0";
         _neededGoldTxt.text = "--";
         _materialList = new Vector.<NeededMaterialItem>();
         var _loc2_:uint = 35;
         _loc3_ = 0;
         while(_loc3_ < 4)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.NeededMaterialItem");
            _loc1_.x = 460 + int(_loc3_ % 2) * (_loc1_.width + _loc2_);
            _loc1_.y = 48 + int(_loc3_ / 2) * (_loc1_.height + _loc2_);
            addChild(_loc1_);
            _materialList.push(_loc1_);
            _loc3_++;
         }
         var _loc4_:uint = 2;
         _epicTipTxt.x = _materialList[0].x - 8;
         _epicTipTxt.y = _materialList[0].y + _materialList[0].height + _loc4_;
         _addBtn.enable = false;
         _reduceBtn.enable = false;
         _composeBtn.enable = false;
         _promptlyBtn.enable = false;
         _promptlyBtn.visible = false;
         _minBtn.enable = false;
         _maxBtn.enable = false;
         _extendsTip.text = LanguageMgr.GetTranslation("store.compose.ComposeMatetialView.ExtendsTip");
         _extendsCostValue.text = (200).toString();
         _extendsCostIcon.setFrame(1);
         _epicTipTxt.visible = false;
         addChild(_preview);
         addChild(_icon);
         addChild(_composeBtn);
         addChild(_promptlyBtn);
         addChild(_preGoodsName);
         addChild(_numBg);
         addChild(_composeNumTxt);
         addChild(_minBtn);
         addChild(_reduceBtn);
         addChild(_addBtn);
         addChild(_maxBtn);
         addChild(_neededGoldImf);
         addChild(_neededGoldTxt);
         addChild(_extendsMould);
         addChild(_extendsTip);
         addChild(_extendsCostValue);
         addChild(_extendsCostIcon);
         addChild(_epicTipTxt);
         addChild(_noteTxt);
      }
      
      private function refreshExtendsMould() : void
      {
         var _loc1_:* = null;
         _extendsMould.visible = false;
         _extendsTip.visible = false;
         _extendsCostValue.visible = false;
         _extendsCostIcon.visible = false;
      }
      
      private function uninit() : void
      {
         _icon.data = null;
         ObjectUtils.disposeObject(_preview);
         _preview = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_reduceBtn);
         _reduceBtn = null;
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_addBtn);
         _addBtn = null;
         ObjectUtils.disposeObject(_composeNumTxt);
         _composeNumTxt = null;
         ObjectUtils.disposeObject(_composeBtn);
         _composeBtn = null;
         ObjectUtils.disposeObject(_promptlyBtn);
         _promptlyBtn = null;
         ObjectUtils.disposeObject(_neededGoldImf);
         _neededGoldImf = null;
         ObjectUtils.disposeObject(_neededGoldTxt);
         _neededGoldTxt = null;
         ObjectUtils.disposeObject(_extendsMould);
         _extendsMould = null;
         ObjectUtils.disposeObject(_extendsTip);
         _extendsTip = null;
         ObjectUtils.disposeObject(_extendsCostValue);
         _extendsCostValue = null;
         ObjectUtils.disposeObject(_extendsCostIcon);
         _extendsCostIcon = null;
         ObjectUtils.disposeObject(_epicTipTxt);
         _epicTipTxt = null;
         ObjectUtils.disposeObject(_noteTxt);
         _noteTxt = null;
         ObjectUtils.disposeObject(_minBtn);
         _minBtn = null;
         ObjectUtils.disposeObject(_maxBtn);
         _maxBtn = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get gold() : ResourceData
      {
         return ResourceManager.instance.gold;
      }
      
      private function addEvent() : void
      {
         _composeNumTxt.addEventListener("change",__onNumTxtChange);
         _composeBtn.addEventListener("click",__onComposeClickHandler);
         _promptlyBtn.addEventListener("click",__onComposeClickHandler);
         model.addEventListener("UPDATE_COMPOSE_SELECTED_CELL",__refreshPreviewGoods);
         model.addEventListener("COMPOSE_COMPLETE",refreshMaterials);
         model.addEventListener("UPDATE_COMPOSE_MAX_COUNT",__refreshMakeCount);
         NotificationManager.instance.addEventListener("UPDATE_COMPOSE_TEMP_LIST",__onTempListUpdate);
         _reduceBtn.addEventListener("click",__onBtnClickHandler);
         _addBtn.addEventListener("click",__onBtnClickHandler);
         _minBtn.addEventListener("click",__onBtnClickHandler);
         _maxBtn.addEventListener("click",__onBtnClickHandler);
      }
      
      private function removeEvent() : void
      {
         _composeNumTxt.removeEventListener("change",__onNumTxtChange);
         _composeBtn.removeEventListener("click",__onComposeClickHandler);
         _promptlyBtn.removeEventListener("click",__onComposeClickHandler);
         model.removeEventListener("UPDATE_COMPOSE_SELECTED_CELL",__refreshPreviewGoods);
         model.removeEventListener("COMPOSE_COMPLETE",refreshMaterials);
         model.removeEventListener("UPDATE_COMPOSE_MAX_COUNT",__refreshMakeCount);
         NotificationManager.instance.removeEventListener("UPDATE_COMPOSE_TEMP_LIST",__onTempListUpdate);
         _reduceBtn.removeEventListener("click",__onBtnClickHandler);
         _addBtn.removeEventListener("click",__onBtnClickHandler);
         _minBtn.removeEventListener("click",__onBtnClickHandler);
         _maxBtn.removeEventListener("click",__onBtnClickHandler);
      }
      
      private function __onNumTxtChange(param1:Event) : void
      {
         FrameControllerManager.instance.storeController.composeNumTxtChangeHandler(int(_composeNumTxt.text),_promptlyBtn.enable);
      }
      
      private function __onBtnClickHandler(param1:Event) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("022");
         switch(param1.currentTarget)
         {
            case _minBtn:
               _loc2_ = 1;
               break;
            case _reduceBtn:
               _loc2_ = 2;
               break;
            case _addBtn:
               _loc2_ = 3;
               break;
            case _maxBtn:
               _loc2_ = 4;
               break;
            default:
               _loc2_ = 0;
         }
         FrameControllerManager.instance.storeController.setComposeCount(_loc2_,_promptlyBtn.enable);
      }
      
      private function __onComposeClickHandler(param1:Event) : void
      {
         var _loc13_:String = null;
         var _loc10_:String = null;
         var _loc18_:Object = null;
         var _loc16_:WildSoulInfo = null;
         var _loc7_:int = 0;
         SoundManager.instance.play("022");
         _composeBtn.enable = false;
         _promptlyBtn.enable = false;
         if(param1.currentTarget == _promptlyBtn)
         {
            model.autoBuy = true;
         }
         else if(param1.currentTarget == _composeBtn)
         {
            model.autoBuy = false;
         }
         if(ResourceManager.instance.gold.count < model.currentComposeCount * model.selectedCompose.template.NeedGold)
         {
            _loc13_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc13_);
            setComposeBtn();
            return;
         }
         var _loc14_:String = LanguageMgr.GetTranslation("public.confirm");
         var _loc2_:String = LanguageMgr.GetTranslation("public.cancel");
         var _loc19_:String = LanguageMgr.GetTranslation("public.prompt");
         if(_data.template.Types == 3 || _data.template.Types == 6)
         {
            _loc18_ = needCountGrmMulti(model.currentComposeCount);
            if(_loc18_ && _loc18_.point > 0 && _loc18_.count > 0 && _loc18_.discountPoint > 0)
            {
               if(!model.autoBuy)
               {
                  _loc13_ = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip04");
                  MessageTipManager.instance().show(_loc13_);
               }
               else
               {
                  SimpleAlertHelper.instance.data = [sendCompose,_loc18_.discountPoint];
                  _loc10_ = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip01",_loc18_.point,_loc18_.count);
                  if(_loc18_.discount < 1)
                  {
                     _loc10_ += LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip02",int(_loc18_.point - _loc18_.discountPoint));
                  }
                  SimpleAlertHelper.instance.popAlerFrame(_loc19_,_loc10_,_loc14_,_loc2_,true,true,true,2,"USEBINDPOINT_ALERT",195,"",null,"SimpleAlert",_loc18_.discountPoint,400);
               }
               return;
            }
         }
         var _loc4_:ComposeGoodsTemplete = data.template;
         var _loc9_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_.NewMaterial);
         var _loc11_:int = _data.template.Count1 * parseInt(_composeNumTxt.text);
         var _loc3_:int = getCount(_data.template.Material1);
         var _loc12_:int = _data.template.Count2 * parseInt(_composeNumTxt.text);
         var _loc5_:int = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_data.template.Material2));
         var _loc15_:int = _data.template.Count3 * parseInt(_composeNumTxt.text);
         var _loc6_:int = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_data.template.Material3));
         var _loc17_:int = _data.template.Count4 * parseInt(_composeNumTxt.text);
         var _loc8_:int = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_data.template.Material4));
         if(_loc11_ > _loc3_ || _loc12_ > _loc5_ || _loc15_ > _loc6_ || _loc17_ > _loc8_)
         {
            if(_loc9_ && _loc9_.SonType != 205 && _loc9_.SonType != 228 && _loc9_.SonType != 312 && _loc9_.SonType != 670 && _loc9_.SonType != 693 && _loc9_.SonType != 720)
            {
               _loc13_ = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip04");
               MessageTipManager.instance().show(_loc13_);
               return;
            }
         }
         if(_loc9_ && _loc9_.SonType == 218)
         {
            _loc16_ = MountsManager.instance.avatarList.getWildSoulInfo(_loc9_.Property1);
            if(_loc16_ && _loc16_.validity < 0 && _loc9_.Property2 < 0 && _loc9_.Refresh == -1)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("shop.view.frame.BuyFrameI.mopupexitst02"));
               _composeBtn.enable = true;
               return;
            }
         }
         if(_extendsMould.visible)
         {
            if(!_extendsMould.selected)
            {
               SimpleAlertHelper.instance.data = [sendCompose];
               _loc10_ = LanguageMgr.GetTranslation("store.view.compose.ComposeMatetialView.sendComposeTip03");
               SimpleAlertHelper.instance.popAlerFrame(_loc19_,_loc10_,_loc14_,_loc2_,true,true,false,1);
               return;
            }
            _loc7_ = int(PlayerManager.instance.currentPlayerModel.playerInfo.allPoint);
            if(_loc7_ < 200)
            {
               RechargeAlertMannager.show();
               _composeBtn.enable = true;
               return;
            }
         }
         sendCompose(true,false);
      }
      
      public function getCount(param1:int) : int
      {
         var _loc2_:int = 0;
         return int(_loc2_ + GoodsManager.instance.getGoodsNumByIdAndNotLockInEquipBag(param1));
      }
      
      private function needCountGrmMulti(param1:int = 1) : Object
      {
         var _loc2_:Object = null;
         var _loc4_:Number = NaN;
         var _loc5_:int = 0;
         var _loc3_:Object = {
            "point":0,
            "count":0,
            "discountPoint":0,
            "discount":1
         };
         _loc5_ = 1;
         while(_loc5_ <= 4)
         {
            if(_data.template["Material" + _loc5_] > 0)
            {
               _loc2_ = needCountGrmByMaterial(param1,_loc5_);
               if(_loc2_)
               {
                  _loc4_ = Number(ShopManager.Instance.getDiscountIntimeBuy(_loc2_.needId));
                  _loc3_["point"] += _loc2_.point;
                  _loc3_["count"] += _loc2_.count;
                  _loc3_["discountPoint"] += _loc2_.point * _loc4_;
                  if(_loc4_ < _loc3_["discount"])
                  {
                     _loc3_["discount"] = _loc4_;
                  }
               }
            }
            _loc5_++;
         }
         return _loc3_;
      }
      
      private function needCountGrmByMaterial(param1:int = 1, param2:int = 1) : Object
      {
         var _loc3_:ShopGoodsInfo = null;
         var _loc8_:ComposeGoodsTemplete = null;
         var _loc12_:int = 0;
         var _loc14_:* = null;
         var _loc9_:int = 0;
         var _loc13_:ComposeGoodsTemplete = null;
         var _loc7_:int = 0;
         var _loc5_:ComposeGoodsTemplete = null;
         var _loc6_:int = param1;
         var _loc11_:int = int(_data.template["Material" + param2]);
         var _loc16_:int = int(_data.template.NewMaterial);
         var _loc10_:int = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc11_));
         var _loc15_:int = _data.template["Count" + param2] * _loc6_;
         var _loc4_:GoodsInfo = new GoodsInfo();
         _loc4_.templateId = _loc11_;
         if(_loc4_.templateInfo.SonType == 212)
         {
            if(_loc10_ < _loc15_)
            {
               _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_loc11_);
               _loc8_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc16_);
               if(!_loc3_)
               {
                  return null;
               }
               _loc6_ = _loc15_ - _loc10_;
               _loc12_ = _loc10_ / _loc8_["Count" + param2];
               _loc6_ -= _loc12_;
               return {
                  "point":_loc3_.price * _loc6_,
                  "count":_loc6_,
                  "name":TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc16_).TemplateName,
                  "needId":_loc16_
               };
            }
         }
         else if(_loc4_.templateInfo.SonType != 720)
         {
            if(_loc4_.templateInfo.SonType == 312)
            {
               _loc9_ = 0;
               while(_loc9_ <= 11)
               {
                  if(_loc10_ >= _loc15_)
                  {
                     return null;
                  }
                  _loc13_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc11_);
                  if(!_loc13_)
                  {
                     _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_loc16_);
                     _loc8_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc16_);
                     if(!_loc8_ || !_loc3_)
                     {
                        return null;
                     }
                     _loc12_ = _loc10_ / _loc8_.Count1;
                     _loc6_ -= _loc12_;
                     return {
                        "point":_loc3_.price * _loc6_,
                        "count":_loc6_,
                        "name":TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc16_).TemplateName,
                        "needId":_loc16_
                     };
                  }
                  _loc11_ = int(_loc13_.Material1);
                  _loc6_ = _loc15_ - _loc10_;
                  _loc16_ = int(_loc13_.NewMaterial);
                  _loc10_ = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc11_));
                  _loc15_ = _loc13_.Count1 * _loc6_;
                  _loc9_++;
               }
            }
            else if(_loc4_.templateInfo.SonType == 205)
            {
               _loc7_ = 0;
               while(_loc7_ <= 11)
               {
                  if(_loc10_ >= _loc15_)
                  {
                     return null;
                  }
                  _loc5_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc11_);
                  if(!_loc5_)
                  {
                     _loc3_ = TempleteManager.instance.getShopTempInfoByItemId(_loc16_);
                     _loc8_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc16_);
                     if(!_loc8_ || !_loc3_)
                     {
                        return null;
                     }
                     _loc12_ = _loc10_ / _loc8_.Count1;
                     _loc6_ -= _loc12_;
                     return {
                        "point":_loc3_.price * _loc6_,
                        "count":_loc6_,
                        "name":TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc16_).TemplateName,
                        "needId":_loc16_
                     };
                  }
                  _loc11_ = int(_loc5_.Material1);
                  _loc6_ = _loc15_ - _loc10_;
                  _loc16_ = int(_loc5_.NewMaterial);
                  _loc10_ = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc11_));
                  _loc15_ = _loc5_.Count1 * _loc6_;
                  _loc7_++;
               }
            }
         }
         return null;
      }
      
      private function needCountGrm(param1:int = 1) : Object
      {
         var _loc10_:int = 0;
         var _loc3_:ComposeGoodsTemplete = null;
         var _loc4_:ShopGoodsInfo = null;
         var _loc11_:ComposeGoodsTemplete = null;
         var _loc6_:int = 0;
         var _loc7_:* = null;
         var _loc8_:int = param1;
         var _loc5_:int = int(_data.template.Material1);
         var _loc12_:int = int(_data.template.NewMaterial);
         var _loc2_:int = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc5_));
         var _loc9_:int = _data.template.Count1 * _loc8_;
         _loc10_ = 0;
         while(_loc10_ < 11)
         {
            if(_loc2_ >= _loc9_)
            {
               return null;
            }
            _loc3_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc5_);
            if(!_loc3_)
            {
               _loc4_ = TempleteManager.instance.getShopTempInfoByItemId(_loc12_);
               _loc11_ = TempleteManager.instance.getComposeTempleteByTempleteId(_loc12_);
               if(!_loc11_ || !_loc4_)
               {
                  return null;
               }
               _loc6_ = _loc2_ / _loc11_.Count1;
               _loc8_ -= _loc6_;
               return {
                  "point":_loc4_.price * _loc8_,
                  "count":_loc8_,
                  "name":TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc12_).TemplateName,
                  "needId":_loc12_
               };
            }
            _loc5_ = int(_loc3_.Material1);
            _loc8_ = _loc9_ - _loc2_;
            _loc12_ = int(_loc3_.NewMaterial);
            _loc2_ = int(GoodsManager.instance.getGoodsNumByTempIdAndNotLock(_loc5_));
            _loc9_ = _loc3_.Count1 * _loc8_;
            _loc10_++;
         }
         return null;
      }
      
      private function sendCompose(param1:Boolean, param2:Boolean, param3:int = 0) : void
      {
         FrameControllerManager.instance.storeController.useBind = param2;
         FrameControllerManager.instance.storeController.extendsMould = _extendsMould.selected;
         if(param1)
         {
            FrameControllerManager.instance.storeController.sendCompose(param2,_extendsMould.selected);
         }
         else
         {
            setComposeBtn();
         }
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      public function get data() : ComposeGoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:ComposeGoodsInfo) : void
      {
         var _loc3_:Array = null;
         var _loc2_:WarSoulTempInfo = null;
         var _loc4_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc3_ = [361,362,363,364,365,366,367,368,369];
            if(_loc3_.indexOf(_data.template.Types) != -1)
            {
               _loc2_ = TempleteManager.instance.warsoulCate.getTempInfoById(_data.template.NewMaterial);
               _icon.icon.icon = IconFactory.getTheseusWarSoulIcon(_loc2_.Icon);
               _icon.icon.tipData = null;
               _preGoodsName.text = _loc2_.Name;
            }
            else
            {
               _loc4_ = new GoodsInfo();
               _loc4_.templateId = _data.template.NewMaterial;
               _icon.data = _loc4_;
               _icon.buttonMode = false;
               _preGoodsName.text = _loc4_.templateInfo.TemplateName;
            }
            refreshMaterials();
            _neededGoldTxt.text = (_data.template.NeedGold * model.currentComposeCount).toString();
            refreshSelectedCompose();
            setNoteWord();
         }
         else
         {
            clear();
         }
         refreshExtendsMould();
      }
      
      private function clear() : void
      {
         var _loc1_:int = 0;
         _icon.data = null;
         _preGoodsName.text = "";
         _composeNumTxt.text = "0";
         _neededGoldTxt.text = "--";
         _noteTxt.text = "";
         _addBtn.enable = false;
         _reduceBtn.enable = false;
         _minBtn.enable = false;
         _maxBtn.enable = false;
         setComposeBtn();
         _loc1_ = 0;
         while(_loc1_ < _materialList.length)
         {
            _materialList[_loc1_].setData(0,0,0);
            _loc1_++;
         }
         _epicTipTxt.visible = false;
      }
      
      private function refreshMaterials(param1:StoreEvent = null) : void
      {
         var _loc2_:int = 0;
         if(!_data)
         {
            return;
         }
         tempId = String(_data.template.NewMaterial);
         jewelGrade = int(tempId.substring(tempId.length - 2));
         _loc2_ = 0;
         while(_loc2_ < _materialList.length)
         {
            _materialList[_loc2_].setData(_data.template["Material" + (_loc2_ + 1)],_data.template["Count" + (_loc2_ + 1)],_data["ownCount" + (_loc2_ + 1)],_data.template.NewMaterial);
            _loc2_++;
         }
         __refreshMakeCount(null);
      }
      
      public function refreshSelectedCompose() : void
      {
         var _loc2_:GoodsInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc1_:GoodsInfo = null;
         if(!_data)
         {
            return;
         }
         if(!_data.template)
         {
            return;
         }
         _loc2_ = new GoodsInfo();
         _loc2_.templateId = _data.template.Material1;
         if(!_loc2_)
         {
            return;
         }
         if(!_loc2_.isViceEquip)
         {
            return;
         }
         _loc3_ = GoodsManager.instance.getBagGoodsStrengthenMaxByTemplateId(_loc2_.templateId)[0];
         if(!_loc3_)
         {
            return;
         }
         if(!_loc3_.isViceEquip)
         {
            return;
         }
         _loc1_ = GoodsManager.instance.getHideBagItemByPos(0);
         if(_loc1_)
         {
            if(_loc1_.templateId == _loc3_.templateId && _loc1_.strengthenGrade == _loc3_.strengthenGrade)
            {
               return;
            }
         }
         PlayerManager.instance.moveBagToBag(_loc3_.bagType,_loc3_.objectId,_loc3_.pos,0,0,0,1);
      }
      
      private function __refreshPreviewGoods(param1:StoreEvent) : void
      {
         data = model.selectedCompose;
      }
      
      private function __refreshMakeCount(param1:StoreEvent) : void
      {
         setComposeBtn();
         if(_data)
         {
            _composeNumTxt.text = model.currentComposeCount.toString();
            _neededGoldTxt.text = (_data.template.NeedGold * model.currentComposeCount).toString();
            if(model.currentComposeCount <= 1)
            {
               _reduceBtn.enable = false;
               _minBtn.enable = false;
            }
            else
            {
               _reduceBtn.enable = true;
               _minBtn.enable = true;
            }
            if(_promptlyBtn.enable)
            {
               if(model.currentComposeCount == 9)
               {
                  _addBtn.enable = false;
                  _maxBtn.enable = false;
               }
               else
               {
                  _addBtn.enable = true;
                  _maxBtn.enable = true;
               }
            }
            else if(model.currentComposeCount >= _data.canMakeCount)
            {
               _addBtn.enable = false;
               _maxBtn.enable = false;
            }
            else
            {
               _addBtn.enable = true;
               _maxBtn.enable = true;
            }
            if(_data.template.Types != 5)
            {
               removeUpgrade();
            }
            else
            {
               createUpgrade();
            }
         }
         else
         {
            createUpgrade();
         }
      }
      
      private function __onTempListUpdate(param1:StoreEvent) : void
      {
         setComposeBtn();
      }
      
      private function get thane() : ThaneInfo
      {
         return ArmyManager.instance.thane;
      }
      
      private function setComposeBtn() : void
      {
         var _loc1_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         if(!_data || model.selectedCompose && model.selectedCompose.canMakeCount == 0)
         {
            _composeBtn.enable = false;
         }
         else
         {
            _composeBtn.enable = true;
         }
         var _loc2_:Array = [361,362,363,364,365,366,367,368,369];
         if(_data && _loc2_.indexOf(_data.template.Types) == -1)
         {
            _loc1_ = int(_data.template.NewMaterial);
            _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_);
            if(_loc3_.NeedChangeJob == 1 && thane.vocationIndex == 0)
            {
               _composeBtn.enable = false;
            }
            if(_loc3_.NeedChangeJob == 2 && thane.vocationIndex < 3)
            {
               _composeBtn.enable = false;
            }
         }
         var _loc4_:GoodsInfo = new GoodsInfo();
         if(_data && _data.template)
         {
            _loc4_.templateId = _data.template.NewMaterial;
         }
         if(_data && _data.template.Types == 3)
         {
            _cannotGrade = 2;
         }
         else if(_data && _data.template.Types == 6)
         {
            _cannotGrade = 1;
         }
         if(_data && (model.selectedCompose && model.selectedCompose.canMakeCount == 0 && _data.template.Types == 3) && jewelGrade != _cannotGrade)
         {
            _promptlyBtn.visible = true;
            _promptlyBtn.enable = true;
            _composeBtn.x = 295;
         }
         else if(_data && (model.selectedCompose && model.selectedCompose.canMakeCount == 0 && _data.template.Types == 6) && jewelGrade != _cannotGrade)
         {
            _promptlyBtn.visible = true;
            _promptlyBtn.enable = true;
            _composeBtn.x = 295;
         }
         else if(_data && _data.template.Types == 3 && jewelGrade != _cannotGrade)
         {
            _promptlyBtn.visible = true;
            _promptlyBtn.enable = false;
            _composeBtn.x = 295;
         }
         else if(_data && _data.template.Types == 6 && jewelGrade != _cannotGrade)
         {
            _promptlyBtn.visible = true;
            _promptlyBtn.enable = false;
            _composeBtn.x = 295;
         }
         else if(_data && jewelGrade == _cannotGrade)
         {
            if(model.selectedCompose && model.selectedCompose.canMakeCount == 0)
            {
               _addBtn.enable = false;
            }
            _promptlyBtn.visible = false;
            _promptlyBtn.enable = false;
            _composeBtn.x = 410;
         }
         else
         {
            _promptlyBtn.visible = false;
            _promptlyBtn.enable = false;
            _composeBtn.x = 410;
         }
      }
      
      private function createUpgrade() : void
      {
         _composeNumTxt.visible = false;
         _numBg.visible = false;
         _reduceBtn.visible = false;
         _addBtn.visible = false;
         _minBtn.visible = false;
         _maxBtn.visible = false;
      }
      
      private function removeUpgrade() : void
      {
         _composeNumTxt.visible = true;
         _numBg.visible = true;
         _reduceBtn.visible = true;
         _addBtn.visible = true;
         _minBtn.visible = true;
         _maxBtn.visible = true;
      }
      
      private function setNoteWord() : void
      {
         if(_data.template.Types == 1)
         {
            _noteTxt.text = LanguageMgr.GetTranslation("store.compose.ComposeMatetialView.noteTxt1");
         }
         else if(_data.template.Types == 5)
         {
            _noteTxt.text = LanguageMgr.GetTranslation("store.compose.ComposeMatetialView.noteTxt2");
         }
         else
         {
            _noteTxt.text = "";
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

