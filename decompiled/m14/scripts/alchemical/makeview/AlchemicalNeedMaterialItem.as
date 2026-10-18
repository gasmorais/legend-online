package alchemical.makeview
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   import yishi.view.community.BaseItemView;
   
   public class AlchemicalNeedMaterialItem extends Component
   {
      
      private var item:BaseItemView;
      
      private var needText:FilterFrameText;
      
      public function AlchemicalNeedMaterialItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         item = ComponentFactory.Instance.creatCustomObject("AlchemicalNeedMaterialItem.item");
         needText = ComponentFactory.Instance.creatComponentByStylename("AlchemicalNeedMaterialItem.needText");
         addChild(item);
         addChild(needText);
      }
      
      public function setData(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:GoodsInfo = null;
         if(param1 != 0)
         {
            _loc4_ = new GoodsInfo();
            _loc4_.templateId = param1;
            item.data = _loc4_;
            needText.text = param2 + "/" + param3;
            param2 >= param3 ? needText.setFrame(1) : needText.setFrame(2);
         }
         else
         {
            item.data = null;
            needText.text = "";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(item);
         item = null;
         ObjectUtils.disposeObject(needText);
         needText = null;
         super.dispose();
      }
   }
}

