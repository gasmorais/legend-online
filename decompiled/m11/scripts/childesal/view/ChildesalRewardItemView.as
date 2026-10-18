package childesal.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import mvc.module.childseal.ChildesalRewardInfo;
   import yishi.datas.goods.GoodsInfo;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.filter.UIFilter;
   import yishi.manager.TempleteManager;
   import yishi.view.community.BaseItemView;
   
   public class ChildesalRewardItemView extends Sprite implements Disposeable
   {
      
      private var _topBit:Bitmap;
      
      private var _itemView:BaseItemView;
      
      private var _getNumTxt:FilterFrameText;
      
      private var _starBit:Bitmap;
      
      private var _needNumTxt:FilterFrameText;
      
      private var _filter:UIFilter;
      
      public function ChildesalRewardItemView()
      {
         super();
         initView();
      }
      
      public function set info(param1:ChildesalRewardInfo) : void
      {
         var _loc2_:GoodsTemplateInfo = TempleteManager.instance.goodsTemplateCate.getTemplateByID(param1.templateId);
         var _loc3_:GoodsInfo = new GoodsInfo();
         _loc3_.templateId = param1.templateId;
         _loc3_.count = param1.count;
         _itemView.data = _loc3_;
         _needNumTxt.text = "X" + String(param1.starNum);
         _getNumTxt.text = String(param1.count);
         if(param1.isGet)
         {
            _filter.setGrayFilter(_itemView);
         }
         else
         {
            _filter.setNormalFilter(_itemView);
         }
      }
      
      private function initView() : void
      {
         _topBit = ComponentFactory.Instance.creatBitmap("asset.childesal.top");
         _itemView = ComponentFactory.Instance.creatCustomObject("childesal.itemView");
         _getNumTxt = ComponentFactory.Instance.creatComponentByStylename("childesal.countNumTxt2");
         _starBit = ComponentFactory.Instance.creatBitmap("asset.childesal.starIcon");
         _needNumTxt = ComponentFactory.Instance.creatComponentByStylename("childesal.countNumTxt03");
         addChild(_topBit);
         addChild(_itemView);
         addChild(_getNumTxt);
         addChild(_needNumTxt);
         addChild(_starBit);
         _filter = new UIFilter();
      }
      
      override public function get width() : Number
      {
         return 42;
      }
      
      public function dispose() : void
      {
         if(_filter)
         {
            _filter.setNormalFilter(_itemView);
         }
         _filter = null;
         ObjectUtils.disposeObject(_topBit);
         _topBit = null;
         ObjectUtils.disposeObject(_itemView);
         _itemView = null;
         ObjectUtils.disposeObject(_getNumTxt);
         _getNumTxt = null;
         ObjectUtils.disposeObject(_needNumTxt);
         _needNumTxt = null;
         ObjectUtils.disposeObject(_starBit);
         _starBit = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

