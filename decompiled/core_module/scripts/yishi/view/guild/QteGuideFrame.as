package yishi.view.guild
{
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.IconButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Scale9CornerImage;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   
   public class QteGuideFrame extends Component
   {
      
      private var _offset:Point;
      
      private var _bg:Scale9CornerImage;
      
      private var _headIcon:Bitmap;
      
      private var _contentMC:MovieClip;
      
      private var _closeBtn:IconButton;
      
      private var _target:DisplayObject;
      
      private var _callback:Function;
      
      public function QteGuideFrame(param1:String, param2:Point, param3:Function = null, param4:DisplayObject = null)
      {
         super();
         _callback = param3;
         _offset = param2;
         initView(param1);
         _target = param4;
         initEvent();
      }
      
      private function initEvent() : void
      {
         _closeBtn.addEventListener("click",__onClick);
         addEventListener("added",__onAdded);
         StageReferance.stage.addEventListener("resize",__onStageResize,false,-10);
      }
      
      private function removeEvent() : void
      {
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__onClick);
         }
         StageReferance.stage.removeEventListener("resize",__onStageResize);
         removeEventListener("added",__onAdded);
      }
      
      private function __onAdded(param1:Event) : void
      {
         removeEventListener("added",__onAdded);
         __onStageResize();
      }
      
      private function initView(param1:String) : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("novice.FrameBack01");
         _headIcon = ComponentFactory.Instance.creatBitmap("asset.novice.DialogIcon");
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("asset.novice.close");
         _contentMC = ComponentFactory.Instance.creatCustomObject(param1);
         _bg.width = int(_contentMC.width + 195);
         _bg.height = int(_contentMC.height + 75);
         if(_bg.width < 356)
         {
            _bg.width = 356;
         }
         if(_bg.height < 67)
         {
            _bg.height = 67;
         }
         _bg.x = 0;
         _bg.y = _headIcon.y + _headIcon.height - _bg.height;
         _contentMC.x = _headIcon.x + _headIcon.width - 14;
         _contentMC.y = _bg.y + 21;
         _closeBtn.x = _bg.x + (_bg.width - _closeBtn.width) / 2 + 39;
         _closeBtn.y = _contentMC.y + _contentMC.height + 9;
         addChild(_bg);
         addChild(_contentMC);
         addChild(_headIcon);
         addChild(_closeBtn);
      }
      
      private function __onStageResize(param1:Event = null) : void
      {
         var _loc2_:Point = null;
         if(this.parent == null)
         {
            addEventListener("added",__onAdded);
            return;
         }
         if(_target)
         {
            _loc2_ = _target.localToGlobal(new Point(0,0));
            _loc2_ = parent.globalToLocal(_loc2_);
            x = _loc2_.x - (width - _target.width) * 0.5 + _offset.x;
            y = _loc2_.y + _target.height + _offset.y;
            return;
         }
         var _loc3_:Number = StageReferance.stageWidth;
         var _loc4_:Number = StageReferance.stageHeight;
         x = (StageReferance.stageWidth - this.width) * 0.5 + _offset.x;
         y = (StageReferance.stageHeight - this.height) * 0.5 + _offset.y;
         if(this.x + this.width > _loc3_)
         {
            this.x = _loc3_ - this.width - 10;
         }
         if(this.y + this.height > _loc4_)
         {
            this.y = _loc4_ - this.height - 10;
         }
      }
      
      private function __onClick(param1:MouseEvent) : void
      {
         if(_callback != null)
         {
            _callback();
         }
         dispose();
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeViolentMc(_contentMC);
         _contentMC = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_headIcon);
         _headIcon = null;
         ObjectUtils.disposeObject(_closeBtn);
         _closeBtn = null;
         if(this.parent)
         {
            this.parent.removeChild(this);
         }
         _target = null;
         _callback = null;
      }
   }
}

