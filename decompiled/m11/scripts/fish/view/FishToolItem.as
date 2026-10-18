package fish.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.SoundManager;
   import fish.mediator.FishToolItemClickMediator;
   import flash.display.Bitmap;
   import flash.events.MouseEvent;
   import managers.FishManager;
   import mvc.module.fish.FishModel;
   import yishi.manager.MediatorMananger;
   
   public class FishToolItem extends Component
   {
      
      public static const NAME:String = "fish.view.FishToolItem";
      
      private var _toolId:int;
      
      private var _count:int;
      
      private var _back:Bitmap;
      
      private var _fishTool:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _registed:Boolean;
      
      protected var _mediatorKey:String;
      
      public function FishToolItem(param1:int)
      {
         _toolId = param1;
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.fish.fishTollBack");
         _fishTool = ComponentFactory.Instance.creatBitmap("asset.fish.fishToll" + _toolId);
         _countTxt = ComponentFactory.Instance.creatComponentByStylename("fish.fishToll.countTxt");
         addChild(_back);
         addChild(_fishTool);
         addChild(_countTxt);
         refreshView();
      }
      
      private function initEvent() : void
      {
      }
      
      private function buyGoodsHandlerBack(param1:Boolean) : void
      {
         SoundManager.instance.play("022");
         var _loc2_:int = param1 ? 2 : 1;
      }
      
      public function set count(param1:int) : void
      {
         if(_count == param1)
         {
            return;
         }
         _count = param1;
         refreshView();
      }
      
      public function refreshView() : void
      {
         if(_count == 0)
         {
            buttonMode = false;
            _countTxt.text = "";
            _fishTool.alpha = 0.5;
            if(_registed)
            {
               _registed = false;
               unregisterMediator();
            }
         }
         else
         {
            buttonMode = true;
            _countTxt.text = _count + "";
            _fishTool.alpha = 1;
            if(!_registed)
            {
               registerMediator();
            }
         }
      }
      
      protected function registerMediator() : void
      {
         _registed = true;
         var _loc1_:Array = [FishToolItemClickMediator];
         _mediatorKey = MediatorMananger.instance.registerMediatorList(_loc1_,this,"fish.view.FishToolItem");
      }
      
      protected function unregisterMediator() : void
      {
         MediatorMananger.instance.unregisterMediatorList(_mediatorKey,this);
      }
      
      private function __clickHandler(param1:MouseEvent) : void
      {
         FishManager.instance.fishAction(5,[_toolId]);
      }
      
      private function get model() : FishModel
      {
         return FishManager.instance.model;
      }
      
      private function removeEvent() : void
      {
      }
      
      public function get toolId() : int
      {
         return _toolId;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         unregisterMediator();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_fishTool);
         _fishTool = null;
         ObjectUtils.disposeObject(_countTxt);
         _countTxt = null;
         ObjectUtils.disposeAllChildren(this);
         super.dispose();
      }
      
      public function get count() : int
      {
         return _count;
      }
   }
}

