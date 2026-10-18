package treasurehunt
{
   import com.pickgliss.instance.IManualSize;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import yishi.keyboard.KeyBoardRegister;
   import yishi.manager.FrameControllerManager;
   
   public class HunterDialogFrame extends Component implements IManualSize
   {
      
      public var content:String;
      
      private var _callBack:Function;
      
      private var _back:Scale9CornerImage;
      
      private var _arror:Bitmap;
      
      private var _icon:MovieClip;
      
      private var _content:FilterFrameText;
      
      private var _configmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      public function HunterDialogFrame()
      {
         super();
         initView();
         initEvent();
      }
      
      public function get viewRectangle() : Rectangle
      {
         return new Rectangle(0,0,430,130);
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.RoleDialogBack");
         _arror = ComponentFactory.Instance.creatBitmap("asset.core.RoleDialogArror");
         _icon = ComponentFactory.Instance.creatCustomObject("treasurehunt.femaleRoleHead");
         _content = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.Trailmap.DialogContent");
         _configmBtn = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.Trailmap.DialogConfigmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("treasurehunt.Trailmap.DialogCancelBtn");
         addChild(_back);
         addChild(_icon);
         addChild(_arror);
         addChild(_content);
         addChild(_configmBtn);
         addChild(_cancelBtn);
      }
      
      private function initEvent() : void
      {
         _configmBtn.addEventListener("click",__confirmHandler);
         _cancelBtn.addEventListener("click",_cancelHandler);
      }
      
      private function removeEvent() : void
      {
         _configmBtn.removeEventListener("click",__confirmHandler);
         _cancelBtn.removeEventListener("click",_cancelHandler);
      }
      
      private function __confirmHandler(param1:MouseEvent) : void
      {
         if(_callBack != null)
         {
            _callBack(4);
         }
      }
      
      private function _cancelHandler(param1:MouseEvent) : void
      {
         FrameControllerManager.instance.treasureHuntControler.showAlerFrame();
         _callBack = null;
         dispose();
      }
      
      public function show(param1:Function) : void
      {
         _callBack = param1;
         _content.htmlText = content;
         _content.height = _content.numLines * 20;
         LayerManager.Instance.addToLayer(this,3,true,true,2);
         KeyBoardRegister.instance.keyEnable = false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         KeyBoardRegister.instance.keyEnable = true;
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_arror);
         _arror = null;
         ObjectUtils.disposeObject(_configmBtn);
         _configmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         _callBack = null;
         super.dispose();
      }
   }
}

