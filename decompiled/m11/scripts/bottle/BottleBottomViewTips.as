package bottle
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.road.yishi.proto.item.BottleItemInfoMsg;
   import com.road.yishi.proto.item.BottlePackage;
   import manager.LanguageMgr;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   import yishi.view.tips.BaseTip;
   
   public class BottleBottomViewTips extends BaseTip
   {
      
      private var _describle:FilterFrameText;
      
      public function BottleBottomViewTips()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _describle = ComponentFactory.Instance.creatComponentByStylename("bottle.bottleBottomView.tips");
         addChild(_describle);
      }
      
      override protected function updateTransform() : void
      {
         var _loc3_:BottlePackage = null;
         var _loc1_:Array = null;
         var _loc4_:GoodsTemplateInfo = null;
         if(tipData)
         {
            _loc3_ = tipData as BottlePackage;
            _loc1_ = _loc3_.item;
            _describle.text = LanguageMgr.GetTranslation("BottleBottomViewTips.describle.text",_loc3_.param);
            for each(var _loc2_:BottleItemInfoMsg in _loc1_)
            {
               _loc4_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc2_.tempId);
               if(_loc4_)
               {
                  _describle.text += _loc4_.TemplateName + "*" + _loc2_.count + ",";
               }
            }
            _describle.text = _describle.text.substring(0,_describle.text.lastIndexOf(","));
            _bg.width = 236;
            _bg.height = _describle.textHeight + 18;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         if(_describle)
         {
            ObjectUtils.disposeObject(_describle);
         }
         _describle = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

