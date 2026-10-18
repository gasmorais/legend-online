package thessbox.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class ThessBoxDropItem extends Sprite
   {
      
      private var _item:BaseItemView;
      
      private var _glvText:FilterFrameText;
      
      private var _data:String;
      
      public function ThessBoxDropItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("thessbox.glv.BaseItemView");
         _glvText = ComponentFactory.Instance.creatComponentByStylename("thessbox.glv.txt");
         addChild(_item);
         addChild(_glvText);
      }
      
      public function set data(param1:String) : void
      {
         var _loc2_:Array = null;
         var _loc3_:GoodsInfo = null;
         _data = param1;
         if(_data)
         {
            _loc2_ = _data.split(",");
            _loc3_ = new GoodsInfo();
            _loc3_.templateId = int(_loc2_[0]);
            _loc3_.count = int(_loc2_[1]);
            _loc3_.showHasGet = true;
            _item.data = _loc3_;
            _glvText.text = int(_loc2_[2]) / 10 + "%";
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_item);
         _item = null;
         ObjectUtils.disposeObject(_glvText);
         _glvText = null;
      }
   }
}

