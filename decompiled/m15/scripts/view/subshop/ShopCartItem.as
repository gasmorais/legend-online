package view.subshop
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.ScaleLeftRightImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.ShopManager;
   import mvc.module.shop.MainShopInfo;
   import mvc.module.shop.ShopGoodsInfo;
   import mvc.module.shop.ShopModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.PathManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ShopCartItem extends Sprite implements Disposeable
   {
      
      private var _icon:BaseItemView;
      
      private var _nameTxt:FilterFrameText;
      
      private var _priceTxt:FilterFrameText;
      
      private var _pointBmp:Bitmap;
      
      private var _bindPointBmp:Bitmap;
      
      private var _costImg:Bitmap;
      
      private var _buyNumTxt:FilterFrameText;
      
      private var _isuseBindPointBtn:SelectedCheckButton;
      
      private var _clearBtn:IconButton;
      
      private var _gap:ScaleLeftRightImage;
      
      private var _data:*;
      
      private var _shopModel:ShopModel;
      
      private var _valueIcon:ScaleFrameImage;
      
      private var _buyNum:int = 1;
      
      private var _selectedBmp:Bitmap;
      
      public function ShopCartItem()
      {
         super();
         _shopModel = ShopManager.Instance.model;
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _icon = ComponentFactory.Instance.creatCustomObject("shop.shopCart.Item");
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.nameText");
         _priceTxt = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.priceTxt");
         _pointBmp = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.pointBmp");
         _bindPointBmp = ComponentFactory.Instance.creatBitmap("asset.shop.shopCart.bindPointBmp");
         _costImg = ComponentFactory.Instance.creatBitmap("shop.shopCartItem.costImg");
         _buyNumTxt = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.buyNumTxt");
         _isuseBindPointBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.isuseBindPointBtn");
         _clearBtn = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.clearBtn");
         _gap = ComponentFactory.Instance.creatComponentByStylename("shop.shopCartItem.gap");
         _selectedBmp = ComponentFactory.Instance.creatBitmap("asset.shopcartitem.selected");
         _buyNumTxt.type = "input";
         _selectedBmp.visible = false;
         addChild(_selectedBmp);
         addChild(_icon);
         addChild(_nameTxt);
         addChild(_priceTxt);
         addChild(_pointBmp);
         addChild(_bindPointBmp);
         addChild(_costImg);
         addChild(_buyNumTxt);
         addChild(_isuseBindPointBtn);
         addChild(_clearBtn);
         addChild(_gap);
         initPointStatus();
      }
      
      private function initPointStatus() : void
      {
         _pointBmp.x = _bindPointBmp.x = 272;
         _pointBmp.y = _bindPointBmp.y = 7;
         _pointBmp.visible = _pointBmp.visible = false;
      }
      
      private function uninitView() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_priceTxt);
         _priceTxt = null;
         ObjectUtils.disposeObject(_pointBmp);
         _pointBmp = null;
         ObjectUtils.disposeObject(_bindPointBmp);
         _bindPointBmp = null;
         ObjectUtils.disposeObject(_costImg);
         _costImg = null;
         ObjectUtils.disposeObject(_buyNumTxt);
         _buyNumTxt = null;
         ObjectUtils.disposeObject(_isuseBindPointBtn);
         _isuseBindPointBtn = null;
         ObjectUtils.disposeObject(_clearBtn);
         _clearBtn = null;
         ObjectUtils.disposeObject(_gap);
         _gap = null;
         ObjectUtils.disposeObject(_selectedBmp);
         _selectedBmp = null;
      }
      
      private function initEvent() : void
      {
         if(_buyNumTxt)
         {
            _buyNumTxt.addEventListener("change",__buyNumChange);
         }
         if(_isuseBindPointBtn)
         {
            _isuseBindPointBtn.addEventListener("click",__isUserBindHandler);
         }
         if(_clearBtn)
         {
            _clearBtn.addEventListener("click",__clearBtnHandler);
         }
         addEventListener("mouseOver",__mouseOverHandler);
         addEventListener("mouseOut",__mouseOutHandler);
      }
      
      private function __mouseOverHandler(param1:MouseEvent) : void
      {
         if(_selectedBmp)
         {
            _selectedBmp.visible = true;
         }
      }
      
      private function __mouseOutHandler(param1:MouseEvent) : void
      {
         if(_selectedBmp)
         {
            _selectedBmp.visible = false;
         }
      }
      
      private function __buyNumChange(param1:Event) : void
      {
         var _loc3_:int = 0;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         if(_data.goodsInfo is ShopGoodsInfo)
         {
            _loc3_ = int((_data.goodsInfo as ShopGoodsInfo).ItemId);
            _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
            _loc2_ = int(_loc5_.SonType);
            if(_loc2_ == 218)
            {
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shop.shopcart.nubmerChange"));
               _shopModel.updateItem(_data,_isuseBindPointBtn.selected,1);
               return;
            }
         }
         _buyNum = int(_buyNumTxt.text);
         if(_data.goodsInfo.type == 2)
         {
            _loc4_ = _data.goodsInfo.limitCount - _data.goodsInfo.count;
            if(_loc4_ < _buyNum)
            {
               _buyNum = _loc4_;
            }
            _buyNum = _buyNum < 1 ? 1 : _buyNum;
            _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
            _buyNumTxt.text = _buyNum.toString();
         }
         else
         {
            _buyNum = _buyNum < 1 ? 1 : _buyNum;
            _buyNum = _buyNum > 9999 ? 9999 : _buyNum;
            _buyNumTxt.text = _buyNum.toString();
         }
         _shopModel.updateItem(_data,_isuseBindPointBtn.selected,_buyNum);
      }
      
      private function __isUserBindHandler(param1:MouseEvent) : void
      {
         if(_data.goodsInfo is ShopGoodsInfo)
         {
            if((_data.goodsInfo as ShopGoodsInfo).PayType == 2)
            {
               _shopModel.updateItem(_data,_isuseBindPointBtn.selected,_data.number);
            }
            else
            {
               _isuseBindPointBtn.selected = false;
               MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.fault"));
            }
         }
         else if(_data.goodsInfo is MainShopInfo)
         {
            _isuseBindPointBtn.selected = false;
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("view.shopFrame.buyFrameI.shopCartItem.change"));
         }
      }
      
      private function __clearBtnHandler(param1:MouseEvent) : void
      {
         _shopModel.deleteItem(_data);
      }
      
      public function set data(param1:*) : void
      {
         var _loc2_:ShopGoodsInfo = null;
         var _loc7_:GoodsInfo = null;
         var _loc9_:MainShopInfo = null;
         var _loc3_:GoodsInfo = null;
         var _loc4_:String = null;
         var _loc6_:GoodsTemplateInfo = null;
         var _loc10_:Object = null;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         _data = param1;
         if(_data.goodsInfo is ShopGoodsInfo)
         {
            _loc2_ = _data.goodsInfo as ShopGoodsInfo;
            _loc7_ = new GoodsInfo();
            _loc7_.templateId = _loc2_.ItemId;
            _icon.data = _loc7_;
            _nameTxt.text = _loc7_.templateInfo.TemplateName;
            _buyNumTxt.text = _data.number;
            _priceTxt.text = String(_loc2_.price * _data.number);
            _isuseBindPointBtn.selected = _bindPointBmp.visible = _data.isBind;
            _pointBmp.visible = !_data.isBind;
         }
         else if(_data.goodsInfo is MainShopInfo)
         {
            _loc9_ = _data.goodsInfo as MainShopInfo;
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _loc9_.templateId;
            if(_loc9_.isGift)
            {
               _icon.icon.icon = PathManager.info.REQUEST_PATH + _loc9_.url;
               _loc4_ = _loc9_.content;
               _loc6_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc9_.templateId);
               if(_loc6_ && _loc6_.SonType == 206)
               {
                  _loc4_ += "<br/><font color=\'#00ff00\'>" + _loc6_.Description + "</font>";
               }
               _loc10_ = {
                  "name":_loc9_.names,
                  "content":_loc4_
               };
               _icon.icon.tipData = _loc10_;
               _icon.icon.tipStyle = "yishi.view.tips.ShopMainTips";
               _nameTxt.text = _loc9_.names;
               _loc8_ = 0;
            }
            else
            {
               _icon.data = _loc3_;
            }
            _nameTxt.text = _loc9_.sortName;
            _buyNumTxt.text = _data.number;
            _priceTxt.text = String(_loc9_.price * _data.number);
            _isuseBindPointBtn.selected = _bindPointBmp.visible = false;
            _pointBmp.visible = true;
         }
      }
      
      private function removeEvent() : void
      {
         if(_buyNumTxt)
         {
            _buyNumTxt.removeEventListener("change",__buyNumChange);
         }
         if(_isuseBindPointBtn)
         {
            _isuseBindPointBtn.removeEventListener("click",__isUserBindHandler);
         }
         if(_clearBtn)
         {
            _clearBtn.removeEventListener("click",__clearBtnHandler);
         }
         removeEventListener("mouseOver",__mouseOverHandler);
         removeEventListener("mouseOut",__mouseOutHandler);
      }
      
      public function dispose() : void
      {
         removeEvent();
         uninitView();
      }
   }
}

