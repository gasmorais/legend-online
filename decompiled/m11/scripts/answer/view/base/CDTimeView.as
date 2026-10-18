package answer.view.base
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.MutipleImage;
   import com.pickgliss.ui.text.GradientText;
   import com.pickgliss.utils.ObjectUtils;
   import yishi.utils.DateFormatter;
   import yishi.utils.TimerUtils;
   
   public class CDTimeView extends Component
   {
      
      private const _timeName:String = "cdtimename";
      
      private var _bg:MutipleImage;
      
      private var _downTimeTxt:GradientText;
      
      private var _totalTime:int;
      
      private var _callFunc:Function;
      
      private var _info:String = "";
      
      private var _startImg:Image;
      
      public function CDTimeView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         this.mouseEnabled = this.mouseChildren = false;
         _downTimeTxt = ComponentFactory.Instance.creatComponentByStylename("answer.view.startTime_txt");
         _bg = ComponentFactory.Instance.creatComponentByStylename("answer.view.CountDownViewBg");
         addChild(_bg);
         _startImg = ComponentFactory.Instance.creatComponentByStylename("answer.view.startBg");
         addChild(_startImg);
         addChild(_downTimeTxt);
         _downTimeTxt.x = _startImg.x + _startImg.width + 2;
      }
      
      public function setData(param1:int = 60, param2:Function = null) : void
      {
         TimerUtils.removeSecendTimer("cdtimename");
         TimerUtils.addSecendTimer("cdtimename",1,param1,refreshView);
         _totalTime = param1;
         refreshTime(param1);
      }
      
      private function refreshView() : void
      {
         _totalTime = TimerUtils.getTime("cdtimename");
         refreshTime(_totalTime);
      }
      
      private function refreshTime(param1:int) : void
      {
         var _loc2_:String = null;
         _loc2_ = DateFormatter.getCountDateByMS(param1);
         _downTimeTxt.text = _loc2_;
      }
      
      public function show() : void
      {
         LayerManager.Instance.addToLayer(this,9,true,true);
      }
      
      public function hide() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
      }
      
      override public function dispose() : void
      {
         _callFunc = null;
         if(_bg)
         {
            _bg.dispose();
         }
         _bg = null;
         TimerUtils.removeSecendTimer("cdtimename");
         if(_downTimeTxt)
         {
            _downTimeTxt.dispose();
         }
         _downTimeTxt = null;
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

