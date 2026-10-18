package sacrifice
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class SacrificeGoodsItem extends BaseItemView
   {
      
      public static const P_topbmpStyle:String = "P_topbmpStyle";
      
      private var _topbmp:Bitmap;
      
      private var _topbmpStyle:String;
      
      public function SacrificeGoodsItem()
      {
         super();
      }
      
      override protected function getCountStr(param1:GoodsInfo) : String
      {
         if(!param1.templateInfo)
         {
            return "";
         }
         if(param1.templateInfo.MaxCount <= 1 && param1.showCount == false)
         {
            return "";
         }
         var _loc2_:Number = param1.count / 10000;
         if(param1.count % 10000 == 0)
         {
            if(_loc2_ >= 1)
            {
               return int(_loc2_) + "0K";
            }
         }
         else
         {
            if(_loc2_ >= 1 && _loc2_ < 10)
            {
               return _loc2_.toFixed(1) + "0K";
            }
            if(_loc2_ > 10)
            {
               return int(_loc2_) + "0K";
            }
         }
         return param1.count.toString();
      }
      
      public function set topbmpStyle(param1:String) : void
      {
         _topbmpStyle = param1;
         onPropertiesChanged("P_topbmpStyle");
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["P_topbmpStyle"])
         {
            _topbmp = ComponentFactory.Instance.creatBitmap(_topbmpStyle);
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_topbmp)
         {
            addChild(_topbmp);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_topbmp);
         _topbmp = null;
         super.dispose();
      }
   }
}

