package map.campaign.view.frame
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
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class TrailDialogFrame extends Component implements IManualSize
   {
      
      public var title:String;
      
      public var content:String;
      
      public var mapId:int;
      
      public var nodeId:int;
      
      private var _callBack:Function;
      
      private var _back:Scale9CornerImage;
      
      private var _arror:Bitmap;
      
      private var _icon:Bitmap;
      
      private var _name:FilterFrameText;
      
      private var _content:FilterFrameText;
      
      private var _configmBtn:IconButton;
      
      private var _cancelBtn:IconButton;
      
      public function TrailDialogFrame()
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
         _back = ComponentFactory.Instance.creatComponentByStylename("core.RoleDialogBack");
         _arror = ComponentFactory.Instance.creatBitmap("asset.core.RoleDialogArror");
         _icon = ComponentFactory.Instance.creatBitmap("asset.campaign.Trailmap.RoleHead");
         _name = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.DialogName");
         _content = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.DialogContent");
         _configmBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.DialogConfigmBtn");
         _cancelBtn = ComponentFactory.Instance.creatComponentByStylename("campaign.Trailmap.DialogCancelBtn");
         addChild(_back);
         addChild(_icon);
         addChild(_arror);
         addChild(_name);
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
            _callBack(true,mapId,nodeId);
         }
         _callBack = null;
         dispose();
      }
      
      private function _cancelHandler(param1:MouseEvent) : void
      {
         _callBack = null;
         dispose();
      }
      
      public function show(param1:Function) : void
      {
         _callBack = param1;
         _name.text = title;
         _content.text = content;
         LayerManager.Instance.addToLayer(this,3,true,true);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_name);
         _name = null;
         ObjectUtils.disposeObject(_arror);
         _arror = null;
         ObjectUtils.disposeObject(_configmBtn);
         _configmBtn = null;
         ObjectUtils.disposeObject(_cancelBtn);
         _cancelBtn = null;
         ObjectUtils.disposeObject(_content);
         _content = null;
         super.dispose();
      }
   }
}

