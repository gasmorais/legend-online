package cathouse
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   import mvc.module.currency.CurrencyType;
   import yishi.datas.templates.GoodsTemplateInfo;
   import yishi.manager.TempleteManager;
   
   public class CatHouseCurrencyItem extends Component
   {
      
      private var _icon:ScaleFrameImage;
      
      private var _numBg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _index:int;
      
      public function CatHouseCurrencyItem()
      {
         super();
         _numBg = ComponentFactory.Instance.creatBitmap("asset.cathouse.numBg");
         _icon = ComponentFactory.Instance.creatComponentByStylename("cathouse.materialIcon");
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("cathouse.materialTxt");
         addChild(_numBg);
         addChild(_icon);
         addChild(_countTxt);
      }
      
      public function set index(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:GoodsTemplateInfo = null;
         _icon.setFrame(param1 + 1);
         if(param1 == 7)
         {
            _icon.tipData = LanguageMgr.GetTranslation("mainBar.view.ResourceView.gold");
         }
         else
         {
            _loc3_ = int(CurrencyType.CAT_TOY_VALUE_LIST[param1]);
            _loc2_ = TempleteManager.instance.goodsTemplateCate.getTemplateByID(_loc3_);
            _icon.tipData = _loc2_.TemplateName + ":" + _loc2_.Description;
         }
      }
      
      public function set value(param1:int) : void
      {
         _countTxt.text = String(param1);
      }
      
      public function set enoughMaterial(param1:Boolean) : void
      {
         if(!param1)
         {
            _countTxt.setFrame(2);
         }
      }
      
      public function set setWidth(param1:int) : void
      {
         _numBg.width = param1;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_numBg);
         _numBg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         super.dispose();
      }
   }
}

