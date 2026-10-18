package pet.compose
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.goods.GoodsInfo;
   import yishi.utils.StringHelper;
   import yishi.view.community.BaseItemView;
   
   public class PetComposeMaterialView extends Component
   {
      
      private var _iconView:BaseItemView;
      
      private var _materialTxt:Bitmap;
      
      private var _txt:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      public function PetComposeMaterialView()
      {
         super();
      }
      
      override protected function init() : void
      {
         _iconView = ComponentFactory.Instance.creatCustomObject("pet.ComposeMaterialCell");
         _materialTxt = ComponentFactory.Instance.creatCustomObject("PetComposeMaterialView.materialTxt");
         _materialTxt.bitmapData = ClassUtils.CreatInstance("asset.store.ComposeOpenBg");
         _txt = ComponentFactory.Instance.creatComponentByStylename("store.ComposeMaterialNumTxt2");
         addChild(_iconView);
         addChild(_materialTxt);
         addChild(_txt);
      }
      
      private function uint() : void
      {
         ObjectUtils.disposeObject(_iconView);
         _iconView = null;
         ObjectUtils.disposeObject(_materialTxt);
         _materialTxt = null;
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         _data = null;
      }
      
      private function addEvent() : void
      {
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get data() : GoodsInfo
      {
         return _data;
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         _data = param1;
         _iconView.data = param1;
         _iconView.tipData = param1;
         if(_data)
         {
            _txt.text = StringHelper.format("{0}/{1}",param1.currentCount,param1.needCount);
            _materialTxt.visible = false;
         }
         else
         {
            _txt.text = "";
            _materialTxt.visible = true;
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         uint();
         super.dispose();
      }
   }
}

