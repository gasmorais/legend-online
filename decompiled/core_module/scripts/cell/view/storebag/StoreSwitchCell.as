package cell.view.storebag
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.datas.goods.GoodsInfo;
   
   public class StoreSwitchCell extends StoreIntensifyCell
   {
      
      private var _countTxt:FilterFrameText;
      
      public function StoreSwitchCell()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("store.resolveMaterialNumTxt");
         _countTxt.x = 22;
         _countTxt.y = 44;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_countTxt)
         {
            addChild(_countTxt);
         }
      }
      
      override public function set data(param1:GoodsInfo) : void
      {
         super.data = param1;
         if(param1)
         {
            _countTxt.text = param1.count + "";
         }
         else
         {
            _countTxt.text = "";
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         super.dispose();
      }
   }
}

