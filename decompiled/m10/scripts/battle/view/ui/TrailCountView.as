package battle.view.ui
{
   import battle.BattleManager;
   import battle.events.BattleEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import yishi.datas.BattleModel;
   import yishi.utils.NumberViewUtils;
   
   public class TrailCountView extends Sprite implements Disposeable
   {
      
      private var _back:Bitmap;
      
      private var _countDownValue:Sprite;
      
      public function TrailCountView()
      {
         super();
         initView();
         initEvent();
         refreshView();
      }
      
      private function initView() : void
      {
         _back = ComponentFactory.Instance.creatBitmap("asset.battle.TrailLayerBack");
         addChild(_back);
         _back.y = 10;
         _countDownValue = new Sprite();
         _countDownValue.y = 21;
         _countDownValue.x = 43;
         addChild(_countDownValue);
      }
      
      private function initEvent() : void
      {
         model.addEventListener("TRAIL_LAYER_CHANGE",__layerChangeHandler);
      }
      
      private function removeEvent() : void
      {
         if(model)
         {
            model.removeEventListener("TRAIL_LAYER_CHANGE",__layerChangeHandler);
         }
      }
      
      private function __layerChangeHandler(param1:BattleEvent) : void
      {
         refreshView();
      }
      
      private function refreshView() : void
      {
         var _loc1_:Bitmap = null;
         _loc1_ = ComponentFactory.Instance.creatBitmap("asset.core.number_img_09");
         NumberViewUtils.getNumberView(model.trialLayer,_countDownValue,_loc1_.bitmapData,15,19,15,15,"0123456789.",1);
         _countDownValue.x = 27 + (36 - _countDownValue.width) / 2;
         ObjectUtils.disposeObject(_loc1_);
      }
      
      override public function get width() : Number
      {
         return 123;
      }
      
      private function get model() : BattleModel
      {
         return BattleManager.getInstance().battleModel;
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.removeChildAllChildren(_countDownValue);
         _countDownValue = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}

