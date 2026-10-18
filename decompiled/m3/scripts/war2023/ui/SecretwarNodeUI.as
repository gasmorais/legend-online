package war2023.ui
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   
   public class SecretwarNodeUI extends Sprite
   {
      
      protected var _extBox:Bitmap;
      
      protected var _belongFt:Bitmap;
      
      protected var _scoreFt:Bitmap;
      
      protected var _stateFt:Bitmap;
      
      protected var _nodeBelogTxt:FilterFrameText;
      
      protected var _nodeStateTxt:FilterFrameText;
      
      protected var _nodeScoreTxt:FilterFrameText;
      
      protected var _mapNode1:Bitmap;
      
      protected var _house2:Bitmap;
      
      protected var _NodePlayNum:FilterFrameText;
      
      protected var _nodeOccNTxt:FilterFrameText;
      
      public function SecretwarNodeUI()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _extBox = ComponentFactory.Instance.creatBitmap("asset.secretwar.extBox");
         _belongFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.belongFt");
         _scoreFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.scoreFt");
         _stateFt = ComponentFactory.Instance.creatBitmap("asset.secretwar.stateFt");
         _nodeBelogTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeBelogTxt");
         _nodeStateTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeStateTxt");
         _nodeScoreTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeScoreTxt");
         _NodePlayNum = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.NodePlayNum");
         _nodeOccNTxt = ComponentFactory.Instance.creatComponentByStylename("ui.secretwar.nodeOccNTxt");
         _mapNode1 = new Bitmap();
         _house2 = new Bitmap();
         addChild(_extBox);
         addChild(_belongFt);
         addChild(_scoreFt);
         addChild(_stateFt);
         addChild(_nodeBelogTxt);
         addChild(_nodeStateTxt);
         addChild(_nodeScoreTxt);
         addChild(_mapNode1);
         addChild(_house2);
         addChild(_NodePlayNum);
         addChild(_nodeOccNTxt);
         _mapNode1.x = 2;
         _mapNode1.y = 12;
         _house2.x = 5;
         _house2.y = 34;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeObject(_extBox);
         _extBox = null;
         ObjectUtils.disposeObject(_belongFt);
         _belongFt = null;
         ObjectUtils.disposeObject(_scoreFt);
         _scoreFt = null;
         ObjectUtils.disposeObject(_stateFt);
         _stateFt = null;
         ObjectUtils.disposeObject(_nodeBelogTxt);
         _nodeBelogTxt = null;
         ObjectUtils.disposeObject(_nodeStateTxt);
         _nodeStateTxt = null;
         ObjectUtils.disposeObject(_nodeScoreTxt);
         _nodeScoreTxt = null;
         ObjectUtils.disposeObject(_NodePlayNum);
         _NodePlayNum = null;
         ObjectUtils.disposeObject(_nodeOccNTxt);
         _nodeOccNTxt = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

