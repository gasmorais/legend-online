package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarTopUI extends Sprite
   {
      
      protected var _topback:Bitmap;
      
      protected var _topLScoreTxt:FilterFrameText;
      
      protected var _topRScoreTxt:FilterFrameText;
      
      protected var _topLjdTxt:FilterFrameText;
      
      protected var _topLpnTxt:FilterFrameText;
      
      protected var _topRjdTxt:FilterFrameText;
      
      protected var _topRpnTxt:FilterFrameText;
      
      protected var _reiverFt:Bitmap;
      
      protected var _topriverTxt:FilterFrameText;
      
      protected var _timeCdTxt:FilterFrameText;
      
      public function SecretwarTopUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _topback = ComponentFactory.Instance.creatBitmap("asset.secretwar.topback");
         _topLScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topLScoreTxt");
         _topRScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topRScoreTxt");
         _topLjdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topLjdTxt");
         _topLpnTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topLpnTxt");
         _topRjdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topRjdTxt");
         _topRpnTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topRpnTxt");
         _reiverFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.reiverFt");
         _topriverTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.topriverTxt");
         _timeCdTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwarTop.timeCdTxt");
         addChild(_topback);
         addChild(_topLScoreTxt);
         addChild(_topRScoreTxt);
         addChild(_topLjdTxt);
         addChild(_topLpnTxt);
         addChild(_topRjdTxt);
         addChild(_topRpnTxt);
         addChild(_reiverFt);
         addChild(_topriverTxt);
         addChild(_timeCdTxt);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_topback);
         _topback = null;
         ObjectUtils.disposeObject(_topLScoreTxt);
         _topLScoreTxt = null;
         ObjectUtils.disposeObject(_topRScoreTxt);
         _topRScoreTxt = null;
         ObjectUtils.disposeObject(_topLjdTxt);
         _topLjdTxt = null;
         ObjectUtils.disposeObject(_topLpnTxt);
         _topLpnTxt = null;
         ObjectUtils.disposeObject(_topRjdTxt);
         _topRjdTxt = null;
         ObjectUtils.disposeObject(_topRpnTxt);
         _topRpnTxt = null;
         ObjectUtils.disposeObject(_reiverFt);
         _reiverFt = null;
         ObjectUtils.disposeObject(_topriverTxt);
         _topriverTxt = null;
         ObjectUtils.disposeObject(_timeCdTxt);
         _timeCdTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

