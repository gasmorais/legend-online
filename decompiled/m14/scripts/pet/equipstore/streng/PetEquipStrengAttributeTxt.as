package pet.equipstore.streng
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class PetEquipStrengAttributeTxt extends Sprite implements Disposeable
   {
      
      private var _txt:FilterFrameText;
      
      private var _flag:Bitmap;
      
      public function PetEquipStrengAttributeTxt()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _txt = ComponentFactory.Instance.creatComponentByStylename("pet.attributeTxt");
         _flag = ComponentFactory.Instance.creatBitmap("asset.petrefinery.UpArrow");
         addChild(_txt);
         addChild(_flag);
         _flag.x = 175;
      }
      
      public function setTxtAndFlag(param1:String, param2:Boolean) : void
      {
         _txt.htmlText = param1;
         if(param2)
         {
            _flag.visible = true;
            _txt.width = 180;
         }
         else
         {
            _flag.visible = false;
            _txt.width = 180;
         }
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_txt);
         ObjectUtils.disposeObject(_flag);
      }
   }
}

