package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarNodePlayInfoUI extends Sprite
   {
      
      protected var _extInfoBg:Bitmap;
      
      protected var _nodePlayTLNameTxt:FilterFrameText;
      
      protected var _nodePlayTLStateTxt:FilterFrameText;
      
      protected var _nodePlayTRNameTxt:FilterFrameText;
      
      protected var _nodePlayTRStateTxt:FilterFrameText;
      
      public function SecretwarNodePlayInfoUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _extInfoBg = ComponentFactory.Instance.creatBitmap("asset.secretwar.extInfoBg");
         _nodePlayTLNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodePlayTLNameTxt");
         _nodePlayTLStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodePlayTLStateTxt");
         _nodePlayTRNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodePlayTRNameTxt");
         _nodePlayTRStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodePlayTRStateTxt");
         addChild(_extInfoBg);
         addChild(_nodePlayTLNameTxt);
         addChild(_nodePlayTLStateTxt);
         addChild(_nodePlayTRNameTxt);
         addChild(_nodePlayTRStateTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_extInfoBg);
         _extInfoBg = null;
         ObjectUtils.disposeObject(_nodePlayTLNameTxt);
         _nodePlayTLNameTxt = null;
         ObjectUtils.disposeObject(_nodePlayTLStateTxt);
         _nodePlayTLStateTxt = null;
         ObjectUtils.disposeObject(_nodePlayTRNameTxt);
         _nodePlayTRNameTxt = null;
         ObjectUtils.disposeObject(_nodePlayTRStateTxt);
         _nodePlayTRStateTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

