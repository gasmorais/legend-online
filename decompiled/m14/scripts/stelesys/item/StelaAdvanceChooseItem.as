package stelesys.item
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import mvc.module.stele.StelesysInfo;
   
   public class StelaAdvanceChooseItem extends StelesysBoxItem
   {
      
      private var _flg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      public function StelaAdvanceChooseItem()
      {
         super();
      }
      
      override public function set data(param1:StelesysInfo) : void
      {
         var _loc2_:String = null;
         var _loc3_:String = null;
         super.data = param1;
         if(param1 == null)
         {
            _flg.visible = false;
            _nameTxt.text = "";
            tipData = null;
         }
         else
         {
            tipData = param1;
            _flg.visible = true;
            _loc2_ = "";
            _loc3_ = "";
            _nameTxt.htmlText = param1.nameStep;
         }
      }
      
      override protected function initView() : void
      {
         super.initView();
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.stelesys.stelaNameTxt");
         addChild(_nameTxt);
         _flg = ComponentFactory.Instance.creatBitmap("asset.stelesys.yellowChoose");
         addChild(_flg);
         _flg.visible = false;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_flg);
         _flg = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         super.dispose();
      }
   }
}

