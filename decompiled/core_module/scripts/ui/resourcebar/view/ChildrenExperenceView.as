package ui.resourcebar.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import flash.display.Bitmap;
   import flash.display.Shape;
   import mvc.module.children.ChildData;
   
   public class ChildrenExperenceView extends Component
   {
      
      private var _expProgress:ScaleFrameImage;
      
      private var _expProgressBg:Bitmap;
      
      private var _mask:Shape;
      
      private var _maskBegin_x:int;
      
      private var _data:ChildData;
      
      private var _percent:Number;
      
      public function ChildrenExperenceView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _expProgressBg = ComponentFactory.Instance.creatBitmap("asset.resourcesBar.PetExpProgressBg");
         _expProgress = ComponentFactory.Instance.creatComponentByStylename("resourcesBar.ChildrenExpProgress");
         addChild(_expProgressBg);
         addChild(_expProgress);
         _expProgress.setFrame(1);
         _mask = createShape();
         addChild(_mask);
         _expProgress.mask = _mask;
      }
      
      private function createShape() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(16777215,1);
         _loc1_.graphics.drawRect(_expProgress.x,_expProgress.y,_expProgress.width,_expProgress.height);
         _loc1_.graphics.endFill();
         _maskBegin_x = _expProgress.width * -1;
         return _loc1_;
      }
      
      private function refreshView() : void
      {
         if(_data)
         {
            _percent = _data.childPower / 120;
            if(_percent > 1)
            {
               _percent = 1;
            }
            _mask.x = _maskBegin_x + _mask.width * _percent;
            if(_data.job > 0)
            {
               _expProgress.setFrame(_data.job);
            }
            else
            {
               _expProgress.setFrame(2);
            }
         }
         else
         {
            _percent = 0;
            _mask.x = _maskBegin_x + _mask.width * _percent;
            this.tipData = "";
         }
      }
      
      private function toArialBold(param1:String) : String
      {
         return "<font face=\'Arial\'>" + param1 + "</font>";
      }
      
      public function set data(param1:ChildData) : void
      {
         _data = param1;
         refreshView();
      }
   }
}

