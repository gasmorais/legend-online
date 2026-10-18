package store.treasure
{
   import bag.events.BagEvent;
   import cell.view.storebag.StoreResolveCell;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.StoreSocketOutManager;
   import mvc.controler.StoreControler;
   import store.resolve.ResolveNeededMaterialItem;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.ResolveTemplateInfo;
   import yishi.events.NotificationEvent;
   import yishi.events.SLGSocketEvent;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.GoodsManager;
   import yishi.manager.NotificationManager;
   import yishi.manager.TempleteManager;
   import yishi.service.managers.SocketManager;
   import yishi.utils.SimpleDictionary;
   import yishi.view.community.BaseItemView;
   
   public class TreasureResolveView extends Component
   {
      
      private static const MATENUM:int = 3;
      
      private var _bg:ScaleFrameImage;
      
      private var _promptTxtBg:Bitmap;
      
      private var _previewBg:ScaleBitmapImage;
      
      private var _previewTxtBg:Bitmap;
      
      private var _arrowsBg:Bitmap;
      
      private var _resolveBtn:IconButton;
      
      private var _resolveConsumeTxt:Bitmap;
      
      private var _mateMaterialList:Array;
      
      private var _itemDic:SimpleDictionary;
      
      private var _storeBag:TreasureStoreBag;
      
      private var _equipList:Array;
      
      public function TreasureResolveView()
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
         _bg = ComponentFactory.Instance.creatComponentByStylename("treasure.resolveViewBg");
         _previewBg = ComponentFactory.Instance.creatComponentByStylename("ResolveView1.previewBg");
         _promptTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePromptTxtBg");
         _previewTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePreviewTxtBg");
         _arrowsBg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.resolveBtn");
         _resolveConsumeTxt = ComponentFactory.Instance.creatBitmap("asset.store.resolveConsumeTxt");
         _storeBag = ComponentFactory.Instance.creatCustomObject("StoreView1.StoreBag.treasure");
         addChild(_bg);
         _bg.setFrame(1);
         addChild(_previewBg);
         addChild(_promptTxtBg);
         addChild(_previewTxtBg);
         addChild(_arrowsBg);
         _arrowsBg.rotation = 90;
         _arrowsBg.x = 270;
         _arrowsBg.y = 140;
         addChild(_resolveBtn);
         _resolveBtn.enable = false;
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
         while(_loc3_ < 3)
         {
            _loc2_ = new ResolveNeededMaterialItem();
            addChild(_loc2_);
            _loc2_.x = 115 + _loc3_ * 60;
            _loc2_.y = 210;
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
         NotificationManager.instance.addEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
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
         NotificationManager.instance.removeEventListener("STORE_TREASURE_BAG_UPDATE",__treasureBagUpdateHandler);
      }
      
      private function __treasureBagUpdateHandler(param1:NotificationEvent) : void
      {
         _bg.setFrame(param1.data + 1);
         control.moveGoodsBack();
      }
      
      private function get control() : StoreControler
      {
         return FrameControllerManager.instance.storeController;
      }
      
      private function __onResolveHandler(param1:MouseEvent) : void
      {
         StoreSocketOutManager.sendTreasureResolve();
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
         var _loc9_:ResolveNeededMaterialItem = null;
         var _loc4_:int = 0;
         var _loc12_:GoodsInfo = null;
         var _loc2_:ResolveTemplateInfo = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:GoodsTemplateInfo = null;
         var _loc10_:int = 0;
         var _loc7_:SimpleDictionary = null;
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc9_ = _mateMaterialList[_loc4_];
            _loc9_.materialCount = 0;
            _loc9_.setData(0,false);
            _loc9_.BindsType = false;
            _loc4_++;
         }
         var _loc11_:SimpleDictionary = new SimpleDictionary();
         _loc4_ = 0;
         while(_loc4_ < _equipList.length)
         {
            if(_equipList[_loc4_].data)
            {
               _loc12_ = _equipList[_loc4_].data;
               _loc2_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(4,_loc12_.templateId);
               if(_loc2_)
               {
                  _loc6_ = 1;
                  while(_loc6_ <= 4)
                  {
                     _loc3_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_["Item" + _loc6_]);
                     if(_loc3_)
                     {
                        if(_loc11_[_loc2_["Item" + _loc6_]])
                        {
                           _loc10_ = int(_loc11_[_loc2_["Item" + _loc6_]]);
                           _loc11_.add(_loc2_["Item" + _loc6_],_loc10_ + _loc12_.count * _loc2_["Count" + _loc6_]);
                        }
                        else
                        {
                           _loc11_.add(_loc2_["Item" + _loc6_],_loc12_.count * _loc2_["Count" + _loc6_]);
                        }
                     }
                     _loc6_++;
                  }
               }
               if(_loc12_.strengthenGrade > 0)
               {
                  _loc7_ = TempleteManager.instance.theseusTreasureGrowupCate.getDicByIdLevel(_loc12_.templateId,_loc12_.strengthenGrade);
                  if(_loc7_.keys.length > 0)
                  {
                     for each(var _loc8_:int in _loc7_.keys)
                     {
                        if(_loc11_[_loc8_])
                        {
                           _loc10_ = int(_loc11_[_loc8_]);
                           _loc11_.add(_loc8_,_loc10_ + _loc7_[_loc8_]);
                        }
                        else
                        {
                           _loc11_.add(_loc8_,_loc7_[_loc8_]);
                        }
                     }
                  }
               }
            }
            _loc4_++;
         }
         var _loc13_:Boolean = false;
         var _loc1_:Array = _loc11_.keys;
         _loc1_.sort();
         _loc4_ = 0;
         while(_loc4_ < 3)
         {
            _loc9_ = _mateMaterialList[_loc4_];
            if(_loc1_.length <= _loc4_)
            {
               _loc9_.setData(0);
            }
            else
            {
               _loc9_.setData(_loc1_[_loc4_]);
               _loc9_.materialCount = _loc11_[_loc1_[_loc4_]];
               _loc13_ = true;
            }
            _loc4_++;
         }
         _resolveBtn.enable = _loc13_;
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
         while(_loc4_ < 3)
         {
            _loc3_ = _mateMaterialList[_loc4_];
            _loc3_.materialCount = 0;
            _loc3_.setData(0,false);
            _loc3_.BindsType = false;
            _loc4_++;
         }
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
         ObjectUtils.disposeObject(_arrowsBg);
         _arrowsBg = null;
         ObjectUtils.disposeObject(_resolveBtn);
         _resolveBtn = null;
         ObjectUtils.disposeObject(_resolveConsumeTxt);
         _resolveConsumeTxt = null;
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeObject(_previewBg);
         _previewBg = null;
         super.dispose();
      }
   }
}

