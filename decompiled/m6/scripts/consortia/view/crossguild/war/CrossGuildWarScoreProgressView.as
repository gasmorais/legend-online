package consortia.view.crossguild.war
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.utils.ObjectUtils;
   
   public class CrossGuildWarScoreProgressView extends Component
   {
      
      private var _barColor:ScaleFrameImage;
      
      private var _mask:Component;
      
      public function CrossGuildWarScoreProgressView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         _barColor = ComponentFactory.Instance.creatComponentByStylename("CrossGuildWarScoreProgressView.barColor");
         _mask = new Component();
         _mask.graphics.beginFill(16777215,0);
         _mask.graphics.drawRect(0,0,_barColor.width,_barColor.height);
         _mask.graphics.endFill();
         _mask.x = _barColor.x;
         _mask.y = _barColor.y;
         _barColor.mask = _mask;
         addChild(_barColor);
         addChild(_mask);
         _barColor.setFrame(1);
      }
      
      public function refreshView(param1:int, param2:int) : void
      {
         var _loc3_:Number = _barColor.width * param1 / param2;
         _mask.graphics.clear();
         _mask.graphics.beginFill(16711680,0);
         _mask.graphics.drawRect(0,0,_loc3_,_barColor.height);
         _mask.graphics.endFill();
         if(param1 / param2 <= 0.3333333333333333)
         {
            _barColor.setFrame(3);
         }
         else if(param1 / param2 <= 0.6666666666666666)
         {
            _barColor.setFrame(2);
         }
         else
         {
            _barColor.setFrame(1);
         }
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_barColor);
         _barColor = null;
         ObjectUtils.disposeObject(_mask);
         _mask = null;
         super.dispose();
      }
   }
}

