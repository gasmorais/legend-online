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
   import managers.TheseussoulManager;
   import mvc.module.theseus.TheseussoulModel;
   import mvc.module.theseus.WarFrameItemInfo;
   import store.resolve.ResolveNeededMaterialItem;
   import store.resolve.TheseusResolveItem;
   import store.treasure.TreasyreResolvePopFrame;
   import utils.LogicUtils;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.ResolveTemplateInfo;
   import yishi.manager.SharedManagerHelper;
   import yishi.manager.TempleteManager;
   import yishi.utils.MsgMan;
   import yishi.utils.SimpleDictionary;
   import yishi.view.tips.MessageTipManager;
   
   public class TheseusRosolveView extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _previewBg:ScaleBitmapImage;
      
      private var _promptTxtBg:Bitmap;
      
      private var _previewTxtBg:Bitmap;
      
      private var _arrowsBg:Bitmap;
      
      private var _resolveBtn:IconButton;
      
      private var _allResolveBtn:IconButton;
      
      private var _cancelResolveBtn:IconButton;
      
      private var _storeBag:TheseusStoreBag;
      
      private var _equipAry:Array = [];
      
      private var propList:Vector.<TheseusResolveItem>;
      
      private var materialList:Vector.<ResolveNeededMaterialItem>;
      
      private var resolveIdCounts:String = "";
      
      private var resolveNames:String = "";
      
      private var _alert:BaseAlerFrame;
      
      public function TheseusRosolveView()
      {
         super();
         initView();
         initPropView();
         initMatertialView();
         addEvent();
         updateBtn();
         model.isAllResolve = false;
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.TheseusRosolveView.resolveViewBg");
         _previewBg = ComponentFactory.Instance.creatComponentByStylename("AvengerRosolveView.previewBg");
         _promptTxtBg = ComponentFactory.Instance.creatBitmap("asset.store.resolvePromptTxtBg");
         _previewTxtBg = ComponentFactory.Instance.creatBitmap("asset.AvengerRosolveView.resolvePreviewTxtBg");
         _arrowsBg = ComponentFactory.Instance.creatBitmap("asset.mainToolBar.IntensifyIcon");
         _resolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.resolveBtn");
         _storeBag = ComponentFactory.Instance.creatCustomObject("TheseusRosolveView.StoreBag");
         _allResolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.allresolveBtn");
         _cancelResolveBtn = ComponentFactory.Instance.creatComponentByStylename("store.resolve.cancelresolveBtn");
         addChild(_bg);
         addChild(_previewBg);
         addChild(_promptTxtBg);
         addChild(_previewTxtBg);
         addChild(_arrowsBg);
         _arrowsBg.rotation = 90;
         _arrowsBg.x = 255;
         _arrowsBg.y = 115;
         addChild(_resolveBtn);
         _resolveBtn.enable = false;
         addChild(_storeBag);
         addChild(_allResolveBtn);
         addChild(_cancelResolveBtn);
         _cancelResolveBtn.visible = false;
         _resolveBtn.x = 18;
         updateBtn();
      }
      
      private function initPropView() : void
      {
         var _loc2_:int = 0;
         var _loc1_:TheseusResolveItem = null;
         propList = new Vector.<TheseusResolveItem>();
         _loc2_ = 0;
         while(_loc2_ < 4)
         {
            _loc1_ = new TheseusResolveItem();
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
         MsgMan.addObserver("EVENT_THESEUS_BAG_UPDATE",this,__updateBagViewHandler);
         TheseussoulManager.Instance.addEventListener("EVENT_SUIT_UPDATE",__updateBagViewHandler);
         _resolveBtn.addEventListener("click",__onResolveHandler);
         _allResolveBtn.addEventListener("click",__onallResolveHandler);
         MsgMan.addObserver("THESEUS_ALL_RESOLVE",this,__resolveBack);
         if(_cancelResolveBtn)
         {
            _cancelResolveBtn.addEventListener("click",__oncancelResolveHandler);
         }
         MsgMan.addObserver("THESEUS_STORE_BAG_UPDATE",this,__updateClientOpHandler);
      }
      
      private function removeEvent() : void
      {
         MsgMan.removeObserver("THESEUS_STORE_BAG_UPDATE",this,__updateClientOpHandler);
         MsgMan.removeObserver("EVENT_THESEUS_BAG_UPDATE",this,__updateBagViewHandler);
         TheseussoulManager.Instance.removeEventListener("EVENT_SUIT_UPDATE",__updateBagViewHandler);
         if(_resolveBtn)
         {
            _resolveBtn.removeEventListener("click",__onResolveHandler);
         }
         if(_allResolveBtn)
         {
            _allResolveBtn.removeEventListener("click",__onallResolveHandler);
         }
         MsgMan.removeObserver("THESEUS_ALL_RESOLVE",this,__resolveBack);
         if(_cancelResolveBtn)
         {
            _cancelResolveBtn.removeEventListener("click",__oncancelResolveHandler);
         }
      }
      
      private function __oncancelResolveHandler(param1:MouseEvent = null) : void
      {
         model.isAllResolve = false;
         model.resetResolveBagList();
         MsgMan.notifyObserver("THESEUS_ALL_RESOLVE");
         MsgMan.notifyObserver("THESEUS_STORE_BAG_UPDATE");
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
      
      private function __updateClientOpHandler(param1:String, param2:Object) : void
      {
         refreshClientView();
      }
      
      private function __onallResolveHandler(param1:MouseEvent) : void
      {
         model.resetResolveBagList();
         var _loc2_:TreasyreResolvePopFrame = ComponentFactory.Instance.creatComponentByStylename("store.treasure.TreasyreResolvePopFrame");
         _loc2_.show();
      }
      
      private function __updateBagViewHandler(param1:String, param2:Object = null) : void
      {
         model.resetResolveBagList();
         refreshDefaultView();
         __oncancelResolveHandler();
      }
      
      private function __onResolveHandler(param1:MouseEvent) : void
      {
         var _loc3_:String = null;
         var _loc4_:String = null;
         var _loc2_:String = null;
         if(model.isAllResolve)
         {
            _loc2_ = LanguageMgr.GetTranslation("public.cancel");
            _loc3_ = LanguageMgr.GetTranslation("yishi.view.base.ThewAlertFrame.text");
            _loc4_ = LanguageMgr.GetTranslation("AllResolvePopFrame.Avenger.alert",model.resolveLv,model.color,model.resolveType);
            _alert = AlertManager.Instance.simpleAlert(_loc3_,_loc4_,"",_loc2_,false,true,true);
            _alert.addEventListener("response",__alertResponseHandler);
            return;
         }
         _loc3_ = LanguageMgr.GetTranslation("active.expback.frame.selectbtntxt");
         _loc4_ = LanguageMgr.GetTranslation("theseusoul.store.resolveToday");
         SharedManagerHelper.ins.needAlert("store.TheseusRosolveView.resolver",resolveConfirmHandler,_loc3_,_loc4_);
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
         TheseussoulManager.Instance.doWarFrameParam(4,0,0,resolveIdCounts);
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
         var _loc1_:TheseusResolveItem = null;
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
      
      private function updateBtn() : void
      {
         _equipAry = [];
         for each(var _loc1_:WarFrameItemInfo in model.armorBagDic)
         {
            if(_loc1_.warTempInfo.SonType == 720)
            {
               if(_loc1_.warTempInfo.Property2 != 2 && !_loc1_.isEquip)
               {
                  _equipAry.push(_loc1_);
               }
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
      
      private function refreshClientView() : void
      {
         var _loc15_:WarFrameItemInfo = null;
         var _loc4_:ResolveTemplateInfo = null;
         var _loc7_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:GoodsTemplateInfo = null;
         var _loc12_:int = 0;
         var _loc1_:Array = null;
         var _loc9_:Array = null;
         var _loc2_:TheseusResolveItem = null;
         var _loc8_:int = 0;
         var _loc17_:ResolveNeededMaterialItem = null;
         updateBtn();
         resolveIdCounts = "";
         resolveNames = "";
         var _loc10_:Array = model.resolveBagDic.getList();
         _loc10_.sortOn("templateId",16);
         var _loc13_:SimpleDictionary = new SimpleDictionary();
         var _loc11_:int = int(propList.length);
         var _loc16_:Boolean = false;
         _loc6_ = 0;
         while(_loc6_ < _loc11_)
         {
            _loc2_ = propList[_loc6_];
            if(_loc10_[_loc6_])
            {
               _loc15_ = _loc10_[_loc6_];
               _loc2_.data = _loc15_;
               resolveIdCounts += _loc15_.id + "," + _loc15_.count + "|";
               resolveNames += _loc15_.warTempInfo.TemplateName;
               _loc4_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(3,_loc15_.templateId);
               if(_loc4_)
               {
                  _loc7_ = 1;
                  while(_loc7_ <= 4)
                  {
                     _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_["Item" + _loc7_]);
                     if(_loc5_)
                     {
                        if(_loc13_[_loc4_["Item" + _loc7_]])
                        {
                           _loc12_ = int(_loc13_[_loc4_["Item" + _loc7_]]);
                           _loc13_.add(_loc4_["Item" + _loc7_],_loc12_ + _loc15_.count * _loc4_["Count" + _loc7_]);
                        }
                        else
                        {
                           _loc13_.add(_loc4_["Item" + _loc7_],_loc15_.count * _loc4_["Count" + _loc7_]);
                        }
                     }
                     _loc7_++;
                  }
               }
               _loc4_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(3,_loc15_.templateId);
               _loc9_ = _loc15_.warStrengthTempInfo.Recovery.split("|").concat(_loc15_.warReformTempInfo.Recovery.split("|"));
               if(_loc9_)
               {
                  _loc7_ = 0;
                  while(_loc7_ < _loc9_.length)
                  {
                     _loc1_ = _loc9_[_loc7_].split(",");
                     _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_[0]);
                     if(_loc5_)
                     {
                        if(_loc13_[_loc1_[0]])
                        {
                           _loc12_ = int(_loc13_[_loc1_[0]]);
                           _loc13_.add(_loc1_[0],_loc12_ + _loc15_.count * _loc1_[1]);
                        }
                        else
                        {
                           _loc13_.add(_loc1_[0],_loc15_.count * _loc1_[1]);
                        }
                     }
                     _loc7_++;
                  }
               }
            }
            else
            {
               _loc2_.data = null;
            }
            _loc6_++;
         }
         var _loc14_:Array = model.resolveBagDic1.getList();
         _loc6_ = 0;
         while(_loc6_ < _loc14_.length)
         {
            if(_loc14_[_loc6_])
            {
               _loc15_ = _loc14_[_loc6_];
               resolveIdCounts += _loc15_.id + "," + _loc15_.count + "|";
               resolveNames += _loc15_.warTempInfo.TemplateName;
               _loc4_ = TempleteManager.instance.resolveTemplateCate.getTemplateByTypeAndTempId(3,_loc15_.templateId);
               if(_loc4_)
               {
                  _loc7_ = 1;
                  while(_loc7_ <= 4)
                  {
                     _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc4_["Item" + _loc7_]);
                     if(_loc5_)
                     {
                        if(_loc13_[_loc4_["Item" + _loc7_]])
                        {
                           _loc12_ = int(_loc13_[_loc4_["Item" + _loc7_]]);
                           _loc13_.add(_loc4_["Item" + _loc7_],_loc12_ + _loc15_.count * _loc4_["Count" + _loc7_]);
                        }
                        else
                        {
                           _loc13_.add(_loc4_["Item" + _loc7_],_loc15_.count * _loc4_["Count" + _loc7_]);
                        }
                     }
                     _loc7_++;
                  }
               }
            }
            _loc9_ = _loc15_.warStrengthTempInfo.Recovery.split("|").concat(_loc15_.warReformTempInfo.Recovery.split("|"));
            if(_loc9_)
            {
               _loc7_ = 0;
               while(_loc7_ < _loc9_.length)
               {
                  _loc1_ = _loc9_[_loc7_].split(",");
                  _loc5_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc1_[0]);
                  if(_loc5_)
                  {
                     if(_loc13_[_loc1_[0]])
                     {
                        _loc12_ = int(_loc13_[_loc1_[0]]);
                        _loc13_.add(_loc1_[0],_loc12_ + _loc15_.count * _loc1_[1]);
                     }
                     else
                     {
                        _loc13_.add(_loc1_[0],_loc15_.count * _loc1_[1]);
                     }
                  }
                  _loc7_++;
               }
            }
            _loc6_++;
         }
         var _loc3_:Array = _loc13_.keys;
         _loc3_.sort();
         _loc8_ = 0;
         while(_loc8_ < materialList.length)
         {
            _loc17_ = materialList[_loc8_];
            if(_loc3_.length <= _loc8_)
            {
               _loc17_.setData(0);
            }
            else
            {
               _loc17_.setData(_loc3_[_loc8_]);
               _loc17_.materialCount = _loc13_[_loc3_[_loc8_]];
            }
            _loc8_++;
         }
         _resolveBtn.enable = _loc10_.length > 0 || _loc14_.length > 0;
      }
      
      private function get model() : TheseussoulModel
      {
         return TheseussoulManager.Instance.model;
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
         ObjectUtils.disposeObject(_storeBag);
         _storeBag = null;
         ObjectUtils.disposeObject(_allResolveBtn);
         _allResolveBtn = null;
         ObjectUtils.disposeObject(_cancelResolveBtn);
         _cancelResolveBtn = null;
         LogicUtils.disposeDisplayCollection(propList);
         propList = null;
         LogicUtils.disposeDisplayCollection(materialList);
         materialList = null;
         model.resetResolveBagList();
         super.dispose();
      }
   }
}

