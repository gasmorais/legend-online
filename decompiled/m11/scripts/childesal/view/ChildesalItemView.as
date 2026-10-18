package childesal.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   
   public class ChildesalItemView extends Sprite implements Disposeable
   {
      
      private var _openClick:Boolean;
      
      private var _choseBack:Bitmap;
      
      private var _itemBack:ScaleFrameImage;
      
      private var _itemEffect:MovieClip;
      
      private var _indexId:int;
      
      public var cell:Function;
      
      public function ChildesalItemView()
      {
         super();
         initView();
         addEvent();
         this.buttonMode = false;
      }
      
      public function set isChose(param1:Boolean) : void
      {
         _choseBack.visible = param1;
         _itemEffect.visible = param1;
      }
      
      public function get indexId() : int
      {
         return _indexId;
      }
      
      public function set indexId(param1:int) : void
      {
         _indexId = param1;
         _itemBack.setFrame(_indexId);
      }
      
      public function set openClick(param1:Boolean) : void
      {
         _openClick = param1;
         if(_openClick)
         {
            this.buttonMode = true;
         }
      }
      
      private function initView() : void
      {
         _choseBack = ComponentFactory.Instance.creatBitmap("asset.childesal.gatIcon");
         _itemBack = ComponentFactory.Instance.creatComponentByStylename("childesal.landNodeImage");
         _itemEffect = ComponentFactory.Instance.creatCustomObject("asset.childesal.itemEffect");
         addChild(_choseBack);
         addChild(_itemBack);
         addChild(_itemEffect);
         _itemEffect.mouseChildren = _itemEffect.mouseEnabled = false;
      }
      
      private function addEvent() : void
      {
         _itemBack.addEventListener("click",__onClickHandler);
      }
      
      private function __onClickHandler(param1:MouseEvent) : void
      {
         if(_openClick && cell != null)
         {
            cell(_indexId);
         }
      }
      
      private function removeEvent() : void
      {
         if(_itemBack)
         {
            _itemBack.removeEventListener("click",__onClickHandler);
         }
      }
      
      override public function get height() : Number
      {
         return 60;
      }
      
      override public function get width() : Number
      {
         return 65;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_choseBack);
         _choseBack = null;
         ObjectUtils.disposeObject(_itemBack);
         _itemBack = null;
         ObjectUtils.disposeViolentMc(_itemEffect);
         _itemEffect = null;
         cell = null;
         _indexId = 0;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

