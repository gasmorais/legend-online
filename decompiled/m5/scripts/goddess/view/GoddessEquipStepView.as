package goddess.view
{
   import bag.events.BagEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.controls.container.HBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import goddess.item.GoddessStepItem;
   import manager.LanguageMgr;
   import managers.GodDessManager;
   import mvc.module.goddess.GodDessModel;
   import mvc.module.goddess.GoddessEquipInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoddessEquipTempInfo;
   import yishi.manager.GoodsManager;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   import yishi.view.tips.MessageTipManager;
   
   public class GoddessEquipStepView extends GoddessBaseEquipView
   {
      
      public var _eqStepBtn:IconButton;
      
      public var _currItem:GoddessStepItem;
      
      public var _nextItem:GoddessStepItem;
      
      public var _arrow:Image;
      
      private var _hbox:HBox;
      
      private var _materialTemp:GoddessEquipTempInfo;
      
      private var _enoughMaterial:Boolean;
      
      private var _maxFlag:Bitmap;
      
      public function GoddessEquipStepView()
      {
         super();
         initView();
         initEvent();
         data = model.equipSelectInfo;
      }
      
      private function initView() : void
      {
         _currItem = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.stepItem1");
         _nextItem = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.stepItem2");
         _arrow = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.stepArrow");
         _eqStepBtn = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.eqStepBtn");
         _hbox = ComponentFactory.Instance.creatComponentByStylename("ui.goddess.StepMetrialBox");
         _maxFlag = ComponentFactory.Instance.creatBitmap("asset.goddess.equip.maxStep");
         addChild(_currItem);
         addChild(_arrow);
         addChild(_nextItem);
         addChild(_eqStepBtn);
         addChild(_hbox);
         addChild(_maxFlag);
         _currItem.type = 1;
         _nextItem.type = 2;
      }
      
      private function get model() : GodDessModel
      {
         return GodDessManager.instance.model;
      }
      
      override public function set data(param1:GoddessEquipInfo) : void
      {
         var _loc3_:GoddessEquipTempInfo = null;
         var _loc2_:GoddessEquipTempInfo = null;
         super.data = param1;
         var _loc4_:int = int(TempleteManager.instance.goddessEquipTempCate.getMaxStep());
         if(_data)
         {
            _loc3_ = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(2,_data.equipType,_data.equipAdvanceLevel);
            _currItem.equipTemp = _loc3_;
            _currItem.data = _data;
            _currItem.stepProfile = _data.equipAdvanceLevel + 1;
            refreshMetrals(_loc3_);
            if(_data.equipAdvanceLevel >= _loc4_)
            {
               _hbox.visible = false;
               _maxFlag.visible = true;
               _eqStepBtn.visible = false;
               _nextItem.visible = false;
               _xihaoImage.visible = false;
               _currItem.x = 85;
               _arrow.visible = false;
            }
            else
            {
               _hbox.visible = true;
               _maxFlag.visible = false;
               _eqStepBtn.visible = true;
               _nextItem.visible = true;
               _xihaoImage.visible = true;
               _arrow.visible = true;
               _currItem.x = 14;
               _loc2_ = TempleteManager.instance.goddessEquipTempCate.getEquipTempInfo(2,_data.equipType,_data.equipAdvanceLevel + 1);
               _nextItem.equipTemp = _loc2_;
               _nextItem.data = _data;
               _nextItem.stepProfile = _data.equipAdvanceLevel + 2;
            }
         }
      }
      
      private function refreshMetrals(param1:GoddessEquipTempInfo) : void
      {
         var _loc9_:Array = null;
         var _loc3_:int = 0;
         var _loc2_:BaseItemView = null;
         var _loc7_:GoodsInfo = null;
         var _loc8_:Array = null;
         var _loc5_:int = 0;
         var _loc4_:Boolean = false;
         var _loc6_:int = 0;
         if(_materialTemp == param1)
         {
            return;
         }
         _materialTemp = param1;
         _enoughMaterial = true;
         if(_materialTemp)
         {
            ObjectUtils.disposeAllChildren(_hbox);
            _loc9_ = _materialTemp.AdvanceCost.split("#");
            _hbox.beginChanges();
            _loc3_ = int(_loc9_.length);
            _loc6_ = 0;
            while(_loc6_ < _loc3_)
            {
               _loc2_ = ComponentFactory.Instance.creatCustomObject("goddess.equip.stepBaseItemView");
               _loc8_ = _loc9_[_loc6_].split(",");
               _loc7_ = new GoodsInfo();
               _loc7_.templateId = int(_loc8_[0]);
               _loc7_.count = int(_loc8_[1]);
               _loc2_.data = _loc7_;
               _hbox.addChild(_loc2_);
               _loc5_ = int(GoodsManager.instance.getGoodsNumByTempId(_loc7_.templateId));
               _loc4_ = _loc5_ >= _loc7_.count;
               _loc2_.itemText.setFrame(_loc4_ ? 3 : 2);
               _loc2_.itemText.text = "" + _loc5_ + "/" + _loc7_.count;
               _enoughMaterial &&= _loc4_;
               _loc6_++;
            }
            _hbox.commitChanges();
         }
      }
      
      private function refreshGoods() : void
      {
         var _loc7_:Array = null;
         var _loc6_:Array = null;
         var _loc4_:int = 0;
         var _loc3_:Boolean = false;
         var _loc2_:int = 0;
         var _loc1_:BaseItemView = null;
         var _loc5_:int = 0;
         if(_materialTemp)
         {
            _loc7_ = _materialTemp.AdvanceCost.split("#");
            _enoughMaterial = true;
            _loc2_ = int(_hbox.numChildren);
            _loc5_ = 0;
            while(_loc5_ < _loc2_)
            {
               _loc1_ = _hbox.getChildAt(_loc5_) as BaseItemView;
               if(_loc1_)
               {
                  _loc6_ = _loc7_[_loc5_].split(",");
                  _loc4_ = int(GoodsManager.instance.getGoodsNumByTempId(int(_loc6_[0])));
                  _loc3_ = _loc4_ >= int(_loc6_[1]);
                  _loc1_.itemText.setFrame(_loc3_ ? 3 : 2);
                  _loc1_.itemText.text = "" + _loc4_ + "/" + _loc6_[1];
                  _enoughMaterial &&= _loc3_;
               }
               _loc5_++;
            }
         }
      }
      
      private function initEvent() : void
      {
         _eqStepBtn.addEventListener("click",clickStepHandler);
         GoodsManager.instance.addEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.addEventListener("UPDATE_BAG",refreshGoodsHandler);
      }
      
      private function removeEvent() : void
      {
         _eqStepBtn.removeEventListener("click",clickStepHandler);
         GoodsManager.instance.removeEventListener("DELETE_BAG",refreshGoodsHandler);
         GoodsManager.instance.removeEventListener("UPDATE_BAG",refreshGoodsHandler);
      }
      
      private function refreshGoodsHandler(param1:BagEvent) : void
      {
         refreshGoods();
      }
      
      private function clickStepHandler(param1:MouseEvent) : void
      {
         if(_enoughMaterial)
         {
            GodDessManager.instance.requestOp(10,_data.ownerId,_data.equipType);
         }
         else
         {
            MessageTipManager.instance().show(LanguageMgr.GetTranslation("goddess.equip.noMaterial"));
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_nextItem);
         _nextItem = null;
         ObjectUtils.disposeObject(_currItem);
         _currItem = null;
         ObjectUtils.disposeObject(_arrow);
         _arrow = null;
         ObjectUtils.disposeObject(_eqStepBtn);
         _eqStepBtn = null;
         ObjectUtils.disposeObject(_hbox);
         _hbox = null;
         ObjectUtils.disposeObject(_maxFlag);
         _maxFlag = null;
         super.dispose();
         _materialTemp = null;
      }
   }
}

