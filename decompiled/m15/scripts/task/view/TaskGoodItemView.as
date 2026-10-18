package task.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleBitmapImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Sprite;
   import mvc.module.task.TaskGoodsTemplate;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.datas.templates.OfferRewardGoodsTemplate;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class TaskGoodItemView extends Sprite implements Disposeable
   {
      
      private var _background:ScaleBitmapImage;
      
      private var _icon:BaseItemView;
      
      private var _nameText:FilterFrameText;
      
      private var _good:Object;
      
      private var _txt:FilterFrameText;
      
      private var goodInfo:GoodsInfo;
      
      public function TaskGoodItemView()
      {
         super();
         init();
      }
      
      private function init() : void
      {
         _background = ComponentFactory.Instance.creatComponentByStylename("task.TaskGoodItemBack");
         _icon = ComponentFactory.Instance.creatCustomObject("task.TaskGoodItem");
         _nameText = ComponentFactory.Instance.creatComponentByStylename("task.taskGoodItemName");
         _txt = ComponentFactory.Instance.creatComponentByStylename("task.ringTasktip.text");
         addChild(_background);
         addChild(_icon);
         addChild(_nameText);
         addChild(_txt);
         goodInfo = new GoodsInfo();
      }
      
      public function set data(param1:Object) : void
      {
         if(!param1)
         {
            return;
         }
         if(param1 is TaskGoodsTemplate)
         {
            _good = param1 as TaskGoodsTemplate;
         }
         else if(param1 is OfferRewardGoodsTemplate)
         {
            _good = param1 as OfferRewardGoodsTemplate;
         }
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_good.RewardItemID);
         goodInfo.templateId = _loc2_.TemplateId;
         goodInfo.count = param1.RewardItemCount;
         if(param1 is TaskGoodsTemplate)
         {
            goodInfo.validDate = param1.ValidDate;
         }
         _icon.data = goodInfo;
         _nameText.text = _loc2_.TemplateName;
         _nameText.height = _nameText.textHeight + 4;
         if(_nameText.numLines > 1)
         {
            _nameText.y = 11;
         }
         else
         {
            _nameText.y = 17;
         }
         _txt.text = "";
      }
      
      public function get data() : Object
      {
         return _good;
      }
      
      public function set txt(param1:String) : void
      {
         _txt.text = "(" + param1 + ")";
      }
      
      public function setgoodsCount(param1:int, param2:int) : void
      {
         if(!data)
         {
            return;
         }
         goodInfo.count = param1 * param2;
         _icon.data = goodInfo;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_txt);
         _txt = null;
         ObjectUtils.disposeObject(_background);
         _background = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_nameText);
         _nameText = null;
         _good = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

