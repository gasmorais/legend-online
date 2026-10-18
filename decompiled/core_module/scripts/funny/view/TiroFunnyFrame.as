package funny.view
{
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.Frame;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.geom.Rectangle;
   import funny.FunnyEvent;
   import manager.LanguageMgr;
   import managers.FunnyManager;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.PlayerManager;
   
   public class TiroFunnyFrame extends Frame implements IManualSize
   {
      
      private var _back:Scale9CornerImage;
      
      private var _gridSplitLine:Bitmap;
      
      private var _leftBg:Bitmap;
      
      private var _leftView:TiroFunnyLeftView;
      
      private var _rightView:TiroRightView;
      
      public function TiroFunnyFrame()
      {
         super();
         FunnyManager.isOpenTiroFunnyFrame = true;
         initView();
         initEvent();
         initData();
      }
      
      private function initView() : void
      {
         titleText = LanguageMgr.GetTranslation("active.funny.TiroFunnyFrame.titleTxt");
         _back = ComponentFactory.Instance.creatComponentByStylename("funny.TiroFunnyFrameBack");
         _gridSplitLine = ComponentFactory.Instance.creatBitmap("asset.funny.gridSplitLine");
         _leftBg = ComponentFactory.Instance.creatBitmap("asset.funny.leftBg");
         _rightView = ComponentFactory.Instance.creatCustomObject("funny.TiroRightView");
         _leftView = ComponentFactory.Instance.creatCustomObject("funny.TiroLeftView");
         addToContent(_back);
         addToContent(_gridSplitLine);
         addToContent(_leftBg);
         addToContent(_leftView);
         addToContent(_rightView);
      }
      
      private function initEvent() : void
      {
         addEventListener("response",__frameResponse);
         FunnyManager.instance.addEventListener("REFRESH_ITEM",__refreshView);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("response",__frameResponse);
         FunnyManager.instance.removeEventListener("REFRESH_ITEM",__refreshView);
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,3,true,true);
         KeyBoardRegister.instance.keyEnable = false;
         if(PlayerManager.instance.currentPlayerModel.openActivityDay <= 7 && PlayerManager.instance.currentPlayerModel.openActivityDay > 0)
         {
            _leftView.locatedBtn(PlayerManager.instance.currentPlayerModel.openActivityDay);
         }
         else
         {
            _leftView.locatedBtn(1);
         }
      }
      
      private function initData() : void
      {
      }
      
      private function __refreshView(param1:FunnyEvent) : void
      {
         _leftView.refreshView();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         FunnyManager.instance.tiroFunnySelectedId = "";
         FunnyManager.isOpenTiroFunnyFrame = false;
         ObjectUtils.disposeObject(_back);
         ObjectUtils.disposeObject(_gridSplitLine);
         ObjectUtils.disposeObject(_leftBg);
         _rightView.dispose();
         _leftView.dispose();
         super.dispose();
         KeyBoardRegister.instance.keyEnable = true;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      private function __frameResponse(param1:FrameEvent) : void
      {
         switch(param1.responseCode)
         {
            case 0:
            case 1:
               dispose();
         }
      }
      
      override public function get groups() : Array
      {
         return ["CASTLE_BUIDING_GROUP","MAIN_TOOLS_GROUP"];
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,767,619);
      }
   }
}

