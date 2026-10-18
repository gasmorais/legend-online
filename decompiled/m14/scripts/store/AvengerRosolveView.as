package store
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import manager.LanguageMgr;
   import mvc.module.avenger.AvengerModel;
   import store.resolve.AllResolvePopFrame;
   import store.resolve.AvengerResolveItem;
   import store.resolve.ResolveNeededMaterialItem;
   import utils.LogicUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.ResolveTemplateInfo;
   import yishi.manager.AvengerManager;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class AvengerRosolveView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _previewBg:ScaleBitmapImage;
      
      private var _promptTxtBg:Bitmap;
      
      private var _previewTxtBg:Bitmap;
      
      private var _arrowsBg:Bitmap;
      
      private var _resolveBtn:IconButton;
      
      private var _allResolveBtn:IconButton;
      
      private var _cancelResolveBtn:IconButton;
      
      private var _equipAry:Array = [];
      
      private var _storeBag:AvengerStoreBag;
      
      private var propList:Vector.<AvengerResolveItem>;
      
      private var materialList:Vector.<ResolveNeededMaterialItem>;
      
      private var resolveIdCounts:String = "";
      
      private var _alert:BaseAlerFrame;
      
      public function AvengerRosolveView()
      {
         super();
         initView();
         initPropView();
         initMatertialView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.AvengerRosolveView.resolveViewBg");
         _previewBg = ComponentFactory.Instance.creatComponentByStylename("AvengerRosolveView.previewBg");
         _promptTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePromptTxtBg");
         _previewTxtBg = ComponentFactory.Instance.creatBitmap("asset.AvengerRosolveView.resolvePreviewTxtBg");
         _arrowsBg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.resolveBtn");
         _storeBag = ComponentFactory.Instance.creatCustomObject("AvengerRosolveView.StoreBag");
         _allResolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.allresolveBtn");
         _cancelResolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.cancelresolveBtn");
         addChild(_bg);
         addChild(_previewBg);
         addChild(_promptTxtBg);
         addChild(_previewTxtBg);
         addChild(_arrowsBg);
         _arrowsBg.rotation = 90;
         _arrowsBg.x = 255;
         _arrowsBg.y = 105;
         addChild(_resolveBtn);
         _resolveBtn.enable = false;
         _resolveBtn.x = 18;
         addChild(_allResolveBtn);
         addChild(_cancelResolveBtn);
         _cancelResolveBtn.visible = false;
         addChild(_storeBag);
         updateBtn();
      }
      
      private function initPropView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AvengerResolveItem = null;
         propList = new Vector.<AvengerResolveItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new AvengerResolveItem();
            _loc1_.x = int(_loc2_ % 6) * 90 + 25;
            _loc1_.y = 40;
            addChild(_loc1_);
            propList.push(_loc1_);
            _loc2_++;
         }
      }
      
      private function initMatertialView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ResolveNeededMaterialItem = null;
         materialList = new Vector.<ResolveNeededMaterialItem>();
         _loc1_ = 0;
         while(_loc1_ < 12)
         {
            _loc2_ = new ResolveNeededMaterialItem();
            _loc2_.x = int(_loc1_ % 6) * 55 + 20;
            _loc2_.y = int(_loc1_ / 6) * 58 + 175;
            addChild(_loc2_);
            materialList.push(_loc2_);
            _loc1_++;
         }
      }
      
      private function addEvent() : void
      {
         MsgMan.addObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagViewHandler);
         MsgMan.addObserver("AVENGER_STORE_BAG_UPDATE",this,__updateClientOpHandler);
         if(_resolveBtn)
         {
            _resolveBtn.addEventListener("click",__onResolveHandler);
         }
         if(_allResolveBtn)
         {
            _allResolveBtn.addEventListener("click",__onallResolveHandler);
         }
         if(_cancelResolveBtn)
         {
            _cancelResolveBtn.addEventListener("click",__oncancelResolveHandler);
         }
         MsgMan.addObserver("AVENGER_ALL_RESOLVE",this,__resolveBack);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("DEVIL_ARMOR_BAG_UPDATE",this,__updateBagViewHandler);
         MsgMan.removeObserver("AVENGER_STORE_BAG_UPDATE",this,__updateClientOpHandler);
         if(_resolveBtn)
         {
            _resolveBtn.removeEventListener("click",__onResolveHandler);
         }
         if(_allResolveBtn)
         {
            _allResolveBtn.removeEventListener("click",__onallResolveHandler);
         }
         if(_cancelResolveBtn)
         {
            _cancelResolveBtn.removeEventListener("click",__oncancelResolveHandler);
         }
         MsgMan.removeObserver("AVENGER_ALL_RESOLVE",this,__resolveBack);
      }
      
      private function __resolveBack(param1:String, param2:Object) : void
      {
         var _loc3_:Array = model.resolveBagDic1.getList();
         if(_loc3_.length <= 0 && Boolean(model.isAllResolve))
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.name3"));
         }
         if(_loc3_.length <= 0)
         {
            _allResolveBtn.visible = true;
            _cancelResolveBtn.visible = false;
            model.isAllResolve = false;
         }
         else
         {
            _allResolveBtn.visible = false;
            _cancelResolveBtn.visible = true;
         }
      }
      
      private function updateBtn() : void
      {
         _equipAry = [];
         for each(var _loc1_:GoodsInfo in model.armorBagDic)
         {
            if(_loc1_.templateInfo.SonType == 670)
            {
               _equipAry.push(_loc1_);
            }
         }
         if(_equipAry.length <= 0)
         {
            _allResolveBtn.enable = false;
         }
         else
         {
            _allResolveBtn.enable = true;
         }
      }
      
      private function __updateClientOpHandler(param1:String, param2:Object) : void
      {
         refreshClientView();
      }
      
      private function __updateBagViewHandler(param1:String, param2:Object) : void
      {
         model.resetResolveBagList();
         refreshDefaultView();
         __oncancelResolveHandler();
      }
      
      private function __oncancelResolveHandler(param1:MouseEvent = null) : void
      {
         model.isAllResolve = false;
         model.resetResolveBagList();
         MsgMan.notifyObserver("AVENGER_ALL_RESOLVE");
         MsgMan.notifyObserver("AVENGER_STORE_BAG_UPDATE");
      }
      
      private function __onallResolveHandler(param1:MouseEvent) : void
      {
         model.resetResolveBagList();
         var _loc2_:AllResolvePopFrame = ComponentFactory.Instance.creatComponentByStylename("store.resolve.AllResolvePopFrame");
         _loc2_.show();
      }
      
      private function __onResolveHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(model.isAllResolve)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc3_ = LanguageMgr.GetTranslation("public.prompt");
            _loc4_ = LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.alert",model.resolveLv,model.color,model.resolveType);
            _alert = AlertManager.Instance.simpleAlert(_loc3_,_loc4_,"",_loc2_,false,true,true);
            _alert.addEventListener("response",__alertResponseHandler);
         }
         else
         {
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("avenger.resoloveView.alert");
            SharedManagerHelper.ins.needAlert("avenger.resoloveView.alert",resolveConfirmHandler,_loc3_,_loc4_);
         }
      }
      
      private function __alertResponseHandler(param1:FrameEvent) : void
      {
         _alert.removeEventListener("response",__alertResponseHandler);
         _alert.dispose();
         _alert = null;
         if(param1.responseCode == 2 || param1.responseCode == 3)
         {
            resolveConfirmHandler();
         }
      }
      
      private function resolveConfirmHandler() : void
      {
         AvengerManager.instance.sendAvengerResolve(resolveIdCounts);
      }
      
      private function refreshDefaultView() : void
      {
         defaultPropView();
         defaultMaterialView();
         _resolveBtn.enable = false;
      }
      
      private function defaultPropView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:AvengerResolveItem = null;
         _loc2_ = 0;
         while(_loc2_ < propList.length)
         {
            _loc1_ = propList[_loc2_];
            _loc1_.data = null;
            _loc2_++;
         }
      }
      
      private function defaultMaterialView() : void
      {
         var _loc1_:int = 0;
         var _loc2_:ResolveNeededMaterialItem = null;
         _loc1_ = 0;
         while(_loc1_ < materialList.length)
         {
            _loc2_ = materialList[_loc1_];
            _loc2_.setData(0);
            _loc1_++;
         }
      }
      
      private function refreshClientView() : void
      {
         var _loc13_:GoodsInfo = null;
         var _loc3_:ResolveTemplateInfo = null;
         var _loc5_:* = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc4_:GoodsTemplateInfo = null;
         var _loc10_:int = 0;
         var _loc1_:AvengerResolveItem = null;
         var _loc8_:int = 0;
         var _loc14_:ResolveNeededMaterialItem = null;
         updateBtn();
         resolveIdCounts = "";
         var _loc9_:Array = model.resolveBagDic.getList();
         _loc9_.sortOn("templateId",16);
         var _loc11_:SimpleDictionary = new SimpleDictionary();
         _loc6_ = 0;
         while(_loc6_ < propList.length)
         {
            _loc1_ = propList[_loc6_];
            if(_loc9_[_loc6_])
            {
               _loc13_ = _loc9_[_loc6_];
               _loc1_.data = _loc13_;
               resolveIdCounts += _loc13_.templateId + "," + _loc13_.count + "|";
               _loc3_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(1,_loc13_.templateId);
               if(_loc3_)
               {
                  _loc7_ = 1;
                  while(_loc7_ <= 4)
                  {
                     _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_["Item" + _loc7_]);
                     if(_loc4_)
                     {
                        if(_loc11_[_loc3_["Item" + _loc7_]])
                        {
                           _loc10_ = int(_loc11_[_loc3_["Item" + _loc7_]]);
                           _loc11_.add(_loc3_["Item" + _loc7_],_loc10_ + _loc13_.count * _loc3_["Count" + _loc7_]);
                        }
                        else
                        {
                           _loc11_.add(_loc3_["Item" + _loc7_],_loc13_.count * _loc3_["Count" + _loc7_]);
                        }
                     }
                     _loc7_++;
                  }
               }
            }
            else
            {
               _loc1_.data = null;
            }
            _loc6_++;
         }
         var _loc12_:Array = model.resolveBagDic1.getList();
         _loc6_ = 0;
         while(_loc6_ < _loc12_.length)
         {
            _loc13_ = _loc12_[_loc6_];
            resolveIdCounts += _loc13_.templateId + "," + _loc13_.count + "|";
            _loc3_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(1,_loc13_.templateId);
            if(_loc3_)
            {
               _loc7_ = 1;
               while(_loc7_ <= 4)
               {
                  _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_["Item" + _loc7_]);
                  if(_loc4_)
                  {
                     if(_loc11_[_loc3_["Item" + _loc7_]])
                     {
                        _loc10_ = int(_loc11_[_loc3_["Item" + _loc7_]]);
                        _loc11_.add(_loc3_["Item" + _loc7_],_loc10_ + _loc13_.count * _loc3_["Count" + _loc7_]);
                     }
                     else
                     {
                        _loc11_.add(_loc3_["Item" + _loc7_],_loc13_.count * _loc3_["Count" + _loc7_]);
                     }
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         var _loc2_:Array = _loc11_.keys;
         _loc2_.sort();
         _loc8_ = 0;
         while(_loc8_ < materialList.length)
         {
            _loc14_ = materialList[_loc8_];
            if(_loc2_.length <= _loc8_)
            {
               _loc14_.setData(0);
            }
            else
            {
               _loc14_.setData(_loc2_[_loc8_]);
               _loc14_.materialCount = _loc11_[_loc2_[_loc8_]];
            }
            _loc8_++;
         }
         _resolveBtn.enable = _loc9_.length > 0 || _loc12_.length > 0;
      }
      
      private function get model() : AvengerModel
      {
         return AvengerManager.instance.model;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_allResolveBtn);
         _allResolveBtn = null;
         ObjectUtils.disposeObject(_cancelResolveBtn);
         _cancelResolveBtn = null;
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
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         LogicUtils.disposeDisplayCollection(propList);
         propList = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         model.resetResolveBagList();
         super.dispose();
      }
   }
}

