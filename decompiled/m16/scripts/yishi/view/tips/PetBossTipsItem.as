package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class PetBossTipsItem extends Sprite implements Disposeable
   {
      
      private var _itemIcon:BaseItemView;
      
      private var _itemName:FilterFrameText;
      
      private var _data:GoodsInfo;
      
      public function PetBossTipsItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _itemIcon = ComponentFactory.Instance.creatCustomObject("PetBossTipsItem.BaseItemView");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("PetBossTipsItem.rewardItemName");
         addChild(_itemIcon);
         addChild(_itemName);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _itemIcon.data = _data;
         var _loc2_:String = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_data.templateId).TemplateName;
         _itemName.text = _loc2_ + "x" + _data.count;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_itemIcon);
         _itemIcon = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
         _data = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

