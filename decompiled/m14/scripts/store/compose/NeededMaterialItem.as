package store.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.store.StoreModel;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.FrameControllerManager;
   import yishi.view.community.BaseItemView;
   
   public class NeededMaterialItem extends Sprite implements Disposeable
   {
      
      private var _icon:BaseItemView;
      
      private var _goodsTemId:int;
      
      private var _neededTxt:FilterFrameText;
      
      private var _materialBg:Bitmap;
      
      private var _tipButton:BaseButton;
      
      public function NeededMaterialItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _neededTxt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMaterialNumTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("store.ComposeMaterialCell");
         _materialBg = ComponentFactory.Instance.creatBitmap("asset.store.ComposeOpenBg");
         addChild(_icon);
         addChild(_neededTxt);
         addChild(_materialBg);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      private function get model() : StoreModel
      {
         return FrameControllerManager.instance.storeController.model;
      }
      
      public function setData(param1:int, param2:int, param3:int, param4:int = 0) : void
      {
         var _loc5_:GoodsInfo = null;
         var _loc6_:GoodsInfo = null;
         _goodsTemId = param1;
         if(!_icon || !_materialBg || !_neededTxt)
         {
            return;
         }
         if(_goodsTemId)
         {
            _loc5_ = new GoodsInfo();
            _loc5_.templateId = _goodsTemId;
            _loc6_ = new GoodsInfo();
            _loc6_.templateId = param4;
            _icon.data = _loc5_;
            _icon.buttonMode = false;
            _materialBg.visible = false;
            _neededTxt.text = param3 + " / " + param2;
            if(_neededTxt.text.substring(_neededTxt.text.length - 3) == "...")
            {
               if(!_tipButton)
               {
                  _tipButton = ComponentFactory.Instance.creatComponentByStylename("core.CloseBtn");
                  _tipButton.x = _neededTxt.x;
                  _tipButton.y = _neededTxt.y;
                  _tipButton.width = _neededTxt.width;
                  _tipButton.height = _neededTxt.height;
                  _tipButton.alpha = 0;
                  addChild(_tipButton);
                  _tipButton.tipGapH = 0;
                  _tipButton.tipGapV = 0;
               }
               _tipButton.tipData = param3 + " / " + param2;
            }
            else if(_tipButton)
            {
               ObjectUtils.disposeObject(_tipButton);
               _tipButton = null;
            }
         }
         else
         {
            _icon.data = null;
            _materialBg.visible = true;
            _neededTxt.text = "";
         }
      }
      
      public function dispose() : void
      {
         uninit();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

