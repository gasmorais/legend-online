package views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.MouseEvent;
   import yishi.utils.IconFactory;
   import yishi.view.community.BaseIconView;
   
   public class NewModuleOpenPopView extends Component
   {
      
      private var _bg:MutipleImage;
      
      private var _icon:BaseIconView;
      
      private var _openBtn:TextButton;
      
      private var _callback:Function;
      
      private var _callArgs:Array;
      
      public function NewModuleOpenPopView()
      {
         super();
         initView();
         addEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("novice.NewOpenMultiBg");
         _icon = ComponentFactory.Instance.creatCustomObject("novice.NewOpenIcon");
         _openBtn = ComponentFactory.Instance.creatComponentByStylename("novice.NewOpenBtn");
         addChild(_bg);
         addChild(_icon);
         addChild(_openBtn);
      }
      
      private function addEvent() : void
      {
         addEventListener("click",__onOpenClick);
      }
      
      private function removeEvent() : void
      {
         removeEventListener("click",__onOpenClick);
      }
      
      private function __onOpenClick(param1:MouseEvent) : void
      {
         _openBtn.mouseEnabled = false;
         if(_callback != null)
         {
            _callback.apply(null,_callArgs);
         }
         _callback = null;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,0,true,true);
      }
      
      public function set icon(param1:String) : void
      {
         _icon.icon = IconFactory.getModuleIcon(param1);
      }
      
      public function set btnText(param1:String) : void
      {
         _openBtn.text = param1;
      }
      
      public function set callback(param1:Function) : void
      {
         _callback = param1;
      }
      
      public function set callArgs(param1:Array) : void
      {
         _callArgs = param1;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         ObjectUtils.disposeObject(_openBtn);
         _openBtn = null;
         _callback = null;
         _callArgs = null;
         super.dispose();
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

