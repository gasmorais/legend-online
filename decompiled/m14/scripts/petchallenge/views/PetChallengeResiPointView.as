package petchallenge.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import manager.LanguageMgr;
   import managers.PetChallengeManager;
   import mvc.module.petchallenge.PetChallengeModel;
   import yishi.utils.NumberViewUtils;
   
   public class PetChallengeResiPointView extends Component
   {
      
      private var resiImage:ScaleFrameImage;
      
      private var addImage:ScaleFrameImage;
      
      private var numberBitmap1:BitmapData;
      
      private var numberBitmap2:BitmapData;
      
      private var numberBitmap3:BitmapData;
      
      private var pointContiner:Component;
      
      private var resiIndex:int;
      
      public function PetChallengeResiPointView(param1:int)
      {
         super();
         resiIndex = param1;
         initView();
         refreshView();
      }
      
      private function initView() : void
      {
         resiImage = ComponentFactory.Instance.creatComponentByStylename("PetChallengeResiPointView.resiImage");
         addImage = ComponentFactory.Instance.creatComponentByStylename("PetChallengeResiPointView.addImage");
         pointContiner = ComponentFactory.Instance.creatComponentByStylename("PetChallengeResiPointView.pointContiner");
         numberBitmap1 = ComponentFactory.Instance.creatBitmapData("asset.PetChallengeResiPointView.numberBitmap1");
         numberBitmap2 = ComponentFactory.Instance.creatBitmapData("asset.PetChallengeResiPointView.numberBitmap2");
         numberBitmap3 = ComponentFactory.Instance.creatBitmapData("asset.PetChallengeResiPointView.numberBitmap3");
         addChild(resiImage);
         addChild(addImage);
         addChild(pointContiner);
         resiImage.setFrame(resiIndex);
         var _loc1_:Array = LanguageMgr.GetTranslation("PetChallengeResiPointView.resiImage.tipdata").split("|");
         resiImage.tipData = _loc1_[resiIndex - 1];
      }
      
      public function refreshView() : void
      {
         var _loc1_:int = int(model.getAddPointByIndex(resiIndex));
         var _loc2_:int = int(model.checkSize(_loc1_));
         var _loc4_:int = _loc2_ == 3 ? 15 : 14;
         var _loc3_:int = 17 + _loc2_;
         var _loc5_:int = 12;
         addImage.setFrame(_loc2_);
         NumberViewUtils.refreshValue(_loc1_,pointContiner,this["numberBitmap" + _loc2_],_loc4_,_loc3_,_loc5_,_loc4_,"0123456789");
      }
      
      private function get model() : PetChallengeModel
      {
         return PetChallengeManager.instance.model;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(resiImage);
         resiImage = null;
         ObjectUtils.disposeObject(addImage);
         addImage = null;
         ObjectUtils.disposeObject(pointContiner);
         pointContiner = null;
         ObjectUtils.disposeObject(numberBitmap1);
         numberBitmap1 = null;
         ObjectUtils.disposeObject(numberBitmap2);
         numberBitmap2 = null;
         ObjectUtils.disposeObject(numberBitmap3);
         numberBitmap3 = null;
         super.dispose();
      }
   }
}

