package funny.regression
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import manager.LanguageMgr;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   import yishi.manager.TaskManage;
   
   public class RegressionView extends Component implements IManualSize
   {
      
      private var _back:MutipleImage;
      
      private var _btn:IconButton;
      
      private var _describe:FilterFrameText;
      
      public function RegressionView()
      {
         super();
         initview();
         initEvent();
      }
      
      private function initview() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("RegressionView.back");
         _btn = ComponentFactory.Instance.creatComponentByStylename("RegressionView.btn");
         _describe = ComponentFactory.Instance.creatComponentByStylename("RegressionView.describe");
         _describe.htmlText = LanguageMgr.GetTranslation("funny.regression.RegressionView.describe");
         addChild(_back);
         addChild(_btn);
         addChild(_describe);
      }
      
      private function initEvent() : void
      {
         _btn.addEventListener("click",__clickHandler);
      }
      
      protected function __clickHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.openControllerByInfo("funny");
         TaskManage.instance.requestCanAcceptTask();
         dispose();
      }
      
      private function removeEvent() : void
      {
         if(_btn)
         {
            _btn.removeEventListener("click",__clickHandler);
         }
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true,1);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,465,186);
      }
      
      override public function dispose() : void
      {
         KeyBoardRegister.instance.keyEnable = true;
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_btn);
         _btn = null;
         ObjectUtils.disposeObject(_describe);
         _describe = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

