package map.campaign.view.ui.airgarden.game.fivecard
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import manager.LanguageMgr;
   
   public class AirGardenGameFivecardScoreItem extends Component
   {
      
      private static const SCORE:Array = [0,20000,10000,5000,2000,1000,500,300,200,100];
      
      private var _txtFivecardScoreName:FilterFrameText;
      
      private var _txtFivecardScoreValue:FilterFrameText;
      
      private var imgShine:Bitmap;
      
      private var index:int;
      
      public var score:int;
      
      public function AirGardenGameFivecardScoreItem(param1:int)
      {
         super();
         this.index = param1;
         initView();
      }
      
      private function initView() : void
      {
         _txtFivecardScoreName = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtFivecardScoreName");
         _txtFivecardScoreValue = ComponentFactory.Instance.creatComponentByStylename("ui.airgardengame.txtFivecardScoreValue");
         imgShine = ComponentFactory.Instance.creatBitmap("asset.AirGardenGame.img1");
         addChild(imgShine);
         addChild(_txtFivecardScoreName);
         addChild(_txtFivecardScoreValue);
         score = SCORE[index];
         _txtFivecardScoreName.text = LanguageMgr.GetTranslation("AirGardenGame.fivecard.result" + index);
         _txtFivecardScoreValue.text = score + "";
         reset();
      }
      
      public function shine() : void
      {
         imgShine.visible = true;
         _txtFivecardScoreName.setFrame(2);
         _txtFivecardScoreValue.setFrame(2);
      }
      
      public function reset() : void
      {
         imgShine.visible = false;
         _txtFivecardScoreName.setFrame(1);
         _txtFivecardScoreValue.setFrame(1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(imgShine);
         imgShine = null;
         ObjectUtils.disposeObject(_txtFivecardScoreName);
         _txtFivecardScoreName = null;
         ObjectUtils.disposeObject(_txtFivecardScoreValue);
         _txtFivecardScoreValue = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
         super.dispose();
      }
   }
}

