package store
{
   import bag.events.BagEvent;
   import bag.helper.GoodsCheck;
   import cell.view.storebag.StoreResolveCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import store.resolve.ResolveNeededMaterialItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.ResourceManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class ResolveView1 extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _promptTxtBg:Bitmap;
      
      private var _previewBg:ScaleBitmapImage;
      
      private var _previewTxtBg:Bitmap;
      
      private var _goldTxtBg:Bitmap;
      
      private var _arrowsBg:Bitmap;
      
      private var _resolveBtn:IconButton;
      
      private var _resolveConsumeTxt:Bitmap;
      
      private var _resolvePointTxt:FilterFrameText;
      
      private var _mateMaterialList:Array;
      
      private var _itemDic:SimpleDictionary;
      
      private var _storeBag:StoreBagII;
      
      private var _equipList:Array;
      
      private var _price:int;
      
      public function ResolveView1()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         var _loc3_:int = 0;
         var _loc1_:StoreResolveCell = null;
         var _loc2_:ResolveNeededMaterialItem = null;
         _bg = ComponentFactory.Instance.creatBitmap("asset.ResolveView1.resolveViewBg");
         _previewBg = ComponentFactory.Instance.creatComponentByStylename("ResolveView1.previewBg");
         _promptTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePromptTxtBg");
         _previewTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePreviewTxtBg");
         _goldTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolveGoldTxtBg");
         _arrowsBg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.resolveBtn");
         _resolveConsumeTxt = ComponentFactory.Instance.creatBitmap("asset.store.resolveConsumeTxt");
         _resolvePointTxt = ComponentFactory.Instance.creatComponentByStylename("store.resolvePointTxt");
         _storeBag = ComponentFactory.Instance.creatCustomObject("StoreView1.StoreBagII");
         addChild(_bg);
         addChild(_previewBg);
         addChild(_promptTxtBg);
         addChild(_previewTxtBg);
         addChild(_goldTxtBg);
         addChild(_arrowsBg);
         _arrowsBg.rotation = 90;
         _arrowsBg.x = 270;
         _arrowsBg.y = 140;
         addChild(_resolveBtn);
         _resolveBtn.enable = false;
         addChild(_resolvePointTxt);
         _resolvePointTxt.text = _price + "";
         addChild(_storeBag);
         _storeBag.x = 378;
         _storeBag.y = 0;
         _itemDic = new SimpleDictionary(true);
         _equipList = [];
         _loc3_ = 0;
         while(_loc3_ < 12)
         {
            _loc1_ = ComponentFactory.Instance.creatCustomObject("store.resolveEquiItem");
            _loc1_.sonType = -1;
            _loc1_.x = int(_loc3_ % 6) * 55 + 20;
            _loc1_.y = int(_loc3_ / 6) * 58 + 40;
            addChild(_loc1_);
            _equipList.push(_loc1_);
            _loc1_.pos = _loc3_;
            _itemDic.add(_loc3_ + "_0_" + 0,_loc1_);
            _loc3_++;
         }
         _mateMaterialList = [];
         _loc3_ = 0;
         while(_loc3_ < 6)
         {
            _loc2_ = new ResolveNeededMaterialItem();
            addChild(_loc2_);
            _loc2_.x = 115 + _loc3_ * 60;
            _loc2_.y = 210;
            if(_loc3_ >= 3)
            {
               _loc2_.visible = false;
            }
            _mateMaterialList.push(_loc2_);
            _loc3_++;
         }
      }
      
      private function addEvent() : void
      {
         GoodsManager.instance.addEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.addEventListener("SLGSocketEvent" + 4260,__resolveResultHandler);
         _resolveBtn.addEventListener("click",__onResolveHandler);
      }
      
      private function removeEvent() : void
      {
         GoodsManager.instance.removeEventListener("UPDATE_BAG",__bagItemUpdateHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",__bagItemDeleteHandler);
         SocketManager.instance.removeEventListener("SLGSocketEvent" + 4260,__resolveResultHandler);
         if(_resolveBtn)
         {
            _resolveBtn.removeEventListener("click",__onResolveHandler);
         }
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function __onResolveHandler(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(ResourceManager.instance.gold.count < int(StringHelper.trim(_resolvePointTxt.text)))
         {
            _loc2_ = LanguageMgr.GetTranslation("public.gold");
            MessageTipManager.instance().show(_loc2_);
            return;
         }
         StoreSocketOutManager.sendResolve();
      }
      
      protected function __bagItemUpdateHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(!_loc2_)
         {
            return;
         }
         _loc2_.data = _loc3_;
         _loc2_.setItemText(_loc3_.count);
         updateView();
      }
      
      private function __bagItemDeleteHandler(param1:BagEvent) : void
      {
         var _loc3_:GoodsInfo = param1.info;
         var _loc2_:BaseItemView = _itemDic[_loc3_.pos + "_" + _loc3_.objectId + "_" + _loc3_.bagType];
         if(_loc2_)
         {
            _loc2_.data = null;
            updateView();
         }
      }
      
      private function updateView() : void
      {
         updateMateView();
      }
      
      private function updateMateView() : void
      {
         var mate:ResolveNeededMaterialItem;
         var len:int;
         var curGoodsInfo:GoodsInfo;
         var i:int;
         var temp:GoodsTemplateInfo;
         var bindsType:Boolean;
         var id:int;
         var targetTemp:GoodsTemplateInfo;
         var targetTemp2:GoodsTemplateInfo;
         var targetTemp3:GoodsTemplateInfo;
         var updateMateMaterialById:*;
         var t:int;
         _price = 0;
         var w:int = 0;
         while(w < 6)
         {
            mate = _mateMaterialList[w];
            mate.x = 115 + w * 60;
            mate.y = 220;
            mate.materialCount = 0;
            mate.setData(0,false);
            mate.BindsType = false;
            if(w >= 3)
            {
               mate.visible = false;
            }
            w = w + 1;
         }
         len = int(_equipList.length);
         i = 0;
         while(i < len)
         {
            curGoodsInfo = _equipList[i].data;
            if(curGoodsInfo != null)
            {
               updateMateMaterialById = function(param1:int):void
               {
                  var _loc2_:int = 0;
                  _loc2_ = 0;
                  while(_loc2_ < 6)
                  {
                     mate = _mateMaterialList[_loc2_];
                     if(param1 > 0 && (mate.goodsTemId == param1 && mate.BindsType == bindsType) || param1 > 0 && mate.goodsTemId == 0)
                     {
                        mate.setData(param1,bindsType);
                        mate.materialCount += mateMaterial(temp) * curGoodsInfo.count;
                        mate.BindsType = bindsType;
                        break;
                     }
                     _loc2_++;
                  }
               };
               _price += 1000 * curGoodsInfo.count;
               temp = curGoodsInfo.templateInfo;
               if(temp)
               {
                  bindsType = Boolean(curGoodsInfo.isBinds);
                  if(temp.SonType == 218)
                  {
                     id = 2120044;
                     updateMateMaterialById(id);
                  }
                  else if(temp.SonType == 228)
                  {
                     targetTemp = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_equipList[i].data.templateId);
                     id = int(targetTemp.Property5);
                     updateMateMaterialById(id);
                     id = int(targetTemp.Property6);
                     updateMateMaterialById(id);
                  }
                  else if(temp.SonType == 343)
                  {
                     targetTemp2 = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_equipList[i].data.templateId);
                     id = int(targetTemp2.Property5);
                     updateMateMaterialById(id);
                     id = int(targetTemp2.Property6);
                     updateMateMaterialById(id);
                  }
                  else if(temp.SonType == 344)
                  {
                     targetTemp3 = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_equipList[i].data.templateId);
                     id = int(targetTemp3.Property5);
                     updateMateMaterialById(id);
                     id = int(targetTemp3.Property6);
                     updateMateMaterialById(id);
                  }
                  else if(GoodsCheck.isFashion(temp))
                  {
                     id = 2120043;
                     updateMateMaterialById(id);
                  }
                  else if(temp.SonType == 626)
                  {
                     _price -= 1000 * curGoodsInfo.count;
                     id = int(temp.Refresh);
                     updateMateMaterialById(id);
                  }
                  else
                  {
                     id = int(TempleteManager.instance.goodsTemplateCate.getTemplateByID(_equipList[i].data.templateId).Refresh);
                     updateMateMaterialById(id);
                  }
               }
            }
            i = i + 1;
         }
         t = 0;
         while(t < 6)
         {
            mate = _mateMaterialList[t];
            if(_mateMaterialList[5].goodsTemId != 0)
            {
               mate.x = 30 + t * 60;
               mate.y = 220;
               if(t <= 5)
               {
                  mate.visible = true;
               }
            }
            else if(_mateMaterialList[4].goodsTemId != 0)
            {
               mate.x = 60 + t * 60;
               mate.y = 220;
               if(t <= 4)
               {
                  mate.visible = true;
               }
            }
            else if(_mateMaterialList[3].goodsTemId != 0)
            {
               mate.x = 90 + t * 60;
               mate.y = 220;
               if(t <= 3)
               {
                  mate.visible = true;
               }
            }
            t = t + 1;
         }
         _resolvePointTxt.text = _price + "";
         if(_price >= 0)
         {
            _resolveBtn.enable = true;
         }
         else
         {
            _resolveBtn.enable = false;
         }
      }
      
      private function mateMaterial(param1:GoodsTemplateInfo) : int
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         if(param1.SonType == 218 || Boolean(GoodsCheck.isFashion(param1)))
         {
            _loc2_ = int(param1.Refresh);
         }
         else if(param1.SonType == 228 || param1.SonType == 343 || param1.SonType == 344)
         {
            _loc2_ = 1;
         }
         else if(param1.SonType == 626)
         {
            _loc2_ = int(param1.Property2);
         }
         else
         {
            _loc3_ = int(param1.Profile);
            switch(_loc3_ - 2)
            {
               case 0:
                  _loc2_ = 1;
                  break;
               case 1:
                  _loc2_ = 4;
                  break;
               case 2:
                  _loc2_ = 18;
                  break;
               case 3:
                  _loc2_ = 18;
            }
         }
         return _loc2_;
      }
      
      private function __resolveResultHandler(param1:SLGSocketEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:ResolveNeededMaterialItem = null;
         var _loc2_:int = int(_equipList.length);
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _equipList[_loc4_].data = null;
            _loc4_++;
         }
         _loc4_ = 0;
         while(_loc4_ < 6)
         {
            _loc3_ = _mateMaterialList[_loc4_];
            _loc3_.x = 115 + _loc4_ * 60;
            _loc3_.y = 220;
            _loc3_.materialCount = 0;
            _loc3_.setData(-1,false);
            _loc3_.BindsType = false;
            if(_loc4_ >= 3)
            {
               _loc3_.visible = false;
            }
            _loc4_++;
         }
         _resolvePointTxt.text = "0";
         _resolveBtn.enable = false;
         _storeBag.defaultView();
      }
      
      public function defaultView() : void
      {
         _storeBag.defaultView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_promptTxtBg);
         _promptTxtBg = null;
         ObjectUtils.disposeObject(_previewTxtBg);
         _previewTxtBg = null;
         ObjectUtils.disposeObject(_goldTxtBg);
         _goldTxtBg = null;
         ObjectUtils.disposeObject(_arrowsBg);
         _arrowsBg = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_resolveConsumeTxt);
         _resolveConsumeTxt = null;
         ObjectUtils.disposeObject(_resolvePointTxt);
         _resolvePointTxt = null;
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeObject(_previewBg);
         _previewBg = null;
         super.dispose();
      }
   }
}

