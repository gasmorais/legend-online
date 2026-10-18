package store.resolve
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class ResolveNeededMaterialItem extends Sprite implements Disposeable
   {
      
      private var _icon:BaseItemView;
      
      private var _goodsTemId:int;
      
      private var _neededTxt:FilterFrameText;
      
      private var _back:ScaleBitmapImage;
      
      private var _materialCount:int;
      
      public var BindsType:Boolean;
      
      public function ResolveNeededMaterialItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _neededTxt = ComponentFactory.Instance.creatComponentByStylename("store.resolveMaterialNumTxt");
         _icon = ComponentFactory.Instance.creatCustomObject("store.resolveMaterialCell");
         _back = ComponentFactory.Instance.creatComponentByStylename("store.resolveBack");
         addChild(_back);
         addChild(_icon);
         addChild(_neededTxt);
      }
      
      private function uninit() : void
      {
         ObjectUtils.disposeAllChildren(this);
      }
      
      public function setData(param1:int, param2:Boolean = false) : void
      {
         var _loc3_:GoodsInfo = null;
         _goodsTemId = param1;
         if(_goodsTemId != 0)
         {
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = _goodsTemId;
            _loc3_.id = -1;
            _loc3_.isBinds = param2;
            _icon.data = _loc3_;
            _icon.buttonMode = false;
            _neededTxt.text = _materialCount + "";
         }
         else
         {
            _icon.data = null;
            _neededTxt.text = "";
         }
      }
      
      public function get goodsTemId() : int
      {
         return _goodsTemId;
      }
      
      public function get materialCount() : int
      {
         return _materialCount;
      }
      
      public function set materialCount(param1:int) : void
      {
         _materialCount = param1;
         _neededTxt.text = _materialCount + "";
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

