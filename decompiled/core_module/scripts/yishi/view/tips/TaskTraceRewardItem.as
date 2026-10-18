package yishi.view.tips
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class TaskTraceRewardItem extends Sprite implements Disposeable
   {
      
      private var _data:GoodsInfo;
      
      private var _item:BaseItemView;
      
      private var _itemName:FilterFrameText;
      
      public function TaskTraceRewardItem()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _item = ComponentFactory.Instance.creatCustomObject("tips.BaseItemView");
         _itemName = ComponentFactory.Instance.creatComponentByStylename("tips.rewardItemTxt");
         addChild(_item);
         addChild(_itemName);
      }
      
      public function set data(param1:GoodsInfo) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         _item.data = _data;
         var _loc2_:int = _data.count;
         if(_loc2_ < 1)
         {
            _loc2_ = 1;
         }
         _itemName.text = getGoodsTemp(_data.templateId).TemplateName + "×" + _loc2_;
         _itemName.setFrame(getGoodsTemp(_data.templateId).Profile);
         if(_itemName.textWidth > 40)
         {
            _item.x = (_itemName.textWidth - 40) / 2;
         }
      }
      
      private function getGoodsTemp(param1:int) : GoodsTemplateInfo
      {
         return TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1);
      }
      
      public function dispose() : void
      {
         _data = null;
         _item.dispose();
         _item = null;
         ObjectUtils.disposeObject(_itemName);
         _itemName = null;
      }
   }
}

