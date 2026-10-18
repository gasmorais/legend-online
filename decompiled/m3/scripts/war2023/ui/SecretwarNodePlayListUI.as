package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarNodePlayListUI extends Sprite
   {
      
      protected var _extTitleBg:Bitmap;
      
      protected var _nodeRedTTxt:FilterFrameText;
      
      protected var _nodeBlueTTxt:FilterFrameText;
      
      protected var _nodeSpanel:ScrollPanel;
      
      protected var _nodeInTTxt:FilterFrameText;
      
      protected var _nodeVbox:VBox;
      
      protected var _nodeTLNameTxt:FilterFrameText;
      
      protected var _nodeTLStateTxt:FilterFrameText;
      
      protected var _nodeTRNameTxt:FilterFrameText;
      
      protected var _nodeTRStateTxt:FilterFrameText;
      
      protected var _nodelistTbg:Image;
      
      protected var _cantInfo:FilterFrameText;
      
      public function SecretwarNodePlayListUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _extTitleBg = ComponentFactory.Instance.creatBitmap("asset.secretwar.extTitleBg");
         _nodeRedTTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeRedTTxt");
         _nodeBlueTTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeBlueTTxt");
         _nodeSpanel = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeSpanel");
         _nodeInTTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeInTTxt");
         _nodeVbox = ComponentFactory.Instance.creatCustomObject("ui.secretwar.nodeVbox");
         _nodeTLNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeTLNameTxt");
         _nodeTLStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeTLStateTxt");
         _nodeTRNameTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeTRNameTxt");
         _nodeTRStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeTRStateTxt");
         _nodelistTbg = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodelistTbg");
         _cantInfo = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.cantInfo");
         addChild(_extTitleBg);
         addChild(_nodeRedTTxt);
         addChild(_nodeBlueTTxt);
         addChild(_nodeSpanel);
         addChild(_nodeInTTxt);
         addChild(_nodelistTbg);
         addChild(_nodeTLNameTxt);
         addChild(_nodeTLStateTxt);
         addChild(_nodeTRNameTxt);
         addChild(_nodeTRStateTxt);
         addChild(_cantInfo);
         _nodeSpanel.setView(_nodeVbox);
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_extTitleBg);
         _extTitleBg = null;
         ObjectUtils.disposeObject(_nodeRedTTxt);
         _nodeRedTTxt = null;
         ObjectUtils.disposeObject(_nodeBlueTTxt);
         _nodeBlueTTxt = null;
         ObjectUtils.disposeObject(_nodeInTTxt);
         _nodeInTTxt = null;
         ObjectUtils.disposeObject(_nodeVbox);
         _nodeVbox = null;
         ObjectUtils.disposeObject(_nodeSpanel);
         _nodeSpanel = null;
         ObjectUtils.disposeObject(_nodeTLNameTxt);
         _nodeTLNameTxt = null;
         ObjectUtils.disposeObject(_nodeTLStateTxt);
         _nodeTLStateTxt = null;
         ObjectUtils.disposeObject(_nodeTRNameTxt);
         _nodeTRNameTxt = null;
         ObjectUtils.disposeObject(_nodeTRStateTxt);
         _nodeTRStateTxt = null;
         ObjectUtils.disposeObject(_nodelistTbg);
         _nodelistTbg = null;
         ObjectUtils.disposeObject(_cantInfo);
         _cantInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

