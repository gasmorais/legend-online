package register
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class HeadComp extends Component
   {
      
      private var _bg:Bitmap;
      
      private var _selectedBg:Bitmap;
      
      private var _lightBg:Bitmap;
      
      private var _head:Bitmap;
      
      private var _container:Sprite;
      
      private var _selected:Boolean = false;
      
      public var headId:int;
      
      private var _clickRecall:Function;
      
      public function HeadComp(param1:int, param2:Function)
      {
         headId = param1;
         _clickRecall = param2;
         super();
      }
      
      override protected function init() : void
      {
         _bg = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.headBg" + headId);
         _head = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.head" + headId);
         _selectedBg = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.selectedBg" + headId);
         _lightBg = ComponentFactory.Instance.creatBitmap("asset.mainloadingii.register.lightBg" + headId);
         _container = new Sprite();
         addChild(_container);
         addChild(_selectedBg);
         _selectedBg.x = -15;
         _selectedBg.y = -16;
         addChild(_lightBg);
         _lightBg.x = -145;
         _lightBg.y = 120;
         _container.addChild(_bg);
         _container.addChild(_head);
         _container.scaleX = 0.65;
         _container.scaleY = 0.65;
         _bg.smoothing = true;
         _head.smoothing = true;
         _selectedBg.visible = false;
         _lightBg.visible = false;
         this.buttonMode = true;
         initEvent();
      }
      
      public function set selected(param1:Boolean) : void
      {
         if(param1)
         {
            _container.scaleX = _container.scaleY = 1;
            _container.x = -30;
            _container.y = -45;
            _selectedBg.visible = false;
            _lightBg.visible = true;
            this.mouseEnabled = this.mouseChildren = false;
         }
         else
         {
            _container.scaleX = _container.scaleY = 0.65;
            _container.x = 0;
            _container.y = 0;
            _lightBg.visible = false;
            this.mouseEnabled = this.mouseChildren = true;
         }
         _selected = param1;
      }
      
      private function initEvent() : void
      {
         this.addEventListener("click",clickHandler);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outHandler);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("click",clickHandler);
         removeEventListener("mouseOver",__overHandler);
         removeEventListener("mouseOut",__outHandler);
      }
      
      private function __overHandler(param1:MouseEvent) : void
      {
         if(_selected)
         {
            _selectedBg.visible = false;
         }
         else
         {
            _selectedBg.visible = true;
         }
      }
      
      private function __outHandler(param1:MouseEvent) : void
      {
         _selectedBg.visible = false;
      }
      
      protected function clickHandler(param1:MouseEvent) : void
      {
         _clickRecall.call(this,param1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_selectedBg);
         _selectedBg = null;
         ObjectUtils.disposeObject(_lightBg);
         _lightBg = null;
         ObjectUtils.disposeObject(_head);
         _head = null;
         ObjectUtils.disposeObject(_container);
         _container = null;
         _clickRecall = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

