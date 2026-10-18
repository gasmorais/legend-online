package store.cast
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class CastNeededMaterialItem extends Sprite implements Disposeable
   {
      
      private var _icon:BaseItemView;
      
      private var _goodsTemId:int;
      
      private var _neededTxt:FilterFrameText;
      
      private var _material:Image;
      
      private var _materialCount:int;
      
      public function CastNeededMaterialItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _neededTxt = ComponentFactory.Instance.creatComponentByStylename("store.CastMaterialNumTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("store.CastMaterialCell");
         _material = ComponentFactory.Instance.creatComponentByStylename("store.CastMaterialTxt");
         addChild(_icon);
         addChild(_material);
         addChild(_neededTxt);
      }
      
      private function uninitView() : void
      {
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_material);
         _material = null;
         ObjectUtils.disposeObject(_neededTxt);
         _neededTxt = null;
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function material(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GoodsInfo = null;
         if(param1 > 0)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = param1;
            _icon.data = _loc4_;
            _icon.buttonMode = false;
            _neededTxt.text = param3 + " / " + param2;
            _materialCount = param2 - param3;
            _material.visible = false;
         }
         else
         {
            _icon.data = null;
            _neededTxt.text = "";
            _material.visible = true;
         }
      }
      
      public function get materialCount() : int
      {
         if(_materialCount < 0)
         {
            _materialCount = 1;
         }
         return _materialCount;
      }
      
      public function dispose() : void
      {
         uninitView();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

